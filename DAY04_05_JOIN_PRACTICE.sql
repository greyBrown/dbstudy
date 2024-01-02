--1. 사원번호, 사원명, 부서명을 조회하시오.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM DEPARTMENTS D INNER JOIN EMPLOYEES E
ON D.DEPARTMENT_ID=E.DEPARTMENT_ID;                                              --- ON에서 이름만 보면 헷갈릴 수 있으니까 PK FK 확실히 봐줘야 해용 조인은 결합부고 SELECT에 보여지는 직접적인 내용이 아님!

--2. 부서번호, 부서명, 지역명을 조회하시오
SELECT D.DEPARTMENT_NAME, D.DEPARTMENT_ID, L.STREET_ADDRESS
FROM LOCATIONS L INNER JOIN DEPARTMENTS D
ON L.LOCATION_ID = D.LOCATION_ID;

--3. 사원번호, 사원명, 직업, 직업별 최대연봉, 연봉을 조회하시오.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.JOB_ID, E.SALARY, J.MAX_SALARY
FROM JOBS J INNER JOIN EMPLOYEES E
ON J.JOB_ID=E.JOB_ID;



--4. 사원번호, 사원명, 부서명을 조회하시오. 부서가 없으면 '부서없음'으로 조회하시오.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, NVL(D.DEPARTMENT_NAME, '부서없음')
FROM DEPARTMENTS D RIGHT JOIN EMPLOYEES E                               --외부조인! 이러면 1번에서 1명 빠진 사람이 뜹니다.
ON D.DEPARTMENT_ID=E.DEPARTMENT_ID; 

--5. 부서별 평균급여를 조회하시오. 부서명, 평균급여를 조회하시오. 근무중인 사원이 없으면, 평균 급여를 0으로 조회하시오.
SELECT D.DEPARTMENT_NAME, NVL(FLOOR(AVG(E.SALARY)), 0)
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E
ON D.DEPARTMENT_ID=E.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME;       -- 좀 더 정확하게 그룹짓기 위해 ID를 추가! 둘이 데이터가 동일하다면(종속관계) 그룹핑을 1개로 하든 2개로 하든 같음.
                                                   -- 권장하는 방법입니다. 보다 정확하게 하기 위해서....! 
                         
--GH
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID, JOB_ID;                   -- 그룹핑이 되긴하지만 엑셀처럼 챡챡 되는건 아니고...오더바이를 얼마나 잘해주냐에 따른듯..엑셀이 아닙니다 엑셀이...
                                                  -- 부서번호에 따른 직책별 연봉합계 나오긴한다! 안나오는줄 알고 넘어갈뻔했네 휴 ㅋㅋㅋㅋㅋㅋORDER BY DEPARTMENT_ID ASC;         
                                                  
--3개 이상 테이블 조인하기

--6. 사원번호, 사원명, 부서번호, 부서명, 지역번호, 지역명(STREET_ADDRESS)  3개 이상의 테이블을 조인하기


SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.LOCATION_ID, L.STREET_ADDRESS     --첫번째 방법 (1-2)-3
FROM DEPARTMENTS D INNER JOIN EMPLOYEES E 
ON D.DEPARTMENT_ID=E.DEPARTMENT_ID INNER JOIN LOCATIONS L
ON D.LOCATION_ID=L.LOCATION_ID;

SELECT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.LOCATION_ID, L.STREET_ADDRESS    --두번째 방법 (2-3)-1 익숙해지면 이쪽 방법을 많이 쓰게 돼요. 
FROM LOCATIONS L INNER JOIN DEPARTMENTS D
ON L.LOCATION_ID = D.LOCATION_ID INNER JOIN EMPLOYEES E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

--7. 국가명, 도시명, 부서명 조회하시오.
SELECT C.COUNTRY_ID, L.CITY, D.DEPARTMENT_NAME
FROM COUNTRIES C INNER JOIN LOCATIONS L
ON C.COUNTRY_ID = L.COUNTRY_ID INNER JOIN DEPARTMENTS D                          -- 아직은 성능상의 순서보다...일단 쳤을때 답 나오냐가 아니냐가 중요한 단계! 쳐봐ㅏㅏㅏㅏㅏ요!!!
ON L.LOCATION_ID=D.LOCATION_ID;                                                  -- 관계를 찾는다 관계를...  관계가 핵심이니까 넘 어렵게 생각하지 말아요

