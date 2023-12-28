-- 1. 사원 테이블에서 부서번호의 중복을 제거하고 조회하기
SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES ;

SELECT * from EMPLOYEES where rowid in (select max(rowid) from EMPLOYEES group by DEPARTMENT_ID); 
-- 중복된 DEPARTMENT 값을 제거하고 남은 컬럼들을 모두 보여주는 명령문! 다른 칼럼들은 안보여주나? 싶어서 구글링해서 해봤다
-- 요컨대 DEPARTMENT_ID가 중복이 있다면...ROWID값이 가장 높은 행 하나만 제외하고 나머지는 SELECT에서 제외되는데, ROWID값이 가장 높다고해서 가장 보스일거란 확증은 없음 ㅋㅋㅋ
-- ROWID 값은 변경되기 쉬운 값이라고 한다. 테이블 수정/변경하면서 바뀌기도 하고...명령문의 세세한 의미를 명확히 모르겠으니 티스토리 마지막에 이걸 분석해보도록 합시다.

-- 2. 사원 테이블에서 사원번호가 150인 사원의 정보 조회하기
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID =150;


-- 3. 사원 테이블에서 연봉이 10000 이상인 사원의 정보 조회하기
SELECT*
FROM EMPLOYEES
WHERE SALARY >= 1000;


-- 4. 사원 테이블에서 연봉이 10000 이상 20000 이하인 사원의 정보 조회하기
SELECT*
FROM EMPLOYEES 
WHERE SALARY BETWEEN 10000 AND 20000;

-- 5. 사원 테이블에서 부서번호가 30, 40, 50인 사원의 정보 조회하기
SELECT*
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(30, 40, 50);

-- 6. 사원 테이블에서 소속된 부서가 없는 사원의 정보 조회하기
SELECT*
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

-- 7. 사원 테이블에서 커미션을 받는 사원의 정보 조회하기
SELECT*
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

-- 8. 사원 테이블에서 상사가 없는 사원의 정보 조회하기
SELECT*
FROM EMPLOYEES
WHERE MANAGER_ID IS NULL;

-- 9. 사원 테이블에서 전화번호가 '515'로 시작하는 사원의 정보 조회하기
SELECT*
FROM EMPLOYEES
WHERE PHONE_NUMBER LIKE '515%';

-- 10. 사원 테이블에서 직업이 'MAN'으로 끝나는 사원의 정보 조회하기
SELECT*
FROM EMPLOYEES
WHERE JOB_ID  LIKE '%MAN';

