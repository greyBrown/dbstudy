CREATE TABLE STUDENT (
    STUDENT_NO NUMBER NOT NULL PRIMARY KEY,
    STU_NAME VARCHAR2(100 BYTE) NOT NULL,
    GRADE NUMBER NOT NULL,
    CLASS_NAME NUMBER NOT NULL,
    NUMBER_T NUMBER NOT NULL
    );
    
CREATE TABLE PROJECT_NAME (
    PROJECT_NUM NUMBER NOT NULL PRIMARY KEY,
    PROJECT_NAME VARCHAR2(100 BYTE) NOT NULL
    );
    
CREATE TABLE SIGN_PROJJECT (
    STUDENT_NO NUMBER REFERENCES STUDENT(STUDENT_NO) ON DELETE CASCADE,
    PROJECT_NUM NUMBER REFERENCES PROJJECT_NAME(PROJECT_NUM) ON DELETE SET NULL
    );

--학생 지우면 수강신청도 지우겠다! 싹 사라짐 갸는 갔슈...
--수강신청 내역에는 학생들의 신청내역은 남겨두겠다! 과목번호는 사라지고 과목명만 남음
--이러면 일단 비워뒀다가 나중에 다른걸로 대체해주는게 가능! 이런식으로 하는거였죱
    
/*
다대다 관계
1. 2개의 테이블을 직접 관계 짓는 것은 불가능하다.
2. 다대다 관계를 가지는 2개의 테이블과 연결된 중간 테이블이 필요하다.
3. 일대다 관계를 2개 만들면 다대다 관계가 된다.

*/

--과목 테이블 삭제
DROP TABLE PROJECT_NAME;
--수강신청 테이블 삭제
DROP TABLE SIGN_PROJJECT; --이거먼저 삭제해야한다는거~~~ J 언제 두번 들어갔어 왜 오류나나 했네
--학생테이블 삭제
DROP TABLE STUDENT;
    
    