--A.a PK=FK 이렇게 이니셜로 요약해서 티적...
--근데...성능 생각해서 PK 앞으로 빼준다고 해도..다중 조인시 나중에 조인해야 하는 거에 PK로 엮여있으면 내가 순서 어케 못하는거 아닌가...?

--셀프조인...한 테이블내에서 한 칼럼이 다른 칼럼이 조회하는...테이블 안에 PK가 있고 그 PK를 참조하는 FK가 공존하는거져...여기서는 EMPLOYEE_ID<->MANAGER_ID!

--셀프조인 (하나의 테이블에 일대다 관계를 가지는 칼럼들이 존재하는 경우)
--8. 사원번호, 사원명, 매니저번호, 매니저명을 조회하시오.
--관계
--1명의 매니저가 N명의 사원을 관리한다. 1:N 관계에서 매니저가 1(PK) 사원이 N(FK)이다.
-- 매니저테이블 : EMPLOYEES M 사원테이블 : EMPLOYEES E
-- PK           : EMPLOYEE_ID  FK        : MANAGER_ID

SELECT E.EMPLOYEE_ID AS 사원번호
, E.LAST_NAME AS 사원번호
, E.MANAGER_ID AS 매니저번호
, M.LAST_NAME AS 매니저명
FROM EMPLOYEES M INNER JOIN EMPLOYEES E
ON M.EMPLOYEE_ID=E.MANAGER_ID;               --EMPLOYEE_NAME 이러면.....없죠!?!?!? 눈 씻고 찾아봐도 없죠?!? 오타 없는거 같은데 안되면 컬럼명 함 봐줘요...

-- 9. 같은 부서내에서 나보다 급여를 더 많이 받는 사원을 조회하시오
-- 관계
-- 나는 여러 사원과 관계를 맺는다.
-- 나(EMPLOYEES ME)              사원들(EMPLOYEES YOU)
-- 같은 부서의 사원만 조인하기 위해서 부서 번호로 조인조건을 생성함

SELECT ME.EMPLOYEE_ID AS 사원번호
, ME.LAST_NAME AS 사원명
, ME.SALARY AS 급여
, YOU.EMPLOYEE_ID AS 너사원번호
, YOU.LAST_NAME AS 너사원명
, YOU.SALARY AS 너급여
FROM EMPLOYEES ME INNER JOIN EMPLOYEES YOU
ON ME.DEPARTMENT_ID = YOU.DEPARTMENT_ID
WHERE ME.SALARY < YOU.SALARY;

--GH그럼..나보다 입사일자가 빠른 사람들은?
SELECT ME.EMPLOYEE_ID AS 사원번호
, ME.LAST_NAME AS 사원명
, ME.HIRE_DATE AS 입사일
, YOU.LAST_NAME AS 선임명
, YOU.HIRE_DATE AS  선임입사일
FROM EMPLOYEES ME INNER JOIN EMPLOYEES YOU
ON ME.DEPARTMENT_ID = YOU.DEPARTMENT_ID
WHERE ME.HIRE_DATE > YOU.HIRE_DATE
ORDER BY YOU.HIRE_DATE;

--GH 같은 부서에서 나랑 입사년월 똑같은데 나보다 연봉 높은 사람...
SELECT ME.EMPLOYEE_ID AS 사원번호
, ME.LAST_NAME AS 사원명
, ME.HIRE_DATE AS 입사일
, ME.SALARY AS 내연봉
, YOU.LAST_NAME AS 그새끼이름
, YOU.HIRE_DATE AS  그새끼입사일
, YOU.SALARY AS 그새끼연봉
FROM EMPLOYEES ME INNER JOIN EMPLOYEES YOU
ON ME.DEPARTMENT_ID = YOU.DEPARTMENT_ID
WHERE (EXTRACT(YEAR FROM ME.HIRE_DATE) = EXTRACT(YEAR FROM YOU.HIRE_DATE)) AND (EXTRACT(MONTH FROM ME.HIRE_DATE) = EXTRACT(MONTH FROM YOU.HIRE_DATE)) AND ME.SALARY < YOU.SALARY;
