/*
샘플 테이블
*/
CREATE TABLE SAMPLE_T (
    NAME VARCHAR2(20 BYTE),
    KOR NUMBER(3),
    ENG NUMBER(3),
    MATH NUMBER(3)
);

INSERT INTO SAMPLE_T(NAME, KOR, ENG, MATH) VALUES('A', 100, 100, NULL);
INSERT INTO SAMPLE_T(NAME, KOR, ENG, MATH) VALUES('B', 100, NULL, 100);
INSERT INTO SAMPLE_T(NAME, KOR, ENG, MATH) VALUES('C', NULL, 100, 100);
COMMIT;      --INSERT가 완료될려면 커밋!! 기억하기!!

-- SAMPLE_T의 전체 데이터 조회하기
SELECT *
FROM SAMPLE_T;

-- SAMPLE_T의 전체 데이터와 점수 합계 조회하기
SELECT NAME, KOR, ENG, MATH                            -- NULL값의 문제점 NULL+100은 NULL임....연산에 NULL이 포함되면 결과가 NULL이 됨 그래서 별도로 가공을 해줌!
      , (KOR + ENG + MATH) AS TOTAL                    -- NULL이 포함된 연산결과는 NULL이다. 
FROM SAMPLE_T;

/*
NULL 처리 함수
1. NVL(EXPR, VALUE IF EXPR IS NULL)
2. NVL2(EXPR, VALUE IF EXPR IS NOT NULL, VALUE IF EXPR IS NULL)
*/

SELECT NAME
      ,NVL(KOR, 0) AS 국어
      ,NVL(ENG, 0) AS 영어
      ,NVL(MATH, 0) AS 수확
      ,NVL(KOR,0) + NVL(ENG, 0) + NVL(MATH, 0) AS 합계
FROM SAMPLE_T;



--사원들의 PAY를 구해봅시다

SELECT FIRST_NAME
      ,LAST_NAME
      ,NVL2(COMMISSION_PCT, SALARY+(SALARY*COMMISSION_PCT), SALARY) AS PAY
FROM EMPLOYEES;     

SELECT SALARY+NVL2(COMMISSION_PCT, SALARY*COMMISSION_PCT, 0) AS PAY   -- 내가 처음에 쓴 식은 SALARY를 앞으로 뺀 형태...근데 원하는 값의 2배로 나온다...앞에 SALARY가 있어서 값이 한번 추가되는 것 같음
FROM EMPLOYEES;                                                       

-- 처음 작성했던 식에서 원하는 값 나옴!! 마지막을 1로 하면 안되는 거였음. SARARY*1.1의 이 앞 1연산은 앞에 CM이 NOT NULL값을 계산하는 거에서 이미 끝남! 
-- 맨 앞에 샐러리를 뺴줬으니까 커미션이 없다면 이제 NULL 값은 0이 되어야 함 여기서 곱해줄거 아니니까! 막상 코드 잘 나오면 쉬워보이는 기적 노어이...
-- 선생님 코드는 NVL2 하나로 딱 끝나니까 깔끔하다. 이렇게 하는거군...! NULL값이 없으면 2번칸 기본급*커미션 NULL값이 있으면 3번칸 커미션만!
