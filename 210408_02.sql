-- 뷰
-- 1. 기존 테이블을 이용해서 생성한 가상테이블이다.
-- 2. 디스크 대신 데이터사전에만 등록된다.

-- 뷰 생성 연습
CREATE VIEW TEST_VIEW 
    AS (SELECT emp_no
             , name 
          FROM employee);

SELECT /** HINT */
       emp_no
     , name
  FROM test_view;

CREATE VIEW TEST_VIEW2
    AS (SELECT *
          FROM employee
         WHERE position = '과장');

SELECT *
  FROM TEST_VIEW2;

CREATE VIEW DEPART_VIEW
    AS (SELECT /** TABLE : department d, employee e */
               e.emp_no
             , e.name
             , e.position
             , d.dept_name
          FROM department d RIGHT OUTER JOIN employee e
            ON d.dept_no = e.depart);

SELECT emp_no
     , name
     , position
     , dept_name
  FROM depart_view;

-- 여기서 작성한 VIEW 테이블
DROP VIEW TEST_VIEW;
DROP VIEW TEST_VIEW2;
DROP VIEW depart_view;