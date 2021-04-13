 -- HR 계정의 EMPLOYEES 테이블을 복사하기
 -- 테이블을 복사하면 PK, FK, UK는 복사되지 않는다.
CREATE TABLE employees 
    AS SELECT employee_id 
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
         FROM hr.employees ;
        
DESC user_constraints; -- 제약조건을 저장하고 있는 데이터 사전
SELECT *
  FROM user_constraints
 WHERE table_name = 'EMPLOYEES';
 
ALTER TABLE employees ADD CONSTRAINT employees_pk PRIMARY KEY (employee_id);
ALTER TABLE employees ADD CONSTRAINT employees_email_uk UNIQUE (email);

--------------------------------

-- PL/SQL

-- 접속마다 최초 1회만 하면 된다.
-- 결과를 화면에 띄우기
SET SERVEROUTPUT ON; -- 디폴트 SET SEVEROUTPUT OFF;

-- 기본 구성
/*
    DECLARE 
        변수 선언;
    BEGIN
        작업;
    END;
*/

-- 화면 출력
SET SERVEROUTPUT ON -- DBMS_OUTPUT을 사용하기 위한 환경변수 변경
BEGIN
    DBMS_OUTPUT.put_line('HELLO PLSQL');
END;

-- 변수 선언 (스칼라 변수)
DECLARE
    my_name VARCHAR2(10);
    my_age NUMBER(3);
BEGIN
    -- 변수에 값을 대입
    my_name := '에밀리';
    my_age := 30;
    DBMS_OUTPUT.PUT_LINE('내 이름은 '||my_name||'입니다.');
    DBMS_OUTPUT.PUT_LINE('나이는 '||my_age||'살 입니다.');
END;
    
-- 변수 선언 (참조 변수)
-- 기존의 칼럼의 타입을 그대로 사용한다
-- (계정.)테이블.칼럼%TYPE
DECLARE
    v_first_name employees.first_name%TYPE; -- v_first_name VARCHAR2(20);
    v_last_name employees.last_name%TYPE; -- v_last_name VARCHAR2(25);
BEGIN
    -- 테이블의 데이터를 변수에 저장하기
    -- SELECT 칼럼 INTO 변수 FROM 테이블;
    /*
    SELECT first_name 
      INTO v_first_name 
      FROM employees 
     WHERE employee_id = 100;
    SELECT last_name 
      INTO v_last_name 
      FROM employees 
     WHERE employee_id = 100;
     */
    SELECT first_name, last_name
      INTO v_first_name, v_last_name
      FROM employees 
     WHERE employee_id = 100;
     
    DBMS_OUTPUT.PUT_LINE('FIRST_NAME : '||v_first_name);
    DBMS_OUTPUT.PUT_LINE('LAST_NAME : '||v_last_name);
END;

-- IF문 ( IF - END IF )
DECLARE
    score NUMBER(3);
    grade CHAR(1);
BEGIN
    score := 50;
    IF score >= 90 THEN
        grade := 'A';
    ELSIF score >= 80 THEN
        grade := 'B';
    ELSIF score >= 70 THEN
        grade := 'C';
    ELSIF score >= 60 THEN
        grade := 'D';
    ELSE
        grade := 'F';
    END IF;
    DBMS_OUTPUT.PUT_LINE('SCORE : '||score);
    DBMS_OUTPUT.PUT_LINE('GRADE : '||grade);
END;

-- CASE문
DECLARE
    score NUMBER(3);
    grade CHAR(1);
BEGIN
    score := 90;
    CASE 
        WHEN score >= 90 THEN 
            grade := 'A';
        WHEN score >= 80 THEN
            grade := 'B';
        WHEN score >= 70 THEN
            grade := 'C';
        WHEN score >= 60 THEN
            grade := 'D';
        ELSE 
            grade := 'F';
    END CASE;
    DBMS_OUTPUT.PUT_LINE('SCORE : '||score);
    DBMS_OUTPUT.PUT_LINE('GRADE : '||grade);
END;

-- 문제. 사원번호가 200인 사원의 연봉(salary)을 가져와서,
-- 5000 이상이면 '고액연봉자', 아니면 공백을 출력하시오.
-- IF
DECLARE
    t_salary employees.salary%TYPE;
BEGIN
    SELECT salary
      INTO t_salary
      FROM employees
     WHERE employee_id = 200;
    DBMS_OUTPUT.PUT_LINE('SALARY : '||t_salary);
    IF t_salary >= 5000 THEN
        DBMS_OUTPUT.PUT_LINE('고액연봉자');
    ELSE
        DBMS_OUTPUT.PUT_LINE('');
    END IF;
END;

-- CASE
DECLARE
    t_salary employees.salary%TYPE;
BEGIN
    SELECT salary
      INTO t_salary
      FROM employees
     WHERE employee_id = 200;
    DBMS_OUTPUT.PUT_LINE('SALARY : '||t_salary);
    CASE
        WHEN t_salary >= 5000 THEN
            DBMS_OUTPUT.PUT_LINE('고액연봉자');
        ELSE
            DBMS_OUTPUT.PUT_LINE('');
    END CASE;
