/*
DDL 
1. Data Definition Language
2. 데이터 정의어
3. 데이터베이스 객체를 다루는 언어이다.
4. 종류
    1) CREATE   : 생성
    2) ALTER    : 수정
    3) DROP     : 삭제(완전 삭제)
    4) TRUNCATE : 삭제(내용만 삭제)   
*/

-- 테이블 삭제 //스크립트를 만들어 줄 때는 거꾸로! 삭제-생성으로 갑니다. 기존의 테이블을 다 지우고 테이블을 새로 만든다. 
-- 아..아아 이해함 수정은 다른방식으로 해야하니까 일케 하는거! 테이블 지우고 다시 해야 이것저것 배우면서 실험해보니까! ALTER 뭐시기뭐시기 할 수 없자나요 배우는 것보다 더 어려운 걸로 고칠 수 없다...

DROP TABLE CUSTOMER_T;  
DROP TABLE BANK_T;           --FK 있는 부분 먼저 삭제하는거...잊으면 오류뜸 ㅎ 생각해주기!

-- 테이블 생성 
CREATE TABLE BANK_T (
    BANK_CODE VARCHAR2(20 BYTE) NOT NULL,
    BANK_NAME VARCHAR2(30 BYTE),
    CONSTRAINT PK_BANK PRIMARY KEY(BANK_CODE)
    );
    
CREATE TABLE CUSTOMER_T (
    CUST_NO NUMBER NOT NULL,
    CUST_NAME VARCHAR2(30 BYTE) NOT NULL,
    CUST_PHONE VARCHAR2(30 BYTE) UNIQUE,
    CUST_AGE NUMBER(3) CHECK(CUST_AGE >=0 AND CUST_AGE <=120), --유효숫자3. 자리수 3자리까지만! 정밀도 지정.
    BANK_CODE VARCHAR2(20 BYTE),
    CONSTRAINT PK_CUSTOMER PRIMARY KEY(CUST_NO),
    CONSTRAINT FK_CUSTOMER_BANK FOREIGN KEY(BANK_CODE)REFERENCES BANK_T(BANK_CODE)
    );
    
    --FK에서 데이터타입 맞춰주는거 주의!!
    --CHECK(방법 1. CUST_AGE >=0 AND CUST_AGE<= 120)
    --     (방법 2. CUST_AGE BETWEEN 0 AND 120)
    
--SELECT * FROM USER_CONSTRAINTS; --제약조건이란 뜻입니다. 사용자가 작성한 제약조건을 조회하는 테이블. 어제 궁금했던걸 배운다!
--어제 테이블 생성한 방법은 제약조건의 이름을 지정하지 않는 방법! 그래서 스크립트에 뜨지 않음.
--그렇다면 이제 그걸 배워봅시당. PK 와 FK 정도만 지정해두면 되요. 다 지정해줄 필요는 없으니까!
-- CONSTRAINT PK_BANK PRIMARY KEY(BANK_CODE) 테이블 작성 쿼리 다 해주고 마지막에 이렇게 추가해주는 방법
-- 짜잔 CONSTRAINT_NAME에 PK FK 이렇게 내가 적은 이름이 뜨는게 보여용. 위에 정의어 따로 실행하고 SELECT 나중에 실행하는게 훨 깔끔하게 보임...

/*
테이블 수정하기
1. 칼럼 추가하기     : ALTER TABLE 테이블명      ADD 칼럼명 데이터타입 제약조건
2. 칼럼 수정하기     : ALTER TABLE 테이블명      MODIFY 칼럼명 데이터타입 제약조건
3. 칼럼 삭제하기     : ALTER TABLE 테이블명      DROP COLUMM 칼럼명
4. 칼럼 이름바꾸기   : ALTER TABLE 테이블명      RENAME COLUMN 기존칼럼명 TO 신규칼럼명
5. 테이블 이름바꾸기 : ALTER TABLE 기존테이블명  RENAME TO 신규테이블명
참고로 ALTER 많이 안쓸거예요. 우리가 딱히 쓸일은 없어용
테이블을 수정한다는 것은 칼럼을 수정한다는 것이다. 오직 칼럼(열)만이 ALTER의 대상!
*/

