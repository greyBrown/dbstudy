/*
조인
1. 조회할 때 필요한 칼럼이 2개 이상의 테이블에 존재할 때 조인을 사용한다.
2. 조인 조건을 이용해서 각 테이블의 조인한다. (조인조건을 잘 만드는게 중요하다는 뜻...^^)
3. 조인 종류
    1) 내부 조인 : 조회할 테이블에 모두 존재하는 데이터를 대상으로 조인
    2) 외부 조인 : 어느 한 테이블에만 존재하는 데이터를 조회 대상에 포함
*/
/*
내부 조인(INNER JOIN)
1. 조인하는 두 테이블의 모두 존재하는 데이터만 조회된다.
2. 어느 한 테이블에만 존재하는 데이터는 조회되지 않는다.
3. ANSI 문법
    SELECT 조회할 칼럼,...
    FROM 테이블1 INNER JOIN 테이블2
     ON 조인조건
*/
--1. 사원번호, 사원명, 부서번호, 부서명을 조회하시오.
SELECT E.EMP_NO, E.NAME, E.DEPART, D.DEPT_NAME
FROM DEPARTMENT_T D INNER JOIN EMPLOYEE_T E
    ON D.DEPT_NO=E.DEPART;           --순서대로 온거임 디파트먼저 임플로이 다음                      --아닌 경우도 10% 있지만 90%는 조인조건 PK = FK 해주면 됨...일반적으로 이런식이기 때문에...
    
SELECT EMP_NO, NAME, DEPART, DEPT_NAME
FROM EMPLOYEE_T  INNER JOIN DEPARTMENT_T                 --부서번호 3, 4 번은 조회가 안됨? 왜? 한쪽 테이블에만 존재하니까!
    ON DEPART=DEPT_NO;                                      --GH FROM JOIN 테이블 순서 거꾸로 해봄. 문제없음~! 프롬이너-온 이 순서가 중요!
    
--조인에서는 테이블 별명 사용합니다! 테이블이 계속 나오기 때문이죠... 조인할 때는...별명 붙여주자!

--2. 부서별 평균연봉을 조회하시오. 부서명과 평균연봉을 조회하시오.
SELECT D.DEPT_NAME, AVG(E.SALARY)
FROM DEPARTMENT_T D INNER JOIN EMPLOYEE_T E
ON D.DEPT_NO=E.DEPART
GROUP BY D.DEPT_NAME;

--순서..바뀌어도 상관없어요! 하지만 권장되는 순서는 있다! 상기의 경우 D가 앞, E가 뒤인게 좋다.
--FROM PK INNER JOIN FK 이렇게 주는게 좋다! PK를 좌측(앞)에 두고, FK 를 우측(뒤)에 둬라. 그게 성능상 좋다! 인덱스 때문. PK에 기본적으로 인덱스가 생성된다. 그래서 빨롸. 유니크에도 기본적으로 생성된다.
--좌측에 있는게 검색할 칼럼, 우측에 오는게 값이라서....그래서 PK를 먼저 두라는 거~
--좌측(드라이브 테이블) 우측(드리븐 테이블) 어쨋든 결론 PK를 앞에.

--3, 4개짜리 할 때 순서 잘 못정하는데 일단 디립따 적어봐여....^^

/*
외부 조인(OUTER JOIN)
1. 어느 한 테이블에만 존재하는 데이터도 조회된다.
2. 해당 테이블이 왼쪽에 있으면 왼쪽 외부조인이고 오른쪽에 있으면 오른쪽 외부조인이다.  --조인 기준으로 어느쪽에 있냐는 말
3. ANSI 문법
    1) 왼쪽 외부조인
    SELECT 조회할 칼럼,...
    FROM 테이블1 LEFT [OUTER] JOIN 테이블2
     ON 조인조건
    2) 오른쪽 외부조인
    SELECT 조회할 칼럼,...
    FROM 테이블1 RIGHT [OUTER] JOIN 테이블2
     ON 조인조건
*/

-- 외부 조인 확인을 위한 데이터 입력
INSERT INTO EMPLOYEE_T (
    EMP_NO
    , NAME
    , DEPART
    , POSITION
    , GENDER
    , HIRE_DATE
    , SALARY
) VALUES(
      EMPLOYEE_SEQ.NEXTVAL
    , '홍길동'
    ,  NULL
    , '회장'
    , 'F'
    , '00/01/01'
    , 10000000
);
COMMIT;            --DML(인서트 업데이트 딜리트) 커밋이 필요한 3개의 쿼리문!

--1. 모든 사원들의 사원번호, 사원명, 부서명을 조회하시오.
SELECT E.EMP_NO, E.NAME, D.DEPT_NAME                                         --이너 조인은 홍길동을 보여주지 않음. NULL값이라서! 이걸 보여줄려면 외부조인.
FROM DEPARTMENT_T D RIGHT JOIN EMPLOYEE_T E                                  --가져와야 할 대상이 오른쪽에 있으니 RIGHT JOIN
ON D.DEPT_NO=E.DEPART;

--2. 부서별 사원수를 조회하시오. 사원이 없으면 0으로 조회(부서명, 사원수 조회)     --이거 티적!!
SELECT D.DEPT_NAME, COUNT(EMP_NO)                                           --COUNT 때문에 잘못된 답이 나옴. *쓰면 안됨!*는 NULL까지 카운트를 넣어버림. PK인 EMP_NO를 넣으면 원하는대로 작동하는 것을 볼 수 있음.
FROM DEPARTMENT_T D LEFT JOIN EMPLOYEE_T E
ON D.DEPT_NO=E.DEPART
GROUP BY D.DEPT_NAME;
     
