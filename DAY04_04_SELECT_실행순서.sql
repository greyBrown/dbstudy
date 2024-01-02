/*SELECT 문의 실행 순서
1.FROM
2.WHERE
3.GROUP BY
4.HAVING
5.SELECT
6.ORDER BY
*/

--1. 부서번호를 기준으로 오름차순 정렬하시오.
SELECT DEPART AS 부서번호             --2
FROM EMPLOYEE_T                       --1
ORDER BY 부서번호;                    --3

--2. 부서별로 연봉 평균을 조회하시오.
SELECT DEPART AS 부서번호                   --3  
      ,AVG(SALARY) AS 평균                    
WHERE EMPLOYEE_T                            --1
GROUP BY 부서번호;                          --2    --> 오류. SELECT 문을 나중에 처리하니까 '부서번호'라는 별명을 못 받아들임.

--3. 부서별로 연봉 평균과 사원수를 조회하시오. 사원수가 2명 이상인 부서만 조회하시오.
SELECT DEPART AS 부서번호
    , AVG(SALARY) AS 평균연봉
    , COUNT(*) AS 사원수
FROM EMPLOYEE_T
GROUP BY DEPART
HAVING COUNT(*) >=2         -- 사원수 별명을 못알아들음..순서에 의거해서!
ORDER BY 평균연봉 DESC;     -- ORDER BY가 마지막이니까 이건 잘 된다! 이렇게..순서 따라 갑니다...


