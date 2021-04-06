-- << employees 테이블 >> --

-- 1. 전체 사원의 모든 칼럼을 조회한다.
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id FROM employees;

-- 2. 전체 사원의 first_name, last_name, job_id 를 조회한다.
SELECT first_name, last_name, job_id FROM employees;

-- 3. 연봉(salary)이 12000 이상되는 사원들의 last_name, salary 를 조회한다.
SELECT last_name, salary FROM employees WHERE salary >= 12000;

-- 4. 사원번호(employee_id)가 150 인 사원의 last_name, department_id 를 조회한다.
SELECT last_name, department_id FROM employees WHERE employee_id = 150;

-- 5. 커미션(commission_pct)을 받는 모든 사원들의 last_name, salary, commission_pct 를 조회한다.
SELECT last_name, salary, commission_pct FROM employees WHERE commission_pct IS NOT NULL;

-- 6. 모든 사원들의 last_name, commission_pct 를 조회하되 커미션(commission_pct)이 없는 사원은 0으로 처리하여 조회한다.
SELECT last_name, NVL(commission_pct,0) AS COMMISSION_PCT FROM employees;

-- 7. 커미션(commission_pct)이 없는 사원들은 0으로 처리하고, 커미션이 있는 사원들은 기존 커미션보다 10% 인상된 상태로 조회한다.
SELECT NVL2(commission_pct,commission_pct * 1.1,0) AS COMMISSION_PCT FROM employees;

-- 8. 연봉(salary)이 5000 에서 12000 인 범위의 사원들의 first_name, last_name, salary 를 조회한다.
SELECT first_name, last_name, salary FROM employees WHERE salary >= 5000 AND salary <= 12000;
SELECT first_name, last_name, salary FROM employees WHERE salary BETWEEN 5000 AND 12000;

-- 9. 연봉(salary)이 5000 에서 12000 사이의 범위가 아닌 사원들의 first_name, last_name, salary 를 조회한다.
SELECT first_name, last_name, salary FROM employees WHERE salary <= 5000 OR salary >= 12000;
SELECT first_name, last_name, salary FROM employees WHERE NOT salary BETWEEN 5000 AND 12000;

-- 10. 직업(job_id)이 SA_REP 이나 ST_CLERK 인 사원들의 전체 칼럼을 조회한다.
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id 
FROM employees WHERE job_id = 'SA_REP' OR job_id = 'ST_CLERK';

SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id 
FROM employees WHERE job_id IN('SA_REP','ST_CLERK');

-- 11. 연봉(salary)이 2500, 3500, 7000 이 아니며 직업(job_id) 이 SA_REP 이나 ST_CLERK 인 사람들을 조회한다.
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id 
FROM employees WHERE salary <> 2500 AND salary <> 3500 AND salary <> 7000 AND (job_id = 'SA_REP' OR job_id = 'ST_CLERK');

SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id 
FROM employees WHERE salary NOT IN(2500,3500,7000) AND job_id IN('SA_REP','ST_CLERK');

-- 12. 상사(manager_id)가 없는 사람들의 last_name, job_id 를 조회한다.
SELECT last_name, job_id FROM employees WHERE manager_id IS NULL;

-- 13. 성(last_name)에 u 가 포함되는 사원들의 employee_id, last_name 을 조회한다.
SELECT employee_id, last_name FROM employees WHERE last_name LIKE '%u%';
SELECT employee_id, last_name FROM employees WHERE last_name LIKE '%u%' OR last_name LIKE '%U%';
SELECT employee_id, last_name FROM employees WHERE UPPER(last_name) LIKE '%U%';

-- 14. 전화번호(phone_number)가 650 으로 시작하는 사원들의 last_name, phone_number 를 조회한다.
SELECT last_name, phone_number FROM employees WHERE phone_number LIKE '650%';
SELECT last_name, phone_number FROM employees WHERE SUBSTR(phone_number,1,3) = '650';

-- 15. 성(last_name)의 네 번째 글자가 a 인 사원들의 last_name 을 조회한다.
SELECT last_name FROM employees WHERE last_name LIKE '___a%';

-- 16. 성(last_name) 에 a 또는 e 가 포함된 사원들의 last_name 을 조회한다.
SELECT last_name FROM employees WHERE last_name LIKE '%a%' OR last_name LIKE '%e%';

-- 17. 성(last_name) 에 a 와 e 가 모두 포함된 사원들의 last_name 을 조회한다.
SELECT last_name FROM employees WHERE last_name LIKE '%a%' AND last_name LIKE '%e%';

-- 18. 2008/02/20 ~ 2008/05/01 사이에 고용된(hire_date) 사원들의 last_name, employee_id, hire_date 를 조회한다.
SELECT last_name, employee_id, hire_date FROM employees WHERE hire_date BETWEEN '2008/02/20' AND '2008/05/01';

-- 19. 2004년도에 고용된(hire_date) 모든 사원들의 last_name, employee_id, hire_date 를 조회한다.
SELECT last_name, employee_id, hire_date FROM employees WHERE hire_date BETWEEN '04/01/01' AND '04/12/31';
SELECT last_name, employee_id, hire_date FROM employees WHERE hire_date LIKE '04/__/__';
SELECT last_name, employee_id, hire_date FROM employees WHERE EXTRACT(YEAR FROM hire_date) = 2004;

-- 20. 부서(department_id)를 조회하되 중복을 제거하여 조회한다.
SELECT DISTINCT department_id FROM employees;

-- 21. 직업(job_id)이 ST_CLERK 가 아닌 사원들의 부서번호(department_id)를 조회한다.
-- 단, 부서번호가 NULL인 값은 제외하고 부서번호의 중복을 제거한다.
SELECT DISTINCT department_id FROM employees WHERE job_id <> 'ST_CLERK' AND department_id IS NOT NULL;

-- 22. 커미션(commission_pct)을 받는 사원들의 실제 커미션(commission = salary * commission_pct)을 구하고,
-- employee_id, first_name, job_id 와 함께 조회한다.
SELECT employee_id, first_name, job_id, salary * commission_pct AS commission FROM employees WHERE NVL(commission_pct,0) <> 0;

-- 23. 가장 오래 전에 입사(hire_date)한 직원부터 최근에 입사한 직원 순으로 last_name, hire_date 를 조회한다.
SELECT last_name, hire_date FROM employees ORDER BY hire_date;

-- 24. 부서번호(department_id)가 20, 50 인 부서에서 근무하는 모든 사원들의 부서번호의 오름차순으로 조회하되,
-- 같은 부서번호 내에서는 last_name 의 알파벳순으로 조회한다.
SELECT employee_id, first_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id
FROM employees WHERE department_id IN(20,50) ORDER BY department_id , last_name;

-- 25. 커미션(commission_pct)을 받는 모든 사원들의 last_name, salary, commission_pct 을 조회한다.
-- 연봉이 높은 사원을 먼저 조회하고 같은 연봉의 사원들은 커미션이 높은 사원을 먼저 조회한다.
SELECT last_name, salary, commission_pct FROM employees WHERE NVL(commission_pct,0) <> 0 ORDER BY salary DESC , commission_pct DESC;
