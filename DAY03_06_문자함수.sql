--1. 대소문자 변환하기
SELECT UPPER('apple')     --APPLE  
      ,LOWER('APPLE')     --apple
      ,INITCAP('APPLE')   --Apple
FROM DUAL;

--2. 글자수/바이트수 반환하기
SELECT NAME
      ,LENGTH(NAME) AS 글자수
      ,LENGTHB(NAME) AS 바이트수
FROM EMPLOYEE_T;

--3. 문자 연결하기
--  1) || : 연결 연산자  (오라클에서만 사용 가능)
--  2) CONCAT(A, B) : 연결 함수. 인자값이 2개까지만 가능. CONCAT 연속해서 써서 해결
SELECT 'A'||'B'||'C'                                       --자바에서 OR인 ||....오라클에서는 (자바에서의)+에요!!!
     , CONCAT(CONCAT('A', 'B'), 'C')
FROM DUAL;     

SELECT *
FROM   EMPLOYEE_T
WHERE NAME LIKE '한'||'%';     --연습할 때 이러는게 더 유익해요. '한' 부분을 변수처리 하는게 가능해짐!

--4. 특정 문자의 위치 반환
--  1) 문자의 위치는 1
--  2) 못 찾으면 0을 반환한다.
SELECT NAME
      ,INSTR(NAME, '이')
FROM   EMPLOYEE_T;

--5. 일부 문자열 반환
SELECT NAME
      ,SUBSTR(NAME, 1, 1) AS 성 -- 1번째 글자부터 1글자를 반환
      ,SUBSTR(NAME, 2)    AS 이름
FROM   EMPLOYEE_T;

-- 구*민, 김*서, 이*영, 한*일 이름 조회하기
SELECT NAME
      ,SUBSTR(NAME, 1, 1)|| '*' ||SUBSTR(NAME, 3, 1)       --이름이 길수도 있겠죠...마지막 한글자만 꺼내고 싶을수도! 그럼 LENGTH(NANE)을 활용할 수 있지용. 마지막 글자가 될테니까!    
FROM   EMPLOYEE_T;

--6. 찾아바꾸기
SELECT REPLACE(DEPT_NAME, '부', '팀') AS 부서   --'부'를 팀으로 바꾸기
FROM DEPARTMENT_T;
SELECT REPLACE(DEPT_NAME, '부', '') AS 부서     --'부'를 ''으로 바꾸기
FROM DEPARTMENT_T;

--7. 채우기
--  1)LPAD(EXPR1, N, [EXPR2]) : N자리에 EXPR1을 반환. 왼쪽에 EXPR2를 채움        -- 숫자는..뭐 왼쪽에 채우는거 의미있어요? 하지만 문자는 아니라눙...  
--  2)RPAD(EXPR1, N, [EXPR2]) : N자리에 EXPR1을 반환. 오른쪽에 EXPR2를 채움      --TO_CAHR을 통해 00100이런식으로도 반환가능!

SELECT TO_CHAR(LPAD(100, 3, 0), '000000')
FROM DUAL;                                           --이러면 100 나오잖아요? 이때 TO_CHAR! 

SELECT LPAD(NAME, 10, '*') --10자리(한글은 5자리)의 NAME 반환, 왼쪽에 '*'채움             --이런식으로 활용!
      ,RPAD(NAME, 10, '*') --10자리(한글은 5자리)의 NAME 반환, 오른쪽에 '*'채움
FROM  EMPLOYEE_T;      

--8. 공백 제거하기
--  1) LTRIM(EXPR) : 왼쪽 공백 제거
--  2) RTRIM(EXPR) : 오른쪽 공백 제거
--  3)  TRIM(EXPR) : 왼쪽/오른쪽 제거

SELECT LTRIM('   HELLO   WORLD   ')
     , RTRIM('   HELLO   WORLD   ') 
     , TRIM('   HELLO   WORLD   ')
FROM DUAL;
