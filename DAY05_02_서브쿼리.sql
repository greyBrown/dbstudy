/* 
   서브 쿼리
   1. 메인 쿼리에 포함되는 하위 쿼리를 서브 쿼리라고 한다.
   2. 실행 순서
        서브 쿼리 ->메인 쿼리
   3. 종류
        1) SELELCT 절 : 스칼라 서브쿼리 
        2)     FROM절 : 인라인 뷰
        3)    WHERE절 : 서브 쿼리 
               (1) 단일 행 서브쿼리 (결과 행이 1행)
               (2) 다중 행 서브쿼리 (결과 행이 N행)
*/

/*
단일 행 서브쿼리
1. 서브쿼리의 실행결과가 1행이다.
2. 단일 행 서브쿼리인 경우
    1) 함수 결과를 반환하는 서브쿼리
    2) PK 또는 UNIQUE 칼럼의 동등비교 조건을 사용한 쿼리
3. 단일 행 서브 쿼리 연산자
    =, !=, >, >=, ,, ,+
*/

--1. 사원번호가 1004인 사원의 직책을 가진 사원 조회하기 //1004 사원이 아니라 그가 가진 직책을 가진 모든 사원 조회
SELECT *
FROM EMPLOYEE_T
WHERE POSITION = (SELECT POSITION 
                    FROM EMPLOYEE_T
                   WHERE EMP_NO =1004);                      --그 때 rowid 사용한 그 구조
                   
--2. 급여 평균보다 더 큰 급여를 받는 사원 조회하기
SELECT *
FROM EMPLOYEE_T
WHERE SALARY > ( SELECT AVG(SALARY)
                   FROM EMPLOYEE_T);                --오호 그룹바이 없어도 잘 되는 구만...어케하나 했네 대신 SELECT FROM은 나와줘야 함!
                   
/*
다중 행 서브 쿼리
1. 서브 쿼리의 실행 결과가 N행이다.
2. 다중 행 서브 쿼리의 연산잔
    IN, ANY, ALL 등 (보통 IN)
*/

--1. 부서가 '영업부'인 사원을 조회하시오.
SELECT *
FROM EMPLOYEE_T
WHERE DEPART =(SELECT DEPT_NO
                  FROM DEPARTMENT_T
                 WHERE DEPT_NAME = '영업부');  --잠재적으로 위험한 쿼리임!!! 잠재적으로 다중행 쿼리임. DEPT_NAME이 PK도 UNIQUE도 아니기 때문.
                                               --결과값만 보고 다중행/단일행은 아님. 다행히 실행은 잘 되지만 위험의 요소가 있음.
                                        
       
                                               
SELECT *                                        
FROM EMPLOYEE_T
WHERE DEPART IN(SELECT DEPT_NO                    -->그래서 이렇게 
다중행 쿼리로 바꿔줘야함!
                  FROM DEPARTMENT_T
                 WHERE DEPT_NAME = '영업부');
                 
--2. 근무지역이 '서울'인 사원을 조회하시오
SELECT *
FROM EMPLOYEE_T
WHERE DEPART IN(SELECT DEPT_NO
                 FROM DEPARTMENT_T
                WHERE LOCATION = '서울');
                
/* GH 조인문 복습겸...
SELECT *
FROM EMPLOYEE_T E INNER JOIN DEPARTMENT_T D
ON E.DEPART=D.DEPT_NO
WHERE D.LOCATION = '서울';
*/

/*
인라인 뷰
1. FROM 절에 포함되는 서브 쿼리이다.
2. 서브 쿼리의 실행 결과를 임시 테이블의 형식으로 FROM절에 두고 사용
3. SELECT문의 실행 순서를 조정할 때 사용할 수 있다.
*/

--HR계정으로 접속
--1.두번째로 입사한 사원을 조회하시오.
    --1) HIRE_DATE의 오름차순 정렬을 한다. (입사순 정렬)
    --2) 오름차순 결과에 행 번호(ROWNUM)를 붙인다. //ROWNUM 오라클에서 지원하는 가상칼럼..행번호를 붙이고 싶을 때 사용. 칼럼의 별명을 줘야 이용 가능함.
    --3) 행 번호가 2인 데이터를 조회한다.
