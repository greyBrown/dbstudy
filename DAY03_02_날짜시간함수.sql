/*
1. DATE 형식의 날짜/시간 연산
    1) 1일을 숫자 1로 처리한다.
    2) 단위 처리
        (1) 1 : 1일
        (2) 1/24 : 1시간
        (3) 1/24/60 : 1분
        (4) 1/24/60/60 : 1초
*/
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24:MI:SS')              -- 현재 날짜와 시간
      ,TO_CHAR(SYSDATE + 1, 'YY/MM/DD HH24:MI:SS')         -- 1일 후 
      ,TO_CHAR(SYSDATE - 1 , 'YY/MM/DD HH24:MI:SS')         -- 1일 전
      ,TO_CHAR(SYSDATE + 1/24, 'YY/MM/DD HH24:MI:SS')       -- 1시간 후
      ,TO_CHAR(SYSDATE + 1/24/60/60, 'YY/MM/DD HH24:MI:SS') --1초 후
FROM DUAL;                                                  --같은 맥락으로 DATE-DATE로 남은 날짜 구하는 것도 가능해집니다.

-입사한지 몇일 지났는지 계산
SELECT EMP_NO, NAME, HIRE_DATE
      , SYSDATE - TO_DATE(HIRE_DATE, 'YY/MM/DD') AS 근무일수   -- 2095년으로 계산하는듯ㅋㅋㅋㅋ 인서트 문제? 그런거라고...
FROM EMPLOYEE_T;      

/*GH
SELECT EMP_NO, NAME, HIRE_DATE                         --어 이러면 제대로 나오네 아하 YY가 문제인듯. YYYY로 하면 95를 9995로 계산하는듯한 답이 나온다...형식 넣어줄거면 잘 보면서 넣어주기!
      , SYSDATE - HIRE_DATE AS 근무일수                
FROM EMPLOYEE_T;
*/

/*
    2. TIMESTAMP 형식의 날짜/시간 연산
        1) INTERVAL 키워드를 이용한다.
        2) YEAR, MONTH, DAY, HOUR, MINUTE, SECOND 단위를 사용한다.
*/
SELECT SYSTIMESTAMP + INTERVAL '1' YEAR            --일년후를 의미한다. 그렇군...+365 했더니 내년의 오늘 전날 나옴 -365는 작년의 오늘...아 내년 366일임 ㅎ 
     , SYSTIMESTAMP + INTERVAL '1' MONTH           --이런게 계산이 힘들어지니까 + INTERVAL '1' YEAR 연산을 사용! INTERVAL '1' YEAR 이거 그대로 써줘야함 따옴표나 YEAR 안쓰면 오류나고 INTERVAL 안쓰면 내일됨 ㅋㅋㅋ
     , SYSTIMESTAMP + INTERVAL '1' DAY
     , SYSTIMESTAMP + INTERVAL '1' HOUR
     , SYSTIMESTAMP + INTERVAL '1' MINUTE
     , SYSTIMESTAMP + INTERVAL '1' SECOND
FROM DUAL;                                        
SELECT SYSTIMESTAMP +365
FROM DUAL;

SELECT TO_CHAR(SYSDATE) 
FROM DUAL;

/*
    3. 날짜/시간 단위 추출하기
        EXTRACT(단위 FROM 날짜/시간)
*/
SELECT EXTRACT(YEAR FROM SYSDATE) AS 년
      ,EXTRACT(MONTH FROM SYSDATE) AS 월
      ,EXTRACT(DAY FROM SYSDATE) AS 일
      ,EXTRACT(HOUR FROM SYSTIMESTAMP) AS UTC                    --SYSDATE 는 시간 단위부터는 추출 못해내기 시작함..정말 딱 DATE(일자) 까지만이네 ㅋㅋㅋㅋ             
      ,EXTRACT(HOUR FROM SYSTIMESTAMP) +9 AS "ASIA/SEOUL"        --GH 한글 영어 다 되는데 띄어쓰기랑 특수문자 들어가면 안되기 시작..그래서 "" 넣은듯!!! 영어문자조합도 안됨
      ,EXTRACT(MINUTE FROM SYSTIMESTAMP)AS 분
      ,EXTRACT(SECOND FROM SYSTIMESTAMP)AS 초
FROM DUAL;      

/*
4. N개월 전후 날짜 구하기                      --SYSTIMESTAMP와는 달리(INTERVAL로 구해냄) SYSDATE는 이런거 구하는 게 좀 힘드니까 함수가 따로 있다! ADD_MONTHS 나 MONTHS_BETWEEN 처럼!
    ADD_MONTHS(날짜, N)
*/
SELECT ADD_MONTHS(SYSDATE, 1) AS "1개월후"
     , ADD_MONTHS(SYSDATE, -1) AS "1개월전"
     , ADD_MONTHS(SYSDATE, 12) AS "1년후"
FROM DUAL;

/* 5. 개월 차이 구하기
     MONTHS_BETWEEN(최근날짜, 이전날짜)             --이래야 결과를 양수로 뽑음
*/

--올해 1월 1일부터 지금까지 몇개월 지났을까?
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2023-01-01', 'YYYY-MM-DD'))  -- 형식에'' 써줘야함...
FROM DUAL;

      