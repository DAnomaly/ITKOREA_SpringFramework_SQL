-- 1. 모든 사원의 LAST_NAME, SALARY, 본인이 근무하는 부서의 평균연봉(SALARY)을 조회하시오.
-- 스칼라 서브쿼리
SELECT you.department_id AS 부서번호
     , you.last_name AS 이름
     , you.salary AS 연봉
     , (SELECT ROUND(AVG(me.salary),2)
          FROM employees me
         WHERE me.department_id = you.department_id) AS 부서의평균연봉
  FROM employees you
 ORDER BY you.department_id;
    
-- 2. 부서(DEPARTMENT_ID)별로 DEPARTMENT_ID, DEPARTMENT_NAME, 평균연봉을 조회하시오.
-- 스칼라 서브쿼리
SELECT d.department_id AS 부서번호
     , d.department_name AS 부서명
     , (SELECT ROUND(AVG(e.salary),2)
          FROM employees e
         WHERE e.department_id = d.department_id) AS 평균연봉
  FROM departments d
 ORDER BY 부서번호;   
     
-- 3. 모든 사원들의 EMPLOYEE_ID, LAST_NAME, DEPARTMENT_NAME 을 조회하시오.
SELECT e.employee_id AS 사원번호
     , e.last_name AS 사원명
     , d.department_name AS 부서명
  FROM departments d INNER JOIN employees e
    ON d.department_id = e.department_id
 ORDER BY 사원번호;
    
-- 스칼라 서브쿼리
SELECT e.employee_id AS 사원번호
     , e.last_name AS 사원명
     , (SELECT d.department_name
          FROM departments d
         WHERE d.department_id = e.department_id) 부서명
  FROM employees e
 ORDER BY 사원번호;

-- 4. 평균연봉 이상의 연봉을 받는 사원들의 정보를 조회하시오.
SELECT employee_id 
     , first_name 
     , last_name  
     , email  
     , phone_number  
     , hire_date 
     , job_id 
     , salary 
     , commission_pct 
     , manager_id 
     , department_id  
  FROM employees
 WHERE salary > (SELECT AVG(salary) FROM employees)
 ORDER BY employee_id;

-- 5. Patrick Sully 와 같은 부서에 근무하는 모든 사원정보를 조회하시오.
SELECT employee_id 
     , first_name 
     , last_name  
     , email  
     , phone_number  
     , hire_date 
     , job_id 
     , salary 
     , commission_pct 
     , manager_id 
     , department_id  
  FROM employees
 WHERE department_id = (SELECT department_id
                          FROM employees
                         WHERE first_name = 'Patrick')
 ORDER BY employee_id;

-- 6. 부서번호가 20인 사원들 중에서 평균연봉 이상의 연봉을 받는 사원정보를 조회하시오.
SELECT employee_id 
     , first_name 
     , last_name  
     , email  
     , phone_number  
     , hire_date 
     , job_id 
     , salary 
     , commission_pct 
     , manager_id 
     , department_id  
  FROM employees
 WHERE department_id = 20
   AND salary >= (SELECT AVG(salary) FROM employees)
 ORDER BY employee_id;

-- 7. 직업'PU_MAN'의 최대연봉보다 더 많은 연봉을 받은 사원들의 정보를 조회하시오.
SELECT employee_id 
     , first_name 
     , last_name  
     , email  
     , phone_number  
     , hire_date 
     , job_id 
     , salary 
     , commission_pct 
     , manager_id 
     , department_id  
  FROM employees
 WHERE SALARY > ALL(SELECT SALARY FROM employees WHERE job_id = 'PU_MAN')
 ORDER BY employee_id;

SELECT employee_id 
     , first_name 
     , last_name  
     , email  
     , phone_number  
     , hire_date 
     , job_id 
     , salary 
     , commission_pct 
     , manager_id 
     , department_id  
  FROM employees
 WHERE SALARY > (SELECT MAX(SALARY) FROM employees WHERE job_id = 'PU_MAN')
 ORDER BY employee_id;

-- 8. 사원번호가 131인 사원의 JOB_ID와 SALARY가 모두 일치하는 사원들의 정보를 조회하시오.
SELECT employee_id 
     , first_name 
     , last_name  
     , email  
     , phone_number  
     , hire_date 
     , job_id 
     , salary 
     , commission_pct 
     , manager_id 
     , department_id  
  FROM employees
 WHERE job_id = (SELECT Job_Id FROM employees WHERE employee_id = 131)
   AND salary = (SELECT salary FROM employees WHERE employee_id = 131)
 ORDER BY employee_id;

SELECT e.employee_id 
     , e.first_name 
     , e.last_name  
     , e.email  
     , e.phone_number  
     , e.hire_date 
     , e.job_id 
     , e.salary 
     , e.commission_pct 
     , e.manager_id 
     , e.department_id  
  FROM employees a JOIN employees e 
    ON a.employee_id = 131
 WHERE a.job_id = e.job_id
   AND a.salary = e.salary
 ORDER BY employee_id;
-- 9. LOCATION_ID가 1000~1900인 국가들의 COUNTRY_ID와 COUNTRY_NAME을 조회하시오.
SELECT DISTINCT 
       C.country_id
     , C.country_name
  FROM countries C INNER JOIN locations L
    ON C.country_id = L.country_id
 WHERE L.location_id BETWEEN 1000 AND 1900
 ORDER BY country_id;
 
