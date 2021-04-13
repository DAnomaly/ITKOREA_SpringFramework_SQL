SET SERVEROUTP ON;

-- 1. 프로시저
--   1) 한 번에 처리할 수 있는 쿼리문의 집합
--   2) 결과(반환)가 있을 수도 있고, 없을 수도 있다.
--   3) EXECUTE(EXEC)를 통해서 실행한다.

-- 프로시저 정의
CREATE OR REPLACE PROCEDURE proc1 -- 프로시저명 : proc1
AS -- 변수 선언하는 곳. IS와 같다
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello Procedure');
END proc1; -- END 도 가능

-- 프로시저 실행
EXECUTE proc1();

-- 2) 프로시저에서 변수 선언하고 사용하기
CREATE OR REPLACE PROCEDURE proc2
AS
    my_age NUMBER;
BEGIN
    my_age := 20;
    DBMS_OUTPUT.PUT_LINE('age: '||my_age);
END proc2;

EXEC proc2();

-- 3) 입력 파라미터
-- 프로시저에 전달하는 값 : 인수
-- 문제 : employee_id를 입력 파라미터로 전달하면 해당 사원의 last_name 출력하기
CREATE OR REPLACE PROCEDURE proc3(in_employee_id NUMBER)
   IS
    v_last_name EMPLOYEES.LAST_NAME%TYPE;
BEGIN
    SELECT last_name
      INTO v_last_name
      FROM employees
     WHERE employee_id = in_employee_id;
    DBMS_OUTPUT.PUT_LINE('결과: ' || v_last_name);
END proc3(100);

EXEC proc3(100);

-- 4) 출력 파라미터
-- 프로시저의 실행 결과를 저장하는 파라미터
-- 함수와 비교하면 함수의 변환값
CREATE OR REPLACE PROCEDURE proc4(out_result OUT NUMBER)
    IS
 BEGIN SELECT MAX(salary) 
         INTO out_result 
         FROM employees;
   END proc4;

-- 프로시저를 호출할 때
-- 프로시저의 결과를 저장할 변수를 넘겨준다.
DECLARE
    max_salary NUMBER;
BEGIN
    proc4(max_salary); -- max_salary에 최고연봉이 저장되기를 기대
    DBMS_OUTPUT.PUT_LINE('최고연봉: '||max_salary);
END;

-- 5) 입출력 파라미터
-- 입력 : 사원번호
-- 출력 : 연봉
CREATE OR REPLACE PROCEDURE proc5(in_out_param IN OUT NUMBER)
    IS
    v_salary NUMBER;
BEGIN 
    SELECT salary
      INTO v_salary
      FROM employees
     WHERE employee_id = in_out_param;
    in_out_param := v_salary;
EXCEPTION    
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('예외 코드: '||SQLCODE);
        DBMS_OUTPUT.PUT_LINE('예외 메시지: '||SQLERRM);
END proc5;

DECLARE
    result NUMBER;
BEGIN
    result := 20;
    proc5(result);
    DBMS_OUTPUT.PUT_LINE('SALARY: ' || result);
END;
    
-- 문제 세팅
-- BOOK, CUSTOMER, ORDERS 테이블
ALTER TABLE BOOK ADD STOCK NUMBER NOT NULL;
ALTER TABLE CUSTOMER ADD POINT NUMBER;
ALTER TABLE ORDERS ADD AMOUNT NUMBER NOT NULL;
UPDATE BOOK SET STOCK = 10;
UPDATE CUSTOMER SET POINT = 1000;
UPDATE ORDERS SET AMOUNT = 1;
COMMIT;

CREATE SEQUENCE ORDERS_SEQ
INCREMENT BY 1
START WITH 11
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

-- EXEC proc_order(회원번호, 책번호, 구매수량);
-- 1. ORDERS 테이블에 주문 기록이 삽입된다. (ORDER_NO는 시퀀스 처리, SALES_PRICE는 사용 안함)
-- 2. CUSTOMER 테이블에 주문 총액(구매수량 * 책가격)의 10%를 POINT에 더해 준다.
-- 3. BOOK 테이블의 재고를 조절한다.
CREATE OR REPLACE PROCEDURE proc_order(in_customer_id NUMBER, in_book_id NUMBER, in_amount NUMBER)
IS
    in_sales_price orders.sales_price%TYPE;
    is_stock book.stock%TYPE; -- IF절에는 서브쿼리가 안됩니다
