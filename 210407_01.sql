-- 서브쿼리
-- 쿼리문 내부에 다른 쿼리문을 포함하는 것

-- 단일 행 서브쿼리
-- 1. 서브쿼리의 결과가 1개인 쿼리
-- 2. 단일 행 서브쿼리 연산자 : =,!=,>,>=,<,<=

-- 문제1. 평균급여보다 더 높은 급여를 받는 사원들의 정보를 조회하시오.
SELECT 
       name
     , position
     , salary
  FROM employee
 WHERE salary > (SELECT
                        AVG(salary)
                   FROM employee);
 
-- 문제2. 사원번호가 1001인 사원과 같은 직급을 가진 사원들의 정보를 조회하시오.
SELECT 
       name
     , position
     , salary
  FROM employee
 WHERE position = (SELECT 
                          position
                     FROM employee 
                    WHERE emp_no = 1001);
                    
-- 문제3. 가장 급여가 높은 사원과 가장 급여가 낮은 사원을 조회하시오.
SELECT
       name
     , position
     , salary
  FROM employee
 WHERE salary = (SELECT MAX(salary) 
                   FROM employee)
    OR salary = (SELECT MIN(salary)
                   FROM employee);
     
-- 다중 행 서브쿼리
-- 1. 서브쿼리의 결과가 여러 개인 쿼리
-- 2. 다중 행 서브쿼리 연산지 : IN, ANY, ALL, EXISTS

-- 문제 1. 부서번호가 1인 부서에 존재하는 직급과 같은 직급을 가지고 있는 사원을 조회하시오.
SELECT
       name
     , depart
     , position
  FROM employee
 WHERE position IN(SELECT position FROM employee WHERE depart = 1);
 
-- 문제 2. '구창민'과 같은 부서에서 근무하는 사원을 조회하시오
SELECT name
     , depart
     , position
  FROM employee
 WHERE depart IN(SELECT depart FROM employee WHERE name = '구창민');
 
-- 문제 3. 부서번호가 1인 부서에서 근무하는 사원들의 모든 급여보다 큰 급여를 받는 사원을 조회하시오
-- 1) 다중행 서브쿼리
SELECT name
     , depart
     , position
     , salary
  FROM employee
 WHERE salary > ALL(SELECT salary FROM employee WHERE depart = 1);

-- 2) 단일행 서브쿼리 
SELECT name
     , depart
     , position
     , salary
  FROM employee
 WHERE salary > (SELECT MAX(salary) FROM employee WHERE depart = 1);
 
-- 스칼라 서브쿼리
-- 1. SELECT절에서 사용하는 서브쿼리이다.
-- 2. 단일 행 서브쿼리여야 한다.

-- 문제1. 모든 사원들의 평균연봉과 부서수를 조회하시오
SELECT (SELECT AVG(e.salary)
          FROM employee e) AS 평균연봉
     , (SELECT COUNT(d.dept_no)
          FROM department d) AS 부서수
  FROM dual;
 
-- 인라인 뷰(inline view)

-- 1) 일반적 풀이
SELECT depart
     , name 
  FROM employee
 WHERE depart = 1
 ORDER BY name;

-- 2) 인라인 뷰 (정렬 -> 조건)
SELECT e.depart
     , e.name
  FROM (SELECT depart
             , name 
          FROM employee 
         ORDER BY name) e
 WHERE e.depart = 1;
 
-- CREATE문과 서브쿼리
-- 1. 서브쿼리의 결과를 이용해서 새로운 테이블을 생성할 수 있다.
-- 2. 데이터를 포함할 수도 있고, 제외할 수도 있다.
-- 3. PK,FK의 제약조건은 복사되지 않습니다

DESC employee;

-- 문제1. employee 테이블의 구조와 데이터를 모두 복사해서 새로운 employee2 테이블을 생성하시오.
CREATE TABLE employee2
    AS (SELECT EMP_NO 
             , NAME 
             , DEPART 
             , POSITION 
             , GENDER 
             , HIRE_DATE 
             , SALARY 
          FROM employee);
          
DESC employee2;

-- 문제2. employee 테이블의 데이터를 제ㅚ하고 구조만 복사해서 employee3 테이블을 생성하시오.
CREATE TABLE employee3
    AS (SELECT EMP_NO 
             , NAME 
             , DEPART 
             , POSITION 
             , GENDER 
             , HIRE_DATE 
             , SALARY 
          FROM employee
         WHERE 1 = 2);
