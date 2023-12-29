/*
통계 함수(집계 함수)   --이거 열 하나밖에 계산 못합니다. 행들의 합계를 보는거지 열들의 합계를 보는게 아니에요!!!! 아까 SUM(수학+영어) 이거 안됐쬬??? 이래서 안됐쬬?? ㅜ
1. 합계 : SUM(EXPR)    
2. 평균 : AVG(EXPR)
3. 최대 : MAX(EXPR)
4. 최소 : MIN(EXPR)
5. 개수 : COUNT(EXPR)
*/

-- EMPLOYEE_T 테이블
--1. 전체 사원의 기본급 합계 조회하기
SELECT SUM(SALARY)
FROM EMPLOYEE_T;
--2. 전체 사원의 기본급 평균 조회하기
SELECT AVG(SALARY)
FROM EMPLOYEE_T;
--3. 전체 사원의 기본급 최대 조회하기
SELECT MAX(SALARY)
FROM EMPLOYEE_T;
--4. 전체 사원의 기본급 최소 조회하기
SELECT MIN(SALARY)
FROM EMPLOYEE_T;
--5. 전체 사원 수 조회하기
SELECT COUNT(EMP_NO)    -- 사원번호의 개수
FROM EMPLOYEE_T;
SELECT COUNT(NAME)      -- 이름의 개수
FROM EMPLOYEE_T;
SELECT COUNT(*)    -- 모든 칼럼을 참조해서 개수(사원 수 구하는 용도. 추천되는 방법. 특정 열을 집어넣는게 아니라 에스더리스트로!)
FROM EMPLOYEE_T;



-- SAMPLE_T 테이블
--1. 국어 점수 합계
SELECT SUM(KOR)          --NULL 값은 통계함수에서 제외하고 처리됨!!!
FROM SAMPLE_T;
--2. 국어 점수 평균
SELECT AVG(KOR)
FROM SAMPLE_T;
--3. 국어 점수 최대
SELECT MAX(KOR)
FROM SAMPLE_T;
--4. 국어 점수 최소
SELECT MIN(KOR)
FROM SAMPLE_T;
--5. 전체 학생 수
SELECT COUNT(*)
FROM SAMPLE_T;

--HR 계정으로 접속

--1. 전체 연봉 합계
SELECT AVG(SALARY)
FROM EMPLOYEES;

--2. 커미션 평균(커미션 = COMMISSION_PCT *SALARY)
SELECT AVG(COMMISSION_PCT*SALARY)            -- 커미션 받는 사람들의 평균. 아래는 모든 사람들의 머릿수가 포함된 평균~ 뿌듯 +1 ㅎ
FROM EMPLOYEES;

SELECT AVG(NVL(COMMISSION_PCT,0)*SALARY)  --NVL도 되나? 된다. 숫자가 위 식보다 적다. 아 이러면 평균이라서.... 받지 못하는 사람들이 들어감!!!! 아하아하
FROM EMPLOYEES;                           -- 궁금해서 해놓은거 나중에 이렇게 나가면...기분이 좋아요^^ 뿌듯^^ ㅋㅋㅋㅋㅋ 이 기분을 떠올리며 열심히 해봅시다....

--3. 가장 먼저 입사한 사원이 입사한 날짜 (최소 입자일자)
SELECT MIN(HIRE_DATE)                 --SELECT TO_DATE(MIN(HIRE_DATE)) 일케 했었는데...TO_DATE 없어도 된다!!
FROM EMPLOYEES;

--4. 가장 늦게 입사한 사원이 입사한 날짜 (최대 입사일자)
SELECT MAX(HIRE_DATE)
FROM EMPLOYEES;

--5. 사원들이 근무하고 있는 부서의 개수
SELECT COUNT(DISTINCT DEPARTMENT_ID)                   --DISTINCT 위치는 칼럼명 앞에 적어주면 됩니다.
FROM EMPLOYEES;


