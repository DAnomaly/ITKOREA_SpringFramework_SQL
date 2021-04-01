-- 고객 릴레이션
CREATE TABLE 고객
(
    고객아이디 VARCHAR2(30) PRIMARY KEY,
    고객이름 VARCHAR2(30),
    나이 NUMBER(3),
    등급 CHAR(1),
    직업 VARCHAR2(5),
    적립금 NUMBER(7)
);

-- 주문 릴레이션
CREATE TABLE 주문
(
    주문번호 NUMBER PRIMARY KEY,
    주문고객 VARCHAR2(30) REFERENCES 고객(고객아이디), -- 외래키(고객테이블의 고객아이디 칼럼을 참조), FOREIGN KEY(FK)
    주문재품 VARCHAR2(20),
    수량 NUMBER,
    단가 NUMBER,
    주문일자 DATE
);