END;    

-- 1 ~ 100 모두 더하기
-- WHILE문
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    total := 0;
    n := 1;
    WHILE n <= 100 LOOP
        total := total + n;
        n := n + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('TOTAL: '||total);
END;

-- FOR문
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    total := 0;
    FOR n IN 1 .. 100 LOOP
        total := total + n;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('TOTAL: '||total);
END;

-- 1부터 누적 합계를 구하다 최초 누적 합계가 3000 이상인 경우 LOOP문을 정지 시키고 출력
-- EXIT문 (java의 braek문)
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    n := 0;
    total := 0;
    WHILE TRUE LOOP
        n := n + 1;
        total := total + n;
        IF total >= 3000 THEN
            EXIT;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('N: '||n);
    DBMS_OUTPUT.PUT_LINE('TOTAL: '||total);
END;

-- CONTINUE문
-- 1 ~ 100 사이 모든 짝수의 합계를 구하시오.
DECLARE
    n NUMBER(3);
    total NUMBER(4);
BEGIN
    n := 0;
    total := 0;
    WHILE n <= 100 LOOP
        n := n + 1;
        IF MOD(n,2) = 1 THEN
            CONTINUE;
        END IF;
        total := total + n;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('TOTAL: '||total);
END;

-- 테이블 타입
-- 테이블의 데이터를 가져와서 배열처럼 사용하는 타입
DECLARE
    i NUMBER; -- 인덱스
    -- first_name_type : EMPLOYEES테이블의 FIRST_NAME칼럼값을 배열처럼 사용할 수 있는 타입
    TYPE first_name_type IS TABLE OF employees.first_name%TYPE INDEX BY BINARY_INTEGER;
    -- first_names : employees테이블의 first_name칼럼값을 실제로 저장하는 변수(배열)
    first_names first_name_type;
BEGIN
    i := 0;
    FOR v_row IN (SELECT first_name, last_name FROM employees) LOOP
        first_names(i) := v_row.first_name;
        DBMS_OUTPUT.PUT_LINE(first_names(i)||' '||v_row.last_name);
        i := i + 1;
    END LOOP;
END;

-- 부서번호(department_id)가 50인 부서의 first_name, last_name을 가져와서
-- 새로운 테이블 employees50에 삽입하시오.
CREATE TABLE employees50
        AS(SELECT first_name, last_name FROM employees WHERE 1 = 0);
BEGIN
    FOR v_row IN (SELECT first_name, last_name FROM employees WHERE department_id = 50) LOOP
        INSERT INTO employees50 VALUES (v_row.first_name, v_row.last_name);
    END LOOP;
    COMMIT;
END;
SELECT first_name, last_name FROM employees50;
DROP TABLE employees50;

-- 레코드 타입
-- 여러 칼럼(열)이 모여서 하나의 레코드(행,ROW)가 된다.
-- 여러 데이터를 하나로 모으는 개념 : 객체(변수 + 함수)의 하위 개념 -> 구조체(변수)
DECLARE 
    TYPE person_type IS RECORD(
        my_name VARCHAR2(20),
        my_age NUMBER(3)
    );
    man person_type;
    woman person_type;
BEGIN
    man.my_name := '제임스';
    man.my_age := 20;
    woman.my_name := '엘리스';
    woman.my_age := 18;
    DBMS_OUTPUT.PUT_LINE(man.my_name||' '||man.my_age);
    DBMS_OUTPUT.PUT_LINE(woman.my_name||' '||woman.my_age);
END;

-- 테이블형 레코드 타입
-- 부서번호(department_id)가 50인 부서의 전체 칼럼을 가져와서
-- 새로운 테이블 employees50에 삽입하시오.
DROP TABLE employees2;
CREATE TABLE employees2
    AS(SELECT * FROM employees WHERE 1 = 0);

DECLARE
    row_data employees%ROWTYPE; -- employees테이블의 ROW전체를 저장할 수 있는 변수
    emp_id Employees.employee_id%TYPE;
BEGIN
    FOR emp_id IN 100 .. 206 LOOP
        SELECT *
          INTO row_data 
          FROM employees
         WHERE employee_id = emp_id;
        INSERT INTO employees2 VALUES row_data;
    END LOOP;
END;

SELECT first_name, last_name FROM employees2;

-- 예외 처리
SET SERVEROUTP ON;
DECLARE
    v_last_name employees.last_name%TYPE;
BEGIN
    SELECT last_name 
      INTO v_last_name
      FROM employees
     WHERE employee_id = 1;
    DBMS_OUTPUT.PUT_LINE('사원: ' || v_last_name); 
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원이 없다'); 
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('해당 사원이 많다');
END;

-- 모든 예외 처리    
DECLARE
    v_last_name employees.last_name%TYPE;
BEGIN
    SELECT last_name 
      INTO v_last_name
      FROM employees
     WHERE employee_id = 5;
    DBMS_OUTPUT.PUT_LINE('사원: ' || v_last_name); 
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외 코드: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE('예외 메시지: '||SQLERRM);
END;