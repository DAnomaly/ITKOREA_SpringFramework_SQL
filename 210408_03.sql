-- 시퀀스
-- 1. 일련번호 생성 객체이다.
-- 2. 주로 기본키(인공키)에서 사용한다.
-- 3. currval : 시퀀스가 생성해서 사용한 현제 번호
-- 4. nextval : 시퀀스가 생성해야 할 다음 번호

-- 시퀀스 생성
CREATE SEQUENCE employee_seq
INCREMENT BY 1 -- 번호가 1씩 증가한다
START WITH 1000 -- 번호 시작이 1000이다
NOMAXVALUE -- 최대값 없음 (MAXVALUE 999999)
NOMINVALUE -- 최소값 없음
NOCYCLE -- 번호 순환이 없다
NOCACHE; -- 메모리에 캐시하지 않는다: 항상 유지

-- employee3 테이블에 행 삽입
-- emp_no는 시퀀스로 입력
INSERT INTO employee3 
    (emp_no,name,depart,position,gender,hire_date,salary) 
VALUES 
    (employee_seq.nextval,'구창민',1,'과장','M','95-05-01',5000000);

-- 시퀀스 값 확인
SELECT employee_seq.currval
  FROM dual;

-- 시퀀스 목록 확인
SELECT *
  FROM user_sequences;
  
-- ROWNUM : 가상 행 번호
-- ROWID : 데이터가 저장된 물리적 위치 정보
SELECT ROWNUM
     , ROWID
     , emp_no
     , name
  FROM employee;
  
-- 최고 빠른 검색 : ROWID를 이용한 검색 (오라클의 검색 방식)
SELECT emp_no
     , name
  FROM employee
 WHERE ROWID = 'AAAFDIAABAAALDBAAB';
 
-- 그 다음 빠른 검색 : INDEX를 이용한 검색 (휴먼의 검색 방식)
SELECT emp_no
     , name
  FROM employee
 WHERE emp_no = 1003;
 
-- ROWNUM의 WHERE절 사용
-- 주의.
-- 1. 1을 포함하는 검색만 가능하다
-- 2. 순서대로 몇 건을 추출하기 위한 목적이다
-- 3. 특정 위치를 지정한 검색을 불가능하다
SELECT emp_no
     , name
  FROM employee
 WHERE ROWNUM = 1; -- 가능하다

SELECT emp_no
     , name
  FROM employee
 WHERE ROWNUM = 2; -- 불가능하다
 
SELECT emp_no
     , name
  FROM employee
 WHERE ROWNUM BETWEEN 1 AND 3; -- 가능하다
 
SELECT emp_no
     , name
  FROM employee
 WHERE ROWNUM BETWEEN 3 AND 5; -- 불가능하다
 
-- 1 이외의 번호로 시작하는 모든 ROWNUM을 사용하기 위해서는
-- ROWNUM에 별명을 주고 별명을 사용한다
SELECT e.rn, e.emp_no, e.name
FROM(SELECT ROWNUM AS rn
          , emp_no
          , name
       FROM employee) e
WHERE e.rn = 2;

-- 연습문제
-- 1. 다음 테이블을 생성한다
-- 게시판(글번호, 글제목, 글내용, 글작성자, 작성일자)
-- 회원(회원번호, 아이디, 이름, 가입일자)
CREATE TABLE BOARD (
    board_no NUMBER,
    board_title VARCHAR2(30),
    board_content VARCHAR2(300),
    member_no NUMBER,
    board_date DATE
);

CREATE TABLE MEMBER(
    member_no NUMBER,
    member_id VARCHAR2(30),
    member_name VARCHAR2(20),
    member_regdate DATE
);

-- 2. 각 테이블에서 사용할 시퀀스를 생성한다.
-- 게시판시퀀스(1~무제한)
-- 회원시퀀스(100000~999999)
CREATE SEQUENCE seq_board_no
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE seq_member_no
INCREMENT BY 1
START WITH 100000
MAXVALUE 999999
NOMINVALUE
NOCYCLE
NOCACHE;