--쉬는시간...ALTER로  CASCADE를 SET NULL로 바꿀 수 있을까?!? 했는데 부적절한 값이랜다... 다른 방법이 있는듯...
--코딩폰트 설치. MONOSPACE가 적용된 폰트를 쓰는게 좋다!

--1. BANK_T에 연락처(BANK_TEL)칼럼을 추가하시오.
--2. BANK_T의 은행명(BANK_NAME) 칼럼을 VARCHAR2(15 BYTE)로 바꾸고 필수제약조건을 지정하시오. 
--3. CUSTOMER_T의 나이(CUST_AGE) 칼럼을 삭제하시오.
--4. CUSTOMER_T의 연락처(CUST_PH0NE) 칼럼명을 CUST_TEL로 수정하시오
--5. CUSTOMER_T에 등급(GRADE) 칼럼을 추가하시오. 'VIP', 'GOLD', 'SILVER', 'BRONZE' 중 하나의 값을 가지도록 설정하시오
--6. CUSTOMER_T의 고객명(CUST_NAME) 칼럼의 필수 제약조건을 없애시오.
--7. CUSTOMER_T의 테이블명을 CUST_T로 수정하시오.


ALTER TABLE BANK_T ADD BANK_TEL VARCHAR2(15 BYTE) NOT NULL;
ALTER TABLE BANK_T MODIFY BANK_NAME VARCHAR2(15 BYTE) NOT NULL;
ALTER TABLE CUSTOMER_T DROP COLUMN CUST_AGE;
ALTER TABLE CUSTOMER_T RENAME COLUMN CUST_PHONE TO CUST_TEL;
ALTER TABLE CUSTOMER_T ADD GRADE VARCHAR2(10 BYTE) CHECK(GRADE='VIP' OR GRADE='GOLD' OR GRADE='SILVER' OR GRADE='BRONZE'); 
                                                 --CHECK(GRADE IN('VIP', 'GOLD', 'SILVER', 'BRONZE')); 
ALTER TABLE CUSTOMER_T MODIFY CUST_NAME VARCHAR2(30 BYTE) NULL; --아무것도 안적으면 그대로 NOT NULL로 갑니다 ALTER는 CREATE랑 달리 변경점 적는거라서 이렇게 해야함!
ALTER TABLE CUSTOMER_T RENAME TO CUST_T;


/*
테이블 수정하기 - PK/FK 제약조건
1. PK
   1) 추가 : ALTER TABLE 테이블명 ADD CONSTRAINT 제약조건명 PRIMARY KEY(칼럼명)
   2) 삭제 
    (1) ALTER TABLE 테이블명 DROP CONTRAINT 제약조건명
    (2) ALTER TABLE 테이블명 DROP PRIMARY KEY
2. FK
   1)추가     : ALTER TABLE 자식테이블명 ADD      CONSTRAINT 제약조건명 FOREIGN KEY(칼럼명) REFERENCES 부모테이블(참조할칼럼명)
   2)삭제     : ALTER TABLE 테이블명     DROP     CONSTRAINT 제약조건명
   3)비활성화 : ALTER TABLE 테이블명     DISABLE  CONSTRAINT 제약조건명
   4)활성화   : ALTER TABLE 테이블명     ENABLE   CONSTRAINT 제약조건명
*/

--FK_CUSTOMER_BANK 제약조건을 비활성화하시오.
ALTER TABLE CUST_T DISABLE CONSTRAINT FK_CUSTOMER_BANK;

--외래키가 살아있는 상태에서 새로운 데이터(해당하는 뱅크코드가 없는 데이터)를 입력하면, PARENT KET NOT FOUND 라고 뜬다. 왜? 부모키에 데이터 없잖아...! 있는 은행 아니잖아...!

--FK_CUSTOMER_BANK 제약조건을 활성화하시오.
ALTER TABLE CUST_T ENABLE CONSTRAINT FK_CUSTOMER_BANK; 
-- 실제로 데이터 입력시에 오류 가능

-- 뭐가 안됐지만 무사히 고쳤다. 문법 어긋나면...빨간색으로 바로 알려줬으면 좋겠어..글자도 작으면서 ㅠ
    