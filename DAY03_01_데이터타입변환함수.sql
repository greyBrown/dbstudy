-- 오라클의 내장함수 사용법을 종류별로 배워볼게요~~
-- 데이터타입 변환
/*
DUAL 테이블 
1. 테이블이 필요 없는 경우에 사용하는 테이블이다.
2. 테이블이 필요 없는 조회(DQL)의 경우 FROM절까지 작성해야 하는데 이 때 사용한다. 테이블 필요없거나 테이블...없는데?!? 할 때.
3. 1개의 열과(COLUMN)과 1개의 행(ROW)로 구성되어 있다.
4. DUMMY 칼럼
    X      값
    */
/*1.문자 -> 숫자 변환
TO_NUMBER('문자')    //이러면 문자값이 숫자로 변환되어 나옵니다.'5'가 5로!
*/
SELECT '100', TO_NUMBER('100')      --SELECT FROM 구문에 SELECT 내용으로 TO_NUM이 온거. 파란색 글자오니까 헷갈릴 수 있음. 어 뭐지? 싶으면 찬찬히 뜯어보면 된다!
FROM DUAL;                          --문자숫자는 왼쪽, 진짜숫자는 오른쪽임을 알 수 있음! 문자표기는 왼정, 숫자는 오정.

SELECT *
FROM DEPARTMENT_T
WHERE DEPT_NO = '1';                 
/*이거 숫자인데도 '1' 이라고 쳐도 실행된다! 왜?
오라클이 이렇게 바꾼 뒤에 실행하기 때문이다.
SELECT *
FROM DEPARTMENT_T
WHERE DEPT_NO = TO_NUMBER('1');
*/
/*2. 숫자 -> 문자 변환
TO_CHAR(숫자, [형식])            //[생략가능] [] 실제로 적는거 X
*/
SELECT  TO_CHAR(SALARY)
       ,TO_CHAR(SALARY, '99999999')   -- 8자리 문자열로 변환, 빈자리는 공백으로 채움
       ,TO_CHAR(SALARY, '00000000')   -- 8자리 문자열로 변환, 빈자리는 숫자 0으로 채움
       ,TO_CHAR(SALARY, '9,999,999')  -- 이 형식대로...
       ,TO_CHAR(SALARY, '999,999')    -- 자리수 안맞춰주면 오류남 ㅋㅋㅋㅋㅋ 원본이 7자리라서 정상 변환이 안 됨. #로 출력
FROM   EMPLOYEE_T;                    -- 실행해보면 명확하게 알 수 있지요
/*3. 문자 -> 날짜 변환
TO_DATE(문자, [형식])
 <날짜/시간 형식>
 1)YY   : 년도 2자리
 2)YYYY : 년도 4자리
 3)MM   : 월   2자리
 4)DD   : 일   2자리
 5)AM   : 오전/오후
 6)HH   : 12시간(01~12)
 7)HH24 : 24시간(00~23)
 8)MI   : 분 2자리
 9)SS   : 초 2자리
10)FF3 : 밀리초 3자리 (1/1000초)    -- 보통 로그 찍을때 밀리초 단위로 찍음. 아래에도 0.016초로 적혀있다.
*/
SELECT TO_DATE(HIRE_DATE)
      ,TO_DATE(HIRE_DATE, 'YY/MM/DD')       -- 입력된 값을 년도/월/일로 해석~ 잘 나오는 걸 볼 수 있음.
      ,TO_DATE(HIRE_DATE, 'YY/DD/MM')       -- 적은대로 연/일/월로 나옴. 이거 적을 때 잘 알려줘야 함. 내가 쓴대로 뽑아주기 땜시...
      ,TO_DATE(HIRE_DATE, 'HH/MI/SS')       -- 데이터에 없는 시/분/초 라서 오류뜸. 뭔말이야 잘 적어봐...하면서...어?? 눈물도 넣고....피곤하니??
  FROM EMPLOYEE_T;
/*4. 날짜 -> 문자 변환
     TO_CHAR(날짜, [형식])
     
    *현재 날짜/시간 함수 
      1)SYSDATE      :년, 월, 일, 시, 분, 초
      2)SYSTIMESTAMP :년, 월, 일, 시, 분, 초, 밀리초
*/
SELECT SYSDATE
      ,TO_CHAR(SYSDATE, 'YYYY-MM-DD AM HH:MI:SS')          --원하는 날짜 형식을 만드는 건 TO_CHAR!!!! 기억해둬요 헷갈림...
 FROM DUAL;
 
 SELECT SYSDATE
      ,SYSTIMESTAMP                                        --대박 GMT를 적어주다니....
      ,TO_CHAR(SYSTIMESTAMP, 'YYYY-MM-DD AM HH:MI:SS.FF3')
 FROM DUAL;


--TO_DATE는 문자를 날짜로 전환 TO_CHAR(DATE)는 날짜를 문자로 전환...
--TO_CHAR(DATE)가 TO_DATE의 상위호환 아닌가??? 섞어쓰면?? 어케되는지 GHH...

/*GGH 
SELECT TO_CHAR(TO_DATE(HIRE_DATE), 'YY/MM/DD')      --오 된다 아마 이런식으로 쓰라고 있나보다. 근데 HIRE_DATE는 원래 DATE 타입이다. TO_DATE를 빼주면?
FROM EMPLOYEE_T;
SELECT TO_CHAR(HIRE_DATE, 'YY/MM/DD')              -- 문제없이 됨.
FROM EMPLOYEE_T;
*/



