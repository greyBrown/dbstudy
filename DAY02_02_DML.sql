/*
DML
1. DATA MANIPULATION LANGUAGE
2. 데이터 조작어
3. 데이터(행, ROW)를 다루는 언어이다.
4. 트랜잭션 처리가 필요하다. //데이터에서 커밋하기 전까지는 입력한 데이터가 아니다. 커밋한거 되돌릴려면 롤백(입력취소). 커밋-롤백
5. 종류
    1)행 삽입 : INSERT INTO VALUES
    2)행 수정 : UPDATE SET WHERE
    3)행 삭제 : DELETE FROM WHERE
*/

/*
트랜잭션
1. 한 번에 수행해야 하는 작업을 의미한다. ATOMICITY 원자성! 전체가 실행되지 않으면 모두 취소된다. ALL OR NOTHING
2. 2가지 이상의 작업이 하나의 트랜잭션으로 구성된다. 
3. 작업의 저장을 의미하는 COMMIT과 작업의 취소를 의미하는 ROLLBACK이 필요하다. (TCL이라고 묶어서 부르기도 함 ROLLBACK과 COMMIT. 근데 사람마다 막..다르게 불러...)
   EX)은행이체
     1) 내 통장에서 돈 빼기
     2) 너 통장으로 돈 넣기     
*/

/* 
시퀀스 SEQUENCE~~ 나머지는 다 기본값대로 하고 캐시만 노캐시로...번호표 미리 뽑아놓으면 번호 달라질 수 있으니까
회원번호 부서번호 이런거....오는 순서대로 1 2 3 4 5 6 7 8 9~~~ 정리해봅시다

시퀀스
1. 일련번호를 생성하는 데이터베이스 객체
2. 주로 기본키에 값을 생성할 때 사용한다.
3. 함수
  1) 새 번호 생성하기   : NEXTVAL   //시퀀스로부터 새 번호를 하나 가지고 오시오!
  2) 현재 번호 확인하기 : CURRVAL   //지금 몇번인지...
*/
--시퀀스 삭제 (관계없으니까 순서 상관없음)
DROP SEQUENCE DEPT_SEQ;
DROP SEQUENCE EMPLOYEE_SEQ;


--부서 테이블의 부서번호를 생성하는 시퀀스 만들기
CREATE SEQUENCE DEPT_SEQ                          --NEXTVAL과 합쳐서 함께 사용하게 됩니다.
  INCREMENT BY 1 -- 1씩 증가하는 번호 생성
  START WITH 1   -- 1부터 번호 생성
  NOMAXVALUE     -- 상한선 없음
  NOMINVALUE     -- 하한선 없음
  NOCYCLE        -- 번호순환없음
  CACHE 20       -- 20개의 번호를 미리 생성 (이거는 보통 번호를 미리 생성하지 않는 NOCACHE로. )
  NOORDER        -- 순서대로
  ;              -- 적은 값들은 모두 디폴트값. 안적어줘도 되는 값들임!



  
  
DROP TABLE EMPLOYEE_T;
DROP TABLE DEPARTMENT_T;
  
  
  
CREATE TABLE DEPARTMENT_T (
DEPT_NO    NUMBER NOT NULL,
DEPT_NAME  VARCHAR2(15 BYTE) NOT NULL,
LOCATION   VARCHAR2(15 BYTE) NOT NULL,
CONSTRAINT PK_DEPARTMENT PRIMARY KEY(DEPT_NO)
);

CREATE TABLE EMPLOYEE_T (
EMP_NO    NUMBER NOT NULL,
NAME      VARCHAR2(20 BYTE) NOT NULL,  
DEPART    NUMBER,
POSITION  VARCHAR2(20 BYTE),
GENDER    CHAR(2 BYTE),
HIRE_DATE DATE,
SALARY    NUMBER,
CONSTRAINT PK_EMPLOYEE PRIMARY KEY(EMP_NO),
CONSTRAINT FK_EMPLOYEE FOREIGN KEY(DEPART) REFERENCES DEPARTMENT_T(DEPT_NO) ON DELETE SET NULL
);