SELECT C.country_id
     , C.country_name
  FROM countries C
 WHERE C.country_id IN(SELECT L.country_id
                         FROM locations L
                        WHERE L.location_id BETWEEN 1000 AND 1900)
 ORDER BY country_id;

-- 10. 부서가 'Executive'인 모든 사원들의 정보를 조회하시오.
-- 서브쿼리의 WHERE 절에서 사용한 DEPARTMENT_NAME은 PK, UQ가 아니므로 서브쿼리의 결과는 여러 개이다.
SELECT e.employee_id 
     , e.first_name 
     , e.last_name  
     , e.email  
     , e.phone_number  
     , e.hire_date 
     , e.job_id 
     , e.salary 
     , e.commission_pct 
     , e.manager_id 
     , e.department_id  
  FROM employees e
 WHERE e.department_id IN(SELECT d.department_id 
                            FROM departments d 
                           WHERE d.department_name = 'Executive')
 ORDER BY employee_id;

SELECT e.employee_id 
     , e.first_name 
     , e.last_name  
     , e.email  
     , e.phone_number  
     , e.hire_date 
     , e.job_id 
     , e.salary 
     , e.commission_pct 
     , e.manager_id 
     , e.department_id  
  FROM departments d INNER JOIN employees e
    ON d.department_id = e.department_id
 WHERE d.department_name = 'Executive'
 ORDER BY employee_id;

-- 11. 부서번호가 30인 사원들 중에서 부서번호가 50인 사원들의 최대연봉보다 더 많은 연봉을 받는 사원들을 조회하시오.
SELECT e.employee_id 
     , e.first_name 
     , e.last_name  
     , e.email  
     , e.phone_number  
     , e.hire_date 
     , e.job_id 
     , e.salary 
     , e.commission_pct 
     , e.manager_id 
     , e.department_id  
  FROM employees e
 WHERE e.department_id = 30
   AND e.salary > (SELECT MAX(t.salary) FROM employees t WHERE t.department_id = 50);
   
SELECT e.employee_id 
     , e.first_name 
     , e.last_name  
     , e.email  
     , e.phone_number  
     , e.hire_date 
     , e.job_id 
     , e.salary 
     , e.commission_pct 
     , e.manager_id 
     , e.department_id  
  FROM employees e
 WHERE e.department_id = 30
   AND e.salary > ALL(SELECT t.salary FROM employees t WHERE t.department_id = 50);
   
SELECT e.employee_id 
     , e.first_name 
     , e.last_name  
     , e.email  
     , e.phone_number  
     , e.hire_date 
     , e.job_id 
     , e.salary 
     , e.commission_pct 
     , e.manager_id 
     , e.department_id  
  FROM (SELECT MAX(salary) AS salary 
          FROM employees 
         WHERE department_id = 50) t 
 INNER JOIN employees e
    ON e.department_id = 30
 WHERE e.salary > t.salary;
 
-- 12. MANAGER가 아닌 사원들의 정보를 조회하시오.
-- MANAGER는 MANAGER_ID를 가지고 있다.
SELECT e.employee_id 
     , e.first_name 
     , e.last_name  
     , e.email  
     , e.phone_number  
     , e.hire_date 
     , e.job_id 
     , e.salary 
     , e.commission_pct 
     , e.manager_id 
     , e.department_id 
  FROM employees e
 WHERE e.employee_id NOT IN(SELECT DISTINCT m.manager_id 
                              FROM employees m 
                             WHERE m.manager_id IS NOT NULL) -- 서브쿼리에 결과에 NULL값이 포함되어 있으면 오류가 발생한다
 ORDER BY e.employee_id;

-- 13. 근무지가 'Southlake'인 사원들의 정보를 조회하시오.
SELECT e.employee_id 
     , e.first_name 
     , e.last_name  
     , e.email  
     , e.phone_number  
     , e.hire_date 
     , e.job_id 
     , e.salary 
     , e.commission_pct 
     , e.manager_id 
     , e.department_id 
  FROM employees e
 WHERE e.department_id IN(SELECT d.department_id 
                            FROM departments d 
                           WHERE d.location_id IN(SELECT l.location_id 
                                                    FROM locations l 
                                                   WHERE l.city = 'Southlake'))
 ORDER BY e.employee_id;

SELECT e.employee_id 
     , e.first_name 
     , e.last_name  
     , e.email  
     , e.phone_number  
     , e.hire_date 
     , e.job_id 
     , e.salary 
     , e.commission_pct 
     , e.manager_id 
     , e.department_id 
  FROM locations l, departments d, employees e
 WHERE l.location_id = d.location_id
   AND d.department_id = e.department_id
   AND l.city = 'Southlake';

-- 14. 부서명의 가나다순으로 모든 사원의 정보를 조회하시오.
SELECT e.employee_id 
     , e.first_name 
     , e.last_name  
     , e.email  
     , e.phone_number  
     , e.hire_date 
     , e.job_id 
     , e.salary 
     , e.commission_pct 
     , e.manager_id 
     , e.department_id
  FROM employees e
 ORDER BY (SELECT d.department_name 
             FROM departments d
            WHERE d.department_id = e.department_id);

-- 15. 가장 많은 사원들이 근무하고 있는 부서의 번호와 근무하는 인원수를 조회하시오.
SELECT department_id
     , COUNT(*) AS 부서별사원수
  FROM employees
 GROUP BY department_id
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                     FROM employees
                    GROUP BY department_id);
                    
