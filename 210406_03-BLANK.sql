-- 1. 부서의 위치(location_id)가 1700 인 사원들의 employee_id, last_name, department_id, salary 를 조회한다.
-- 사용할 테이블 (departments, employees)


-- 2. 부서명(department_name)이 'Executive' 인 부서에 근무하는 모든 사원들의 department_id, last_name, job_id 를 조회한다.
-- 사용할 테이블 (departments, employees)


-- 3. 기존의 직업(job_id)을 여전히 가지고 있는 사원들의 employee_id, job_id 를 조회한다.
-- 사용할 테이블 (employees, job_history)


-- 4. 각 부서별 사원수와 평균연봉을 department_name, location_id 와 함께 조회한다.
-- 평균연봉은 소수점 2 자리까지 반올림하여 표현하고, 각 부서별 사원수의 오름차순으로 조회한다.
-- 사용할 테이블 (departments, employees)


-- 5. 도시이름(city)이 T 로 시작하는 지역에서 근무하는 사원들의 employee_id, last_name, department_id, city 를 조회한다.
-- 사용할 테이블 (employees, departments, locations)


-- 6. 자신의 상사(manager_id)의 고용일(hire_date)보다 빨리 입사한 사원을 찾아서 last_name, hire_date, manager_id 를 조회한다. 
-- 사용할 테이블 (employees)


-- 7. 같은 소속부서(department_id)에서 나보다 늦게 입사(hire_date)하였으나 나보다 높은 연봉(salary)을 받는 사원이 존재하는 사원들의
-- department_id, full_name(first_name 과 last_name 사이에 공백을 포함하여 연결), salary, hire_date 를 full_name 순으로 정렬하여 조회한다.
-- 사용할 테이블 (employees)


-- 8. 같은 소속부서(department_id)의 다른 사원보다 늦게 입사(hire_date)하였으나 현재 더 높은 연봉(salary)을 받는 사원들의
-- department_id, full_name(first_name 과 last_name 사이에 공백을 포함하여 연결), salary, hire_date 를 full_name 순으로 정렬하여 조회한다.
-- 사용할 테이블 (employees)