--사원테이블의 사원번호를 생성하는 시퀀스 만들기
CREATE SEQUENCE EMPLOYEE_SEQ
START WITH 1001
NOCACHE; 

--부서 테이블에 행 삽입하기
INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '영업부', '대구');
INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '인사부', '서울');
INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '총무부', '대구');
INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES(DEPT_SEQ.NEXTVAL, '기획부', '서울');
--생략가능한 문법이 있는데,테이블(칼럼리스트) 에서 이 칼럼리스트 생략가능해요. 단, 테이블의 모든 칼럼을 작성하는 경우만!! 모든 칼럼 아니면 적어줘야 함!!!

--사원 테이블에 행 삽입하기
INSERT INTO EMPLOYEE_T VALUES(EMPLOYEE_SEQ.NEXTVAL, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
INSERT INTO EMPLOYEE_T VALUES(EMPLOYEE_SEQ.NEXTVAL, '김민서', 1, '사원', 'M', '17-09-01', 2500000);
INSERT INTO EMPLOYEE_T VALUES(EMPLOYEE_SEQ.NEXTVAL, '이은영', 2, '부장', 'F', '90-09-01', 5500000);
INSERT INTO EMPLOYEE_T VALUES(EMPLOYEE_SEQ.NEXTVAL, '한성일', 2, '과장', 'M', '93-04-01', 5000000);

-- 그리고 커밋!!!!!!!!!!!!!!!!!!!! 커밋안하면 나중에 자바랑 연동했을때 안보임 커밋!!!!!!!!!! 의외로 잘 까먹음...

/*
수정

UPDATE 테이블명 SET 업데이트할내용, 업데이트할내용,..... WHERE 조건식
*/

COMMIT;

--1. DEPTPARTMENT_T에서 부서번호(DEPT_NO)가 3인 부서의 지역(LOCATION)을 '인천'으로 수정

UPDATE DEPARTMENT_T 
   SET LOCATION='인천'              --SET절의 등호(=)는 대입연산자
 WHERE DEPT_NO=3;                   --WHERE절의 등호(=)는 동등비교연산자
                                --UPDATE문은 이런식으로 쓰는거 추천해요. 코드스타일을 관리한다 라고 하죠!
 
 --2. EMPLOYEE_T 에서 부서번호(DEPART)가 2인 부서의 사원들의 기본급(SALARY)을 10% 인상하시오
 
 UPDATE EMPLOYEE_T
 SET SALARY=SALARY*1.1
 WHERE DEPART=2;
 
 --롤백
 ROLLBACK;            --이전 커밋으로 돌아감
 
 /*
 삭제
 
 DELETE FROM 테이블명 WHERE 조건식
 */
--1.DEPARTMENT_T 에서 부서번호(DEPT_NO)가 3인 부서를 삭제하시오    //부서번호가 3인 사원은 없다. 따라서 참조무결성에 영향을 미치지 않습니다.
DELETE 
FROM DEPARTMENT_T
WHERE DEPT_NO=3;

--2.EMPLOYEE_T 에서 부서번호(DEPART)가 1과 4인 사원을 삭제하시오
DELETE 
FROM EMPLOYEE_T 
WHERE DEPART=1 OR DEPART=4;
--WHERE DEPART IN(1, 4)

--3.DEPARTMENT_T에서 부서번호(DEPT_NO)가 2인 부서를 삭제하시오. //부서번호가 2인 사원이 2명 있다. 부서가 없어지면 사원 정보가 참조무결성에 위배된다. 하지만 문제없이 삭제된다. 왜? 참조무결성에 대비해서 ON DELETE SET NULL 옵션을 주었기 때문임.
DELETE 
FROM DEPARTMENT_T 
WHERE DEPT_NO=2;

ROLLBACK;