SELECT B.*
FROM (SELECT ROWNUM AS RN, A.*                   --정렬한 테이블 A 의 모든 결과에 행번호 붙이기.
         FROM (SELECT *
                 FROM EMPLOYEES 
                 ORDER BY HIRE_DATE ASC) A) B
WHERE B.RN = 2; 
--상기의 요런 쿼리가..페이지의 목록 만드는 쿼리문에 들어가는 거예용. 순서대로 10개 뽑아서 페이지 1에 넣고...이런거

--2. 연봉 TOP 10을 조회하시오

SELECT B.*
FROM(SELECT ROWNUM AS SL, A.*
        FROM (SELECT *
               FROM EMPLOYEES
            ORDER BY SALARY DESC)A) B
WHERE B.SL BETWEEN 1 AND 10;                                  --TMI 내가 했던거는 =>10 일케 했었다. 그리고 마지막에 ORDER BY도 해줬었는데...안해도 알아서 순서대로 나온다 ㅋㅋㅋ
                                                              ---A.* 대신 EMPLOYEES.* 하니까 오류...^^ 글쿤...


--3.두번째로 입사한 사원을 조회하시오.
    --1) HIRE_DATE의 오름차순 정렬을 하고, 행 번호(ROW_NUMBER)를 붙인다. - 별명 A
    --2) 행 번호가 2인 데이터를 조회한다.
    
SELECT A.*
 FROM (SELECT ROW_NUMBER() OVER(ORDER BY HIRE_DATE ASC) AS RN, EMPLOYEE_ID, HIRE_DATE
       FROM   EMPLOYEES) A
WHERE A.RN = 2;       

--4. 연봉 TOP10을 조회하시오
    --1) 연봉의 내림차순 정렬을 하고 행 번호(ROW_NUMBER 함수)를 붙인다.
    --2) 행 번호가 1에서 10인 데이터를 조회한다.
    
SELECT A.*
FROM (SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS SL, EMPLOYEE_ID, SALARY
      FROM   EMPLOYEES) A
WHERE A.SL BETWEEN 1 AND 10; 

/* 스칼라 서브 쿼리
1. SELECT 절에 포함된 서브 쿼리이다.
2. 메인 쿼리를 서브쿼리에서 사용할 수 있다.
  1) 비상관 쿼리 : 서브쿼리가 메인 쿼리를 사용하지 않는다.
  2) 상관 쿼리   : 서브쿼리가 메인 쿼리를 사용한다.
*/

--1. (비상관)부서번호 50인 부서에 근무하는 사원의 사원번호, 사원명, 부서명 조회하기.       --머 사실 조인으로 풀어도 되는 문제에요...아마 내가 아까 조인으로 해본거 ㅋㅋㅋㅋ 그것도 그거인듯...
SELECT EMPLOYEE_ID
      ,LAST_NAME
      ,(SELECT DEPARTMENT_NAME                                                    -- 요거 서브쿼리 개수로 따지자면 단일행이에요 DEPARTMENT_ID가 PK라서~
          FROM DEPARTMENTS
         WHERE DEPARTMENT_ID = '50')
FROM EMPLOYEES
WHERE DEPARTMENT_ID = '50';

--2. (상관)부서번호 50인 부서에 근무하는 사원의 사원번호, 사원명, 부서명 조회하기. -- 서브쿼리에서 메인쿼리의 구성요소를 가져다가 사용함
SELECT E.EMPLOYEE_ID
      ,E.LAST_NAME
      ,(SELECT D.DEPARTMENT_NAME                                                    -- 요거 서브쿼리 개수로 따지자면 단일행이에요 DEPARTMENT_ID가 PK라서~
          FROM DEPARTMENTS D
         WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID                                       -- 지금 이거 외부 조인이 되어서 107명 전원이 보임. 1번은 50명만 보여줬는데! 그런 쿼리입니다...왜? 메인 쿼리에서 50명이라고 안잡아줬음. 외부조인의 방식으로 처리됨
           AND D.DEPARTMENT_ID=50)          
FROM EMPLOYEES E; 

