
----------- 방법 1

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

-- NOT NULL : 필수입력
-- UNIQUE : 중복 불가
-- CHECK : 범위 지정

-- 테이블 변경
-- ALTER TABLE 테이블명 (ADD, REMOVE, MODIFY 등) 
ALTER TABLE bank ADD CONSTRAINT bank_pk PRIMARY KEY (bank_code);
ALTER TABLE customer ADD CONSTRAINT customer_pk PRIMARY KEY (no);
ALTER TABLE customer ADD CONSTRAINT customer_bank_fk FOREIGN KEY (bank_code) REFERENCES bank(bank_code);
ALTER TABLE customer ADD CONSTRAINT customer_uq UNIQUE (phone);
ALTER TABLE customer ADD CONSTRAINT customer_age_ck CHECK (age BETWEEN 0 AND 100);



----------- 방법 2 ( 내가 선호하는 방법 )

DROP TABLE customer;
DROP TABLE bank;

CREATE TABLE bank(
    bank_code VARCHAR2(20),
    bank_name VARCHAR2(30),
    CONSTRAINT bank_pk PRIMARY KEY (bank_code)
);

CREATE TABLE customer(
    no NUMBER,
    name VARCHAR2(30) NOT NULL,
    phone VARCHAR2(30),
    age number,
    bank_code VARCHAR2(20),
    CONSTRAINT customer_pk PRIMARY KEY (no),
    CONSTRAINT customer_bank_fk FOREIGN KEY (bank_code) REFERENCES bank(bank_code),
    CONSTRAINT customer_uq UNIQUE (phone),
    CONSTRAINT customer_age_ck CHECK (age BETWEEN 0 AND 100)
);

