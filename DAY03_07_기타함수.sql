--1. 암호화하기 (해시 알고리즘)
SELECT STANDARD_HASH('1111', 'SHA256')   --SHA256 암호화 방식
      ,STANDARD_HASH('1111', 'SHA384')   --SHA384 암호화 방식
      ,STANDARD_HASH('1111', 'SHA512')   --SHA512 암호화 방식
      ,STANDARD_HASH('1111', 'MD5')      --MD5    암호화 방식
FROM DUAL;         
--더미데이터 만들어서 암호화 처리하긴 좋지만...이게 중간과정에서(자바) 로그로 실제 비번이 찍혀요;;; 그래서 그렇게 쓰진 않을거예용

--2. 순위 구하기(동점자의 경우 같은 순위를 가짐)
SELECT EMP_NO, NAME, SALARY
      ,RANK() OVER(ORDER BY SALARY ASC) AS 연봉적은순  --SALARY를 오름차순 정렬하고 순위를 매김
      ,RANK() OVER(ORDER BY SALARY DESC) AS 연봉많은순 --SALARY를 내림차순 정렬하고 순위를 매김
FROM EMPLOYEE_T;                                       --동점자 처리 방식 바봐용! 1 2 2 4
     
--3. 행 번호 구하기(동점자 처리 방식이 없음)                    --동점자 처리를 하지 않는게 행번호 구하기 방법! 1 2 3 4
SELECT EMP_NO, NAME, SALARY
      ,ROW_NUMBER() OVER(ORDER BY SALARY ASC) AS 연봉적은순
      ,ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS 연봉많은순          --한성일이 입자날짜 더 빠를걸...? 오 맞춤 ㅋㅋㅋ 근데 이건 걍 랜덤일수도..
FROM EMPLOYEE_T;     

--ROW_NUMBER 목록 구할 때 씁니다! 게시글 50개씩 나오고 그러는거...행 50개를 가져오는거! ROW_NUMBER가 기준이 됩니다.

--4. 분기 처리하기
--1) DECODE 함수
--문제. 사원번호, 사원명, 부서명 조회하기     --원래 조인으로 하지만...여기서는 함수로 간단하게 해봐용! DECODE 잘 쓰면 쿼리 성능도 높이면서...제한이 있긴해도 간단히 쓰기 좋죠
-- 1 영업 2 인사 3 총무 4기획
SELECT EMP_NO, 
       NAME, 
       DECODE(DEPART, 1, '영업부'
                    , 2, '인사부'
                    , 3, '총무부'
                    , 4, '기획부') AS 부서명
FROM EMPLOYEE_T;

--2) CASE WHEN 표현식

SELECT EMP_NO
      , NAME
      , CASE
        WHEN DEPART = 1 THEN '영업부'
        WHEN DEPART = 2 THEN '인사부'
        WHEN DEPART = 3 THEN '총무부'
        WHEN DEPART = 4 THEN '기획부'
        ELSE 'UNKNOWN'                        --ELSE는 생략가능. 등호 안들어가욥!
        END AS 부서명
FROM EMPLOYEE_T;        

--다음주계획...
--SELECT 나머지 계속 나갑니다..그룹 정렬 오-다 조인 서브쿼리 2~3일정도 예상
--PL/SQL의IF나 FOR문...이런 문법을 기반으로 해서 만들어지는 프로시저 FUNCTION TRIGGER 요런것들이...배울 수도 있긴한데 SELECT가 훨 중요해서...시간 많이 안남으면 생략 그리고 자바