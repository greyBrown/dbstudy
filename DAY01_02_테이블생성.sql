/*
테이블(table)
    1. 관계형 데이터베이스에서 데이터를 저장하는 객체이다.
    2. 표 형식을 가진다.
    3. 행(Row)와 열(Column)의 집합 형식이다.
    */
    /*
    테이블 만들기
    1. 열(column)을 만드는 과정이다.
    2. 테이블 만드는 쿼리문
       CREATE TABLE 테이블이름 (
          칼럼이름1 데이터타입 제약조건,
          칼럼이름2 데이터타입 제약조건,
          ...
          );    
*/

/* 
데이터타입
    1. NUMBER(P, S) : 정밀도가 P이고, 스케일이 S인 숫자
       1) 정밀도 P : 전체 유효 숫자 (0123의 유효숫자는 123이죠)
       2) 스케일 S : 소수부의 유효 숫자 
           EX/1.2 -> P는2 ,S는1 NUMVER(2,1) 전체 두자리 소수점은 한자리
                0.XX NUMBER(2,2) 생략가능. 그럼 다 가능합니다. 둘 중 하나만 생략하기도 함      
       3) 스케일만 생략하면 정수로 표시하는 숫자라는 뜻
       4) 정밀도와 스케일을 모두 생략하면 정수, 실수 모두 표시할 수 있는 숫자
    2. CHAR(SIZE) : 글자수가 최대 SIZE인 고정 문자
       1) 고정 문자 : 글자수의 변동이 적은 문자(예시 : 휴대전화번호, 주민번호 등)
       2) 최대 SIZE : 2000 BYTE
    3. VARCHAR2(SIZE) : 글자수가 최대 SIZE인 가변 문자
       1) 가변 문자 : 글자수의 변동이 큰 문자(예시 : 이름, 주소 등)
       2) 최대 SIZE : 4000 BYTE
    4. CLOB : VARCHAR2(SIZE)로 처리할 수 없는 큰 문자
    5. DATE : 날짜/시간(년,월,일,시,분,초)
    6. TIMESTAMP : 정밀한 날짜/시간(년,월,일,시,분,초,마이크로초) 백만분의 일초...
*/

-- CHAR(5) 'ABC'  VARCHAR2(5) 'ABC' 둘 같냐고(==) 비교하면 'FALSE' 나옵니다.
-- CHAR은 무조건 5글자 맞춤. 공백을 넣어서...VARCHAR는 가변이잖아요! 3개만 넣으면 3개만...
-- 그러니까 CHAR을 써서 얻는 이점이 글케 크지 않아요. 그래서 보통 VARCHAR2 로다가...

/* 
제약조건
    1. NOT NULL : 필수 입력
    2. UNIQUE : 중복 불가
    3. PRIMARY KEY : 기본키
    4. FOREIGN KEY : 외래키
    5. CHECK : 작성한 조건으로 값의 제한
    
    기본키는 식별자임. 식별할 때 쓰는거! 찾아올 때 쓰는 값...주로 번호
    1)기본키는 중복이 없어야함. 2) 기본키는 반드시 값을 가지고 있어야 함.
    즉, NOT NULL과 UNIQUE 두 가지 특성이 합쳐진 것이 PRIMARY KEY
    작성방법은 NOT NULL PRIMARY KEY 이렇게 씁니다.UNIQUE는 같이 안써용
*/

--블로그 구현을 위한 블로그 테이블
CREATE TABLE BLOG_T (
  BLOG_NO  NUMBER             NOT NULL PRIMARY KEY, 
  TITLE    VARCHAR2(100 BYTE) NOT NULL,
  EDITOR   VARCHAR2(100 BYTE) NOT NULL,
  CONTENTS CLOB               NULL,         --생략가능 하지만 볼 때 편하니까...
  CREATED  DATE               NOT NULL
); //새로고침하면 옆에 테이블에 뜹니다! 초록+ 옆에 새로고침 표시

--블로그 테이블 삭제하기
DROP TABLE BLOG_T;
//새로고침하면 삭제된거 확인됨!



  
  
  

