--3. 부서번호, 부서명, 사원수를 조회하시오.
SELECT D.DEPARTMENT_ID
      ,D.DEPARTMENT_NAME
      ,(SELECT COUNT(*)
          FROM EMPLOYEES E
         WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID) AS 사원수        --이거...그룹바이로 묶는게 아니었네...? 이따 이거에 대해 좀 분석해보기... 원래 그룹핑으로 하긴 한다는데 이런식으로도 가능하다는거..근데 이런식이 무슨식인지 이해 못했죠? ㅠ ㅋㅋㅋㅋㅋㅋㅋㅋ
FROM DEPARTMENTS D;          
  
 /* 셀프 설명시간.. WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID) AS 사원수
 위 수식이 그룹핑이랑 똑같은 방식으로 작용하고 있음...왜???????????
 어쩌면 그룹핑도 사실은 이런 WHERE 형식을 GROUP으로 알아서 처리해주고 있었던 것일까...??
 이럴때 노가다가 이해가 잘되죠....D에서 1이다! 그렇다면 E에서 1이다! E에 1이 여러개 있겠지?? 쫙 모은다. COUNT 한다.
 D에서 2다! E에서 2인게 좌르륵 있겠지. 2인거 쫙 모은다.
 -> 부서별 인원수가 된다.
 AHA.....
 */
 
--여기서부터 블로그
/*
CREATE문과 서브 쿼리
1. 서브 쿼리 결과를 새로운 테이블로 만들 수 있다.
2. 테이블을 복사하는 용도로도 사용할 수 있다.
3. 형식
    CREATE TABLE 테이블명 (칼럼1, 칼럼2, ...)
    AS (SELECT 칼럼1, 칼럼2, ...)
*/

-- 1. 사원번호, 사원명, 급여, 부서번호를 조회하고 결과를 새 테이블로 생성하시오.
CREATE TABLE EMPLOYEE_T2 (EMP_NO, NAME, SALARY, DEPART)
AS (SELECT EMP_NO, NAME, SALARY, DEPART
     FROM EMPLOYEE_T);
     -- 사실 완벽하게 복사되는 건 아니에요. 왜? PK와 같은 제약조건은 복사되지 않음에 유의. 복사되기엔 넘나 대단한 존재들...
     
-- 2. 부서 테이블의 구조만 복사하여 새 테이블을 생성하시오.
CREATE TABLE DEPARTMENT_T2 (DEPT_NO, DEPT_NAME, LOCATION)
AS (SELECT DEPT_NO, DEPT_NAME, LOCATION
    FROM DEPARTMENT_T
    WHERE 1=2);                   --->구조만 복사할 때 이런식으로 씁니다. 언제나, 어디서나 만족하지 못하는 조건식!   1=1해봤는데 데이터까지 고대로 복사됨 1=1은 TRUE니까...


/* 
INSERT 문과 서브 쿼리
1. 서브 쿼리의 결과를 INSERT 할 수 있다.
2. 한 번에 여러 행을 INSERT 할 수 있다.
3. 형식
    INSERT INTO 테이블명(칼럼1, 칼럼2, ...) (SELECT 칼럼1, 칼럼2, ...)
*/

-- 1. 지역이 '대구'인 부서 정보를 DEPARTMENT_T2 테이블에 삽입하시오.
INSERT INTO DEPARTMENT_T2(DEPT_NO, DEPT_NAME, LOCATION)
(SELECT DEPT_NO, DEPT_NAME, LOCATION
   FROM DEPARTMENT_T
  WHERE LOCATION='대구');
COMMIT; 

--2. 직급이 '과장'인 사원 정보를 '과장명단' 테이블로 작성하시오.
CREATE TABLE 과장명단 (EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY)
AS (SELECT EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY
     FROM EMPLOYEE_T
     WHERE 1=2);
INSERT INTO 과장명단(EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY)
(SELECT EMP_NO, NAME, DEPART, POSITION, GENDER, HIRE_DATE, SALARY
   FROM EMPLOYEE_T
  WHERE POSITION='과장');
COMMIT;                  

서브쿼리는...이만 바이바이....