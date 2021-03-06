CREATE TABLE EMPLOYEE(
    EMP_NO NUMBER,
    NAME VARCHAR2(15),
    DEPART NUMBER,
    POSITION VARCHAR2(10),
    GENDER CHAR(2),
    HIRE_DATE DATE,
    SALARY NUMBER
);

CREATE TABLE DEPARTMENT(
    DEPT_NO NUMBER,
    DEPT_NAME VARCHAR2(15),
    LOCATION VARCHAR2(15)
);

ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_PK PRIMARY KEY (EMP_NO);
ALTER TABLE DEPARTMENT ADD CONSTRAINT DEPARTMENT_PK PRIMARY KEY (DEPT_NO);
ALTER TABLE EMPLOYEE ADD CONSTRAINT EMPLOYEE_DEPARTMENT_FK FOREIGN KEY (DEPART) REFERENCES DEPARTMENT(DEPT_NO);;

INSERT INTO DEPARTMENT VALUES (1,'영업부','대구');
INSERT INTO DEPARTMENT VALUES (2,'인사부','서울');
INSERT INTO DEPARTMENT VALUES (3,'총무부','대구');
INSERT INTO DEPARTMENT VALUES (4,'기획부','서울');

INSERT INTO EMPLOYEE VALUES (1001,'구창민',1,'과장','M','95/05/01',5000000);
INSERT INTO EMPLOYEE VALUES (1002,'김민서',1,'사원','M','17/09/01',2500000);
INSERT INTO EMPLOYEE VALUES (1003,'이은영',2,'부장','F','90/09/01',5500000);
INSERT INTO EMPLOYEE VALUES (1004,'한성일',2,'과장','M','93/04/01',5000000);

COMMIT;

-- 카테젼 곱
-- 두 테이브르이 조인 조건(관계) 이 잘못되거나 없을 때 나타난다.
SELECT
       E.EMP_NO
     , E.NAME
     , D.DEPT_NAME
     , E.POSITION
     , E.HIRE_DATE
     , E.SALARY
  FROM EMPLOYEE E, DEPARTMENT D;
  
SELECT
       E.EMP_NO
     , E.NAME
     , D.DEPT_NAME
     , E.POSITION
     , E.HIRE_DATE
     , E.SALARY
  FROM EMPLOYEE E
 CROSS JOIN DEPARTMENT D;  
 
-- 내부 조인
-- INNER JOIN
-- 양쪽 테이블에 모두 존재하는 데이터만 조인하는 것
SELECT
       E.EMP_NO
     , E.NAME
     , D.DEPT_NAME
     , E.POSITION
     , E.HIRE_DATE
     , E.SALARY
  FROM EMPLOYEE E INNER JOIN DEPARTMENT D
    ON E.DEPART = D.DEPT_NO;
    
SELECT
       E.EMP_NO
     , E.NAME
     , D.DEPT_NAME
     , E.POSITION
     , E.HIRE_DATE
     , E.SALARY
  FROM EMPLOYEE E, DEPARTMENT D
 WHERE E.DEPART = D.DEPT_NO;

ALTER TABLE EMPLOYEE DISABLE CONSTRAINT EMPLOYEE_DEPARTMENT_FK;
INSERT INTO EMPLOYEE VALUES(1005,'김미나',5,'사원','F','18-05-01',1800000);
ALTER TABLE EMPLOYEE ENABLE CONSTRAINT EMPLOYEE_DEPARTMENT_FK;

-- 외부 조인
-- OUTER JOIN
SELECT 
       E.EMP_NO
     , E.NAME
     , D.DEPT_NAME
     , E.POSITION
  FROM EMPLOYEE E LEFT OUTER JOIN DEPARTMENT D
    ON E.DEPART = D.DEPT_NO;
    
SELECT 
       E.EMP_NO
     , E.NAME
     , D.DEPT_NAME
     , E.POSITION
  FROM DEPARTMENT D RIGHT OUTER JOIN EMPLOYEE E
    ON E.DEPART = D.DEPT_NO;
    
SELECT 
       E.EMP_NO
     , E.NAME
     , D.DEPT_NAME
     , E.POSITION
  FROM DEPARTMENT D, EMPLOYEE E
 WHERE E.DEPART = D.DEPT_NO(+);
 
SELECT 
       D.DEPT_NO
     , COUNT(E.EMP_NO) AS 사원수
  FROM DEPARTMENT D LEFT OUTER JOIN EMPLOYEE E
    ON D.DEPT_NO = E.DEPART
 GROUP BY D.DEPT_NO;
 
    

-- 리뷰 1. 모든 사원들의 name, dept_name 을 조회하시오. (부서가 없는 사원은 조회하지 마시오.)
SELECT
       e.name
     , d.dept_name
  FROM department d INNER JOIN employee e 
    ON d.dept_no = e.depart;

SELECT
       e.name
     , d.dept_name
  FROM department d, employee e 
 WHERE d.dept_no = e.depart;

-- 리뷰 2. '서울'에서 근무하는 사원들의 emp_no, name을 조회하시오.
SELECT
       e.emp_no
     , e.name
  FROM department d INNER JOIN employee e
    ON d.dept_no = e.depart
 WHERE d.location = '서울';
 
SELECT
       e.emp_no
     , e.name
  FROM department d, employee e
 WHERE d.dept_no = e.depart
   AND d.location = '서울';
 
-- 리뷰 3. 모든 사원들의 name, dept_name을 조회하시오. ( 부서가 없는 사원도 조회하시오.)
SELECT
       e.name
     , d.dept_name
  FROM department d RIGHT OUTER JOIN employee e
    ON d.dept_no = e.depart;

SELECT
       e.name
     , d.dept_name
  FROM department d, employee e
 WHERE d.dept_no(+) = e.depart;