-- 3. 각 테이블에서 적절한 기본키, 왜래키, 데이터(5개)를 추가한다.
ALTER TABLE board ADD CONSTRAINT board_pk PRIMARY KEY (board_no);
ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY (member_no);
ALTER TABLE board ADD CONSTRAINT board_member_fk FOREIGN KEY (member_no) REFERENCES member(member_no);

INSERT INTO member VALUES (seq_member_no.NEXTVAL,'APPLE','사과',SYSDATE);
INSERT INTO member VALUES (seq_member_no.NEXTVAL,'BLUEBE','블루베리',SYSDATE);
INSERT INTO member VALUES (seq_member_no.NEXTVAL,'BANNA','바나나',SYSDATE);
INSERT INTO member VALUES (seq_member_no.NEXTVAL,'GRAPE','포도',SYSDATE);
INSERT INTO member VALUES (seq_member_no.NEXTVAL,'MAGA','망고',SYSDATE);

INSERT INTO BOARD VALUES
(seq_board_no.NEXTVAL,'인사','안녕',100000,SYSDATE);
INSERT INTO BOARD VALUES
(seq_board_no.NEXTVAL,'인사','안녕하세요',100001,SYSDATE);
INSERT INTO BOARD VALUES
(seq_board_no.NEXTVAL,'점심','뭐먹을까',100000,SYSDATE);
INSERT INTO BOARD VALUES
(seq_board_no.NEXTVAL,'고민','고민중입니다',100001,SYSDATE);
INSERT INTO BOARD VALUES
(seq_board_no.NEXTVAL,'잠','zzz',100004,SYSDATE);

-- 4. 게시판을 제목의 가나다순으로 정렬하고 첫 번째 글을 조회한다.
SELECT board_title 
  FROM(SELECT board_title
         FROM board
        ORDER BY board_title)
 WHERE ROWNUM = 1;

-- 5. 게시판을 글번호의 가나다순으로 정렬하고 1 ~ 3번째 글을 조회한다.
SELECT board_no
     , board_title
     , board_content
     , member_no
     , board_date
  FROM board
 WHERE ROWNUM BETWEEN 1 AND 3
 ORDER BY board_no;

-- 6. 게시판의 최근 작성일자순으로 정렬하고 3 ~ 5번째 글을 조회한다.
SELECT board_no
     , board_title
     , board_content
     , member_no
     , board_date
  FROM(SELECT ROWNUM e
            , board_no
            , board_title
            , board_content
            , member_no
            , board_date
         FROM(SELECT board_no
                   , board_title
                   , board_content
                   , member_no
                   , board_date
                FROM board
               ORDER BY board_date DESC))
 WHERE e BETWEEN 3 AND 5;       

-- 7. 가장 먼저 가입한 회원을 조회한다.
SELECT member_no
     , member_id
     , member_name
     , member_regdate
  FROM(SELECT member_no
            , member_id
            , member_name
            , member_regdate
         FROM member
        ORDER BY member_regdate)
 WHERE ROWNUM = 1;

-- 8. 3번째로 가입한 회원을 조회한다.
SELECT member_no
     , member_id
     , member_name
     , member_regdate
     FROM(SELECT ROWNUM rn
               , member_no
               , member_id
               , member_name
               , member_regdate
            FROM(SELECT member_no
                      , member_id
                      , member_name
                      , member_regdate
                   FROM member
                  ORDER BY member_regdate))
 WHERE rn = 3;

-- 9. 가장 나중에 가입한 회원을 조회한다.
SELECT member_no
     , member_id
     , member_name
     , member_regdate
  FROM(SELECT member_no
            , member_id
            , member_name
            , member_regdate
         FROM member
        ORDER BY member_regdate DESC)
 WHERE ROWNUM = 1;
