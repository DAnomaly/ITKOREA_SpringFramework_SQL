-- 오라클 내장 함수
DROP TABLE SCORE;

CREATE TABLE score(
    kor NUMBER(3),
    eng NUMBER(3),
    mat NUMBER(3)
);

INSERT INTO score VALUES (70,80,90);
INSERT INTO score VALUES (60,60,50);
INSERT INTO score VALUES (70,50,90);
INSERT INTO score VALUES (40,30,55);
INSERT INTO score VALUES (45,45,45);
INSERT INTO score VALUES (75,65,80);

-- 1. 집계 함수

-- 1) 국어(kor) 점수의 합계를 구한다.
SELECT SUM(kor) FROM score; -- 칼럼이 1개인 테이블로 보여진다
SELECT SUM(kor) 합계 FROM score; -- 칼럼의 이름이 '합계'이다.
SELECT SUM(kor) AS 국어점수합계 FROM score; -- 칼럼의 이름이 '국어점수합계'이다.

-- 2) 모든 점수의 합계를 구한다.
SELECT SUM(kor), SUM(eng), SUM(mat) FROM score;
SELECT SUM(kor) + SUM(eng) + SUM(mat) FROM score;
SELECT SUM(kor) + SUM(eng) + SUM(mat) AS 합계 FROM score;

-- 3) 국어(kor) 점수의 평균을 구한다.
SELECT AVG(kor) AS 국어평균 FROM score;

-- 4) 수학(mat) 점수의 최댓값을 구한다.
SELECT MAX(mat) AS 수학평균 FROM score;

-- 5) 영어(eng) 점수의 최소값을 구한다.
SELECT MIN(eng) AS 영어평균 FROM score;

-- 'NAME' 칼럼을 추가하고, 적당한 이름을 삽입하시오
ALTER TABLE score ADD name VARCHAR2(20);
UPDATE score SET name = 'sky  ' WHERE kor = 70;
UPDATE score SET name = 'cloud ' WHERE kor = 60;
UPDATE score SET name = 'jadu ' WHERE kor = 40;
UPDATE score SET name = 'cream ' WHERE kor = 45;
UPDATE score SET name = 'hodu ' WHERE kor = 75;

-- 국어점수 중 임의로 2개를 NULL로 수정하시오
UPDATE score SET kor = NULL WHERE name IN('구름','호두');

-- 6) 이름의 개수를 구하시오
SELECT COUNT(name) FROM score;

-- 7) 국어점수의 개수를 구하시오
SELECT COUNT(kor) FROM score;

-- 8) 학생의 개수를 구하시오
SELECT COUNT(*) FROM score;

-- 2. 문자 함수

-- 1) 대소문자 관련 함수
SELECT INITCAP(name) FROM score;
SELECT UPPER(name) FROM score;
SELECT LOWER(name) FROM score;

-- 2) 문자열의 길이 반환 함수
SELECT LENGTH(name) FROM score;

-- 3) 문자열의 일부 반환 함수
SELECT SUBSTR(name,2,3) FROM score;

-- 4) 문자열에서 특정 문자의 포함된 위치 반환 함수
SELECT INSTR(name, 'j') FROM score;
SELECT INSTR(UPPER(name),'J') FROM score;

-- 5) 왼쪽 패딩
SELECT LPAD(name,10,'*') FROM score;

-- 6) 오른쪽 패딩
SELECT RPAD(name,10,'*') FROM score;

-- 모든 name을 오른쪽 맞춤해서 출력
SELECT LPAD(name,10,' ') FROM score;

-- 모든 name을 다음과 같이 출력
-- jadu : ja**
-- cloud : cl***
SELECT RPAD(SUBSTR(name,1,2),LENGTH(name),'*') FROM score;

-- 7) 문자열 연결 함수
-- Oracle에서 연산자 || 는 OR이 아니라, 연결 연산자이다.

-- JADU 10 10 10
SELECT name || ' ' || kor || ' ' || eng || ' ' || mat FROM score;

SELECT CONCAT(name,CONCAT(' ',CONCAT(kor,CONCAT(' ',CONCAT(eng,CONCAT(' ',mat)))))) FROM score;

-- 8) 불필요한 문자열 제거 함수 (좌우만 가능하고, 중간에 포함된 건 불가능)
SELECT RTRIM(name) FROM score;
SELECT LENGTH(RTRIM(name)) FROM score;
SELECT LTRIM(name) FROM score;
SELECT LENGTH(LTRIM(name)) FROM score;
SELECT TRIM(name) FROM score;
SELECT LENGTH(TRIM(name)) FROM score;

-- 다음 데이터를 삽입한다.
-- 80, 80, 80 james bond
INSERT INTO score VALUES(80,80,80,'james bond');

-- 아래와 같이 출력하나다
-- frist_name last_name
-- james      bond
SELECT 
SUBSTR(name,1,INSTR(name,' ')-1) AS first_name,
SUBSTR(name,INSTR(name,' ')+1) AS last_name
FROM score 
WHERE name LIKE 'james%';


