
DESC bank;
DESC customer;

DROP TABLE customer;
DROP TABLE bank;

CREATE TABLE bank(
    bank_code VARCHAR2(20),
    bank_name VARCHAR2(30)
);

CREATE TABLE customer(
    no NUMBER,
    name VARCHAR2(30) NOT NULL,
    phone VARCHAR2(30),
    age number,
    bank_code VARCHAR2(20)
);

-- 테이블 변경
-- 칼럼의 추가
-- ALTER TABLE 테이블 ADD 칼럼명 타입;
-- 1. bank 테이블에 bank_phone 칼럼을 추가한다.
ALTER TABLE bank ADD bank_phone varchar2(15);

-- 칼럼의 수정
-- ALTER TABLE 테이블 MODIFY 칼럼명 타입;
-- 1. bank 테이블에 bank_name 칼럼을 varchar2(15)로 수정한다.
ALTER TABLE bank MODIFY bank_name varchar2(15);

-- 2. customer 테이블의 age 칼럼을 number(3)로 수정한다.
ALTER TABLE customer MODIFY age NUMBER(3);

-- 3. customer 테이블의 phone 칼럼을 NOT NULL로 수정한다.
ALTER TABLE customer MODIFY phone VARCHAR2(30) NOT NULL;

-- 4. customer 테이블의 phone 칼럼을 NULL로 수정한다.
ALTER TABLE customer MODIFY phone VARCHAR2(30) NULL;

-- 칼럼의 삭제
-- ALTER TABLE 테이블 DROP COLUMN 칼럼명;
-- 1. bank 테이블의 bank_phone 칼럼을 삭제한다
ALTER TABLE bank DROP COLUMN bank_phone;

-- 칼럼의 이름 변경
-- ALTER TABLE 테이블 RENAME COLUMN 기존칼럼 TO 신규칼럼명;
-- 1. customer 테이블의 phone 칼럼명을 contact로 수정한다
ALTER TABLE customer RENAME COLUMN phone TO contack;



