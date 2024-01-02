/*
 GROUP_BY
 1. 같은 값을 가진 데이터들을 하나의 그룹으로 묶어서 처리한다.
 2. 대부분 통계 함수와 함께 사용한다.
 3. 지켜야할 문법
 4. GROUP BY 절에 명시한 칼럼만 SELECT 절에서 조회할 수 있다.
*/

--1. 사원 테이블에서 부서번호를 기준으로 그룹화하여 조회하시오.
SELECT DEPART     -- ->아스테리스크(*) 이러면 오류뜬다. 왜? GROUP BY에 없는 칼럼이니까! DEPART 라고 쓰면 잘 나옴.
FROM EMPLOYEE_T
GROUP BY DEPART;          --GH 헷갈릴까봐 적어놓는거. 그때 ROWID 쓸때 맨 처음 SELECT에 다른 칼럼도 올 수 있었던건 그게 GROUP BY가 걸린 칼럼이 아니었기 때문임! 그건 SEELCT ROWID에 걸린 GROUP BY!

--2. 사원테이블에서 부서번호별 연봉의 평균을 조회하시오. -> 부서번호별 = 부서번호를 기준으로. ~별 이라고 주로 표현된다.
SELECT DEPART AS 부서번호
     , AVG(SALARY) AS 연봉평균
FROM   EMPLOYEE_T
GROUP BY DEPART;

--3. 부서 테이블에서 지역별 부서 부서를 조회하시오.
SELECT LOCATION AS 지역명
     , COUNT(*)
FROM DEPARTMENT_T
GROUP BY LOCATION;

--4. 사원 테이블에서 직급과 성별을 기준으로 그룹화하여 평균 급여를 조회하시오.
SELECT POSITION, GENDER
      ,AVG(SALARY) AS 평균급여
FROM EMPLOYEE_T
GROUP BY POSITION, GENDER;                     --GROUP BY가 전체집합이면 SELECT에는 부분집합만 온다고 생각하면 되용. 다 와도 되고 일부만 와도 되고...

--5. 사원 테이블에서 입사월별 입사자 수를 조회하시오.
SELECT EXTRACT(MONTH FROM HIRE_DATE) AS 입사월별
      ,COUNT(*) AS 입사자수
FROM EMPLOYEE_T
GROUP BY EXTRACT(MONTH FROM HIRE_DATE);       --> 이게 내가 한거

SELECT TO_CHAR(HIRE_DATE, 'MM') AS 입사월     --> 선생님의 다른 예시2 TO_CHAR 을 TO_DATE로 바꿔보면??! 안됨 ㅎ 그게...그렇게 작동하는게 아닌듯...
      ,COUNT(*) AS 입사자수
FROM EMPLOYEE_T
GROUP BY TO_CHAR(HIRE_DATE, 'MM');  

/*
HAVING
1. 주로 GROUP BY 절과 함께 사용한다.
2. 통계 함수에 조건을 지정하는 경우 사용한다.
3. 일반 조건은 WHERE절에 작성한다.
*/

--1. 사원 테이블에서 성별에 따른 연봉의 평균을 조회하시오. 성별이 'M'인 사원만 조회하시오.
SELECT GENDER 
      ,FLOOR(AVG(SALARY)) AS 연봉평균
FROM EMPLOYEE_T
WHERE GENDER = 'M'                                               --그리고 WHERE절에는 통계함수 못들어간다는거! 기억해놔요!
GROUP BY GENDER;

--2. 사원 테이블에서 성별에 따른 연봉의 평균을 조회하시오. 각 성별의 사원수가 2명 이상인 사원만 조회하시오.
SELECT GENDER
      ,FLOOR(AVG(SALARY)) AS 연봉평균
FROM EMPLOYEE_T
GROUP BY GENDER
HAVING COUNT(*)>=2;                           --분발해서 후롸라랅 해보면 나름 뿌듯하죠

-- HR 계정으로 접속


-- 1. 사원 테이블에서 동일한 부서번호를 가진 사원들을 그룹화하여 각 그룹별로 몇 명의 사원이 있는지 조회하시오.
SELECT COUNT(*) AS 사원수
      ,DEPARTMENT_ID AS 부서번호
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

-- 2. 사원 테이블에서 같은 직업을 가진 사원들을 그룹화하여 각 그룹별로 연봉의 평균이 얼마인지 조회하시오.
SELECT JOB_ID
      ,FLOOR(AVG(SALARY))
FROM EMPLOYEES
GROUP BY JOB_ID;

-- 3. 사원 테이블에서 전화번호 앞 3자리가 같은 사원들을 그룹화하여 각 그룹별로 연봉의 합계가 얼마인지 조회하시오.
SELECT SUBSTR(PHONE_NUMBER, 1, 3) AS 전화번호
      ,SUM(SALARY)      
FROM EMPLOYEES
GROUP BY SUBSTR(PHONE_NUMBER, 1, 3);                     --와........그룹바이에 SUBSTR(PHONE_NUMBER, 1, 3) 오고 셀렉트는 PHONE_NUMBER 오니까 오류남. 아 이렇게도 안되는구나...철저하네...
                                                         --이거 유의!(티적) SELECT에는 GROUP BY보다 같거나 작은 단위의 그룹만 올 수 있음!!

-- 4. 사원 테이블에서 각 부서별 사원수가 20명 이상인 부서를 조회하시오.
SELECT DEPARTMENT_ID AS 부서명
       , COUNT(*) AS 인원수
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*)>=20;

-- 5. 사원 테이블에서 각 부서별 사원수를 조회하시오. 단, 부서번호가 없는 사원은 제외하시오.
SELECT COUNT(*) AS 사원수, DEPARTMENT_ID AS 부서번호
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL              -- 골고루 해보는중...오 됐다!! ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ 이렇게 하는 거군....
GROUP BY DEPARTMENT_ID;

