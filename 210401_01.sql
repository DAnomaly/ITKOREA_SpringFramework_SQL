
-- DROP TABLE SCHOOL CASCADE CONSTRAINTS; 
-- DROP TABLE STUDENT CASCADE CONSTRAINTS;

-- 테이블 생성 순서 : 부모(PK) -> 자식(FK)
-- 1:M 관계 테이블
CREATE TABLE school(
    school_no NUMBER(5) PRIMARY KEY,
    school_name VARCHAR2(30)
);

CREATE TABLE student(
    student_no NUMBER(6) PRIMARY KEY,
    school_no NUMBER(5) REFERENCES school(school_no),
    student_name VARCHAR2(30)
);

-- 테이블 구조 변경으로 인해, 외래키를 지정하는 코드
--ALTER TABLE STUDENT ADD FOREIGN KEY (school_no) REFERENCES school(school_no);


-- DROP TABLE enroll CASCADE CONSTRAINTS;
-- DROP TABLE student CASCADE CONSTRAINTS;
-- DROP TABLE subject CASCADE CONSTRAINTS;

-- N:M 관계 테이블
CREATE TABLE student(
    student_no NUMBER(5) PRIMARY KEY,
    student_name VARCHAR(20) NOT NULL,
    student_age NUMBER(4)
);

CREATE TABLE subject(
    subject_no NUMBER(3) PRIMARY KEY,
    subject_name VARCHAR(20) NOT NULL,
    teacher_name VARCHAR(20)
);

CREATE TABLE enroll(
    rc_no NUMBER(5) PRIMARY KEY,
    student_no NUMBER(5) REFERENCES student(student_no),
    subject_no NUMBER(3) REFERENCES subject(subject_no)
);

--------------------------------------------------------------

-- 연습문제
CREATE TABLE member(
    member_no NUMBER(5) PRIMARY KEY,
    member_id VARCHAR2(30) UNIQUE,
    member_pw VARCHAR2(30) NOT NULL,
    member_name VARCHAR2(30) NOT NULL,
    member_email VARCHAR2(50),
    member_regdate DATE DEFAULT sysdate
);

CREATE TABLE board(
    board_no NUMBER(6) PRIMARY KEY,
    board_title VARCHAR2(300) NOT NULL,
    board_content VARCHAR2(3000),
    board_hit NUMBER(10),
    member_id VARCHAR2(30) REFERENCES MEMBER(member_id),
    board_date DATE DEFAULT sysdate
);

CREATE TABLE delivery_service(
    delivery_service_no VARCHAR2(12) PRIMARY KEY,
    delivery_service_name VARCHAR2(20),
    delivery_service_phone VARCHAR2(15),
    delivery_service_address VARCHAR2(100)
);

CREATE TABLE delivery(
    delivery_no NUMBER PRIMARY KEY,
    delivery_service_no VARCHAR2(12) REFERENCES delivery_service(delivery_service_no),
    delivery_price NUMBER,
    delivery_date DATE
);

CREATE TABLE orders(
    orders_no NUMBER(6) PRIMARY KEY,
    member_id VARCHAR2(30) REFERENCES MEMBER(member_id),
    delivery_no NUMBER(8) REFERENCES delivery(delivery_no),
    orders_date DATE DEFAULT sysdate
);

CREATE TABLE manufacturer(
    manufacturer_no VARCHAR2(12) PRIMARY KEY,
    manufacturer_name VARCHAR2(100) NOT NULL,
    manufacturer_phone VARCHAR2(15) UNIQUE
);

CREATE TABLE warehouse(
    warehouse_no NUMBER PRIMARY KEY,
    warehouse_name VARCHAR2(5),
    warehouse_location VARCHAR2(100) NOT NULL,
    warehouse_used VARCHAR2(1) DEFAULT 'N'
);

CREATE TABLE product(
    product_no VARCHAR2(10) PRIMARY KEY,
    product_name VARCHAR2(50) NOT NULL,
    product_price NUMBER,
    product_category VARCHAR2(15),
    orders_no NUMBER REFERENCES orders(orders_no),
    manufacturer_no VARCHAR2(12) REFERENCES manufacturer(manufacturer_no),
    warehouse_no NUMBER REFERENCES warehouse(warehouse_no)
);

DROP TABLE product;
DROP TABLE warehouse;
DROP TABLE manufacturer;
DROP TABLE orders;
DROP TABLE delivery;
DROP TABLE delivery_service;
DROP TABLE board;
DROP TABLE member;