BEGIN
    -- 0. 제고 수량을 확인한다
    SELECT stock INTO is_stock FROM book WHERE book_id = in_book_id;
    IF is_stock < in_amount THEN
        DBMS_OUTPUT.PUT_LINE('제고가 부족합니다');
        RETURN;
    END IF;
    -- 0. SALES_PRICE의 값을 정한다.
    SELECT price * in_amount
      INTO in_sales_price
      FROM book
     WHERE book_id = in_book_id;
    -- 1. ORDERS 테이블에 주문 기록이 삽입된다.
    INSERT INTO orders(order_id,customer_id,book_id,sales_price,order_date,amount) 
         VALUES (ORDERS_SEQ.NEXTVAL,in_customer_id,in_book_id,in_sales_price,SYSDATE,in_amount);
    -- 2. CUSTOMER 테이블에 주문 총액(구매수량 * 책가격)의 10%를 POINT에 더해 준다.
    UPDATE customer 
       SET point = point + FLOOR(in_sales_price * 0.1)
     WHERE customer_id = in_customer_id;
    -- 3. BOOK 테이블의 재고를 조절한다.
    UPDATE book
       SET stock = stock - in_amount
     WHERE book_id = in_book_id;
END proc_order;

EXEC proc_order(3,7,10);

-- 2. 사용자 함수
--   1) 하나의 결과값이 있다. (RETURN이 있다.)
--   2) 주로 쿼리문에 포함된다.
CREATE OR REPLACE FUNCTION get_total(n NUMBER) -- 1부터 n까지의 합계를 반환하는 함수
RETURN NUMBER
AS -- IS, 변수 선언
    i NUMBER; -- 1 ~ n
    total NUMBER; -- 합계
BEGIN
    total := 0;
    i := 1;
    FOR i IN 1 .. n LOOP
        total := total + i;
    END LOOP;
    RETURN total; -- 반환
END get_total;

-- 함수의 확인
SELECT get_total(1000) FROM dual;

CREATE OR REPLACE FUNCTION get_grade(score NUMBER)
RETURN CHAR
AS
    grade CHAR(1);
BEGIN
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
    RETURN grade;
END get_grade;

-- 함수의 확인
SELECT get_grade(90) FROM dual; -- A

-- 3. 트리거
--   1) INSERT, UPDATE, DELETE 작업을 수행하면 자동으로 실행되는 작업이다.
--   2) BEFORE, AFTER 트리거를 많이 사용한다.

CREATE OR REPLACE TRIGGER trig1
    BEFORE  -- 수행 이전에 자동으로 실행된다
    INSERT OR UPDATE OR DELETE  -- 트리거가 동작할 작업을 고른다
    ON employees -- 트리거가 동작할 테이블이다
    FOR EACH ROW -- 한 행씩 적용된다
BEGIN
    DBMS_OUTPUT.PUT_LINE('HELLO TRIGGER');
END trig1;

-- 트리거 동작 확인
UPDATE employees SET salary = 25000 WHERE employee_id = 100;
DELETE FROM employees WHERE employee_id = 206;

CREATE OR REPLACE TRIGGER trig2
    AFTER -- 수행 이후에 자동으로 실행된다
    INSERT OR UPDATE OR DELETE
    ON employees
    FOR EACH ROW
BEGIN
    IF INSERTING THEN -- 삽입이었다면,
        DBMS_OUTPUT.PUT_LINE('INSERT 작업하였습니다');
    ELSIF UPDATING THEN -- 갱신이었다면,
        DBMS_OUTPUT.PUT_LINE('UPDATE 작업하였습니다');
    ELSIF DELETING THEN
        DBMS_OUTPUT.PUT_LINE('DELETE 작업하였습니다');
    END IF;
END trig2;
        
UPDATE employees SET salary = 25000 WHERE employee_id = 100;

-- 트리거 삭제
DROP TRIGGER trig1;
DROP TRIGGER trig2;

-- 문제.
-- emplyees 테이블에서 삭제된 데이터는 퇴사자(retire) 테이블에 자동으로 저장되는
-- 트리거를 작성하시오.
--       INSERT     UPDATE      DELETE
-- :OLD  NULL       수정전값    삭제전값
-- :NEW  추가된값   수정후값    NULL

-- 1. 퇴사자 테이블을 생성한다.
--    retire_id, employee_id, last_name, department_id, hire_date, retire_date
CREATE TABLE retire(
    retire_id NUMBER,
    employee_id NUMBER,
    last_name VARCHAR(25),
    department_id NUMBER,
    hire_date DATE,
    retire_date DATE
);

ALTER TABLE retire ADD CONSTRAINT retire_pk PRIMARY KEY (retire_id);
CREATE SEQUENCE retire_seq
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

-- 2. 트리거를 생성한다.
CREATE OR REPLACE TRIGGER retire_trig
    AFTER
    DELETE
    ON employees
    FOR EACH ROW
BEGIN
    INSERT INTO retire 
        (retire_id, employee_id, last_name, department_id, hire_date, retire_date)
    VALUES (retire_seq.nextval, :OLD.employee_id, :OLD.last_name, :OLD.department_id, :OLD.hire_date, SYSDATE);
END retire_tirg;

-- 3. 삭제를 통해 트리거 동작을 확인한다
DELETE FROM employees WHERE department_id = 50;
SELECT retire_id
     , employee_id
     , last_name
     , department_id
     , hire_date
     , retire_date
  FROM retire;
