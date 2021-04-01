
-- 테이블 생성 순서 : 부모(PK) -> 자식(FK)


-- 1:1 관계 테이블
-- 1:1 관계 테이블은 어느 엔티티 쪽에서든 반드시 단 한개만 소유하고 있는 테이블 관계입니다
CREATE TABLE product(
    pro_idx NUMBER(5) PRIMARY KEY,
    pro_price NUMBER,
    pro_count NUMBER
);

CREATE TABLE product_content(
    pro_idx NUMBER(5) PRIMARY KEY REFERENCES product(pro_idx),
    pro_content_name VARCHAR2(50),
    pro_content_content VARCHAR2(300)
);
--DROP TABLE product_content;
--DROP TABLE product;


-- 1:M 관계 테이블
-- 1:M 관계 테이블이란 한 쪽 엔티티가 관계를 맺는 엔티티 쪽의 여러 객체를 가질 수 있는 것
CREATE TABLE school(
    school_no NUMBER(5) PRIMARY KEY,
    school_name VARCHAR2(30)
);

CREATE TABLE student(
    student_no NUMBER(6) PRIMARY KEY,
    school_no NUMBER(5) REFERENCES school(school_no),
    student_name VARCHAR2(30)
);
-- DROP TABLE SCHOOL CASCADE CONSTRAINTS; 
-- DROP TABLE STUDENT CASCADE CONSTRAINTS;

-- 테이블 구조 변경으로 인해, 외래키를 지정하는 코드
--ALTER TABLE STUDENT ADD FOREIGN KEY (school_no) REFERENCES school(school_no);



-- N:M 관계 테이블
-- N:M 관계 테이블이란 1:M 관계를 가진 엔티티를 다중으로 소유할 경우 N:M테이블이라 한다
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
-- DROP TABLE enroll CASCADE CONSTRAINTS;
-- DROP TABLE student CASCADE CONSTRAINTS;
-- DROP TABLE subject CASCADE CONSTRAINTS;

--------------------------------------------------------------

-- 연습문제
CREATE TABLE member(
    member_no NUMBER(5),
    member_id VARCHAR2(30),
    member_pw VARCHAR2(30),
    member_name VARCHAR2(30),
    member_email VARCHAR2(50),
    member_regdate DATE DEFAULT sysdate,
    PRIMARY KEY(member_no)
);

CREATE TABLE board(
    board_no NUMBER(6),
    board_title VARCHAR2(300) NOT NULL,
    board_content VARCHAR2(3000),
    board_hit NUMBER(10),
    member_no NUMBER(5),
    board_date DATE DEFAULT sysdate,
    PRIMARY KEY(board_no),
    FOREIGN KEY(member_no) REFERENCES member(member_no)
);

CREATE TABLE delivery_service(
    delivery_service_no VARCHAR2(12),
    delivery_service_name VARCHAR2(20),
    delivery_service_phone VARCHAR2(15),
    delivery_service_address VARCHAR2(100),
    PRIMARY KEY(delivery_service_no)
);

CREATE TABLE delivery(
    delivery_no NUMBER,
    delivery_service_no VARCHAR2(12),
    delivery_price NUMBER,
    delivery_date DATE,
    PRIMARY KEY(delivery_no),
    FOREIGN KEY(delivery_service_no) REFERENCES delivery_service(delivery_service_no)
);

CREATE TABLE orders(
    orders_no NUMBER(6),
    member_no NUMBER(5),
    delivery_no NUMBER(8),
    orders_date DATE,
    PRIMARY KEY(orders_no),
    FOREIGN KEY(member_no) REFERENCES member(member_no),
    FOREIGN KEY(delivery_no) REFERENCES delivery(delivery_no)
);

CREATE TABLE manufacturer(
    manufacturer_no VARCHAR2(12),
    manufacturer_name VARCHAR2(100),
    manufacturer_phone VARCHAR2(15),
    PRIMARY KEY (manufacturer_no)
);

CREATE TABLE warehouse(
    warehouse_no NUMBER,
    warehouse_name VARCHAR2(5),
    warehouse_location VARCHAR2(100),
    warehouse_used VARCHAR2(1),
    PRIMARY KEY(warehouse_no)
);

CREATE TABLE product(
    product_no VARCHAR2(10),
    product_name VARCHAR2(50),
    product_price NUMBER,
    product_category VARCHAR2(15),
    orders_no NUMBER,
    manufacturer_no VARCHAR2(12),
    warehouse_no NUMBER,
    PRIMARY KEY (product_no),
    FOREIGN KEY (orders_no) REFERENCES orders(orders_no),
    FOREIGN KEY (manufacturer_no) REFERENCES manufacturer(manufacturer_no),
    FOREIGN KEY (warehouse_no) REFERENCES warehouse(warehouse_no)
);

DROP TABLE product;
DROP TABLE warehouse;
DROP TABLE manufacturer;
DROP TABLE orders;
DROP TABLE delivery;
DROP TABLE delivery_service;
DROP TABLE board;
DROP TABLE member;
