-- 3. 숫자 함수

-- 테이블을 사용하지 않는 SELECT문에서는 DUAL 테이블을 사용합니다
DESC DUAL;
SELECT DUMMY FROM DUAL;

-- 1) 반올림 함수
-- ROUND(값, 자리수)
SELECT ROUND(123.4567, 2) FROM DUAL;-- 소수 두번째 자리까지 반올림
SELECT ROUND(123.4567, 1) FROM DUAL;-- 소수 첫번째 자리까지 반올림
SELECT ROUND(123.4567, 0) FROM DUAL;-- 소수 첫번째 자리에서 반올림 (소수부분을 없앤다)
SELECT ROUND(123.4567, -1) FROM DUAL;-- 정수 첫번째 자리에서 반올림
SELECT ROUND(123.4567, -2) FROM DUAL;-- 정수 두번째 자리에서 반올림

-- 2) 올림 함수
-- CEIL(값) : 정수로 올림
-- 자릿수 조정을 계산을 통해서 처리합니다.
SELECT CEIL(123.4567) FROM DUAL; -- 124
SELECT CEIL(123.4567 * 10)/10 FROM DUAL; -- 123.5
SELECT CEIL(123.4567 * 100)/100 FROM DUAL; -- 123.46
SELECT CEIL(123.4567 * 0.1) / 0.1 FROM DUAL; -- 130

-- 3) 내림 함수
-- FLOOR(값) : 정수로 내림
SELECT FLOOR(123.4567) FROM DUAL; -- 123
SELECT FLOOR(123.4567 * 10)/10 FROM DUAL; -- 123.4
SELECT FLOOR(123.4567 * 100)/100 FROM DUAL; -- 123.45
SELECT FLOOR(123.4567 * 0.1) / 0.1 FROM DUAL; -- 120

-- 4) 절사 함수
-- TRUNC(값, 자리수)
SELECT TRUNC(567.89859,2) FROM DUAL; -- 소수 두자리까지 남기고 잘라내기
SELECT TRUNC(567.89859,1) FROM DUAL; -- 소수 한자리까지 남기고 잘라내기
SELECT TRUNC(567.89859,0) FROM DUAL; -- 정수 자리까지 잘라내기
SELECT TRUNC(567.89859,-1) FROM DUAL; -- 정수 첫번째 자리에서부터 잘라내기
SELECT TRUNC(567.89859,-2) FROM DUAL; -- 정수 두번째 자리에서부터 잘라내기

-- 내림(FLOOR)과 절사(TRUNC)의 차이
-- 음수에서 차이가 발생합니다
SELECT FLOOR(-123.456) FROM DUAL; -- -124
SELECT TRUNC(-123.456,0) FROM DUAL; -- -123

-- 반올림(ROUND)와 절사(TRUNC)에 자리수를 지정하지 않으면 소수 첫번째 자리에서 처리합니다
SELECT ROUND(123.4567) FROM DUAL; -- 123
SELECT TRUNC(123.4567) FROM DUAL; -- 123

-- 5) 절대값
-- ABS (값)
SELECT ABS(-5) FROM DUAL; -- 5

-- 6) 부호 판별
-- SIGN(값)
-- 값이 양수이면 1
-- 값이 음수이면 -1
-- 값이 0이면 0
SELECT SIGN(5) FROM DUAL; -- 1
SELECT SIGN(-5) FROM DUAL; -- -1
SELECT SIGN(0) FROM DUAL; -- 0

-- 7) 나머지
-- MOD(A,B) : A를 B로 나눈 나머지
SELECT MOD(7,3) FROM DUAL;

-- 8) 제곱
-- POWER(A,B) : A의 B제곱
SELECT POWER(10,2) FROM DUAL; -- 100
SELECT POWER(10,1) FROM DUAL; -- 10
SELECT POWER(10,0) FROM DUAL; -- 1
SELECT POWER(10,-1) FROM DUAL; -- 0.1
SELECT POWER(10,-2) FROM DUAL; -- 0.01

-- 4. 날짜 함수

-- 1) 현재 날짜 (타입이 DATE)
-- SYSDATE
SELECT SYSDATE FROM DUAL; 

-- 2) 현재 날짜 (타입이 TIMESTAMP)
-- SYSTIMESTAMP
SELECT SYSTIMESTAMP FROM DUAL;

-- 3) 년/월/일/시/분/초 추출
-- EXTRACT(단위 FROM 날짜)
SELECT EXTRACT(YEAR FROM SYSDATE) AS 년, -- 년
    EXTRACT(MONTH FROM SYSDATE) AS 월,  -- 월
    EXTRACT(DAY FROM SYSDATE) AS 일, -- 일
    EXTRACT(HOUR FROM SYSTIMESTAMP) AS 시, -- 시
    EXTRACT(MINUTE FROM SYSTIMESTAMP) AS 분, -- 분
    EXTRACT(SECOND FROM SYSTIMESTAMP) AS 초 -- 초
        FROM DUAL;

-- 4) 날짜 연산(이전,이후)
-- 1일 : 숫자 1
-- 12시간 : 숫자 0.5
SELECT SYSDATE + 1 AS 내일 FROM DUAL;
SELECT SYSDATE - 1 AS 어제 FROM DUAL;

-- 5) 개월 연산
-- ADD_MONTHS(날짜,N) : N개월 후
SELECT ADD_MONTHS(SYSDATE,3) AS 삼개월후 FROM DUAL;
SELECT ADD_MONTHS(SYSDATE,-3) AS 삼개월전 FROM DUAL;
-- MONTHS_BETWEEN(날짜1, 날짜2) : 두 날짜 사이 경과한 개월 수 (날짜1 - 날짜2)
-- MONTHS_BETWEEN(최근날짜, 이전날짜)
SELECT MONTHS_BETWEEN(SYSDATE,TO_DATE('2021-01-01')) AS result FROM DUAL;
SELECT TRUNC(result) AS result FROM (SELECT MONTHS_BETWEEN(SYSDATE,TO_DATE('2021-01-01')) AS result FROM DUAL);

-- 5. 형 변환 함수

-- 1) 날짜 변환 함수
-- TO_DATE(문자열, [형식])
-- 형식
-- YYYY, YY
-- MM, M
-- DD, D
-- HH, H
-- MI
-- SS
SELECT TO_DATE('2021-04-01') FROM DUAL;
SELECT TO_DATE('2021/04/01') FROM DUAL;
SELECT TO_DATE('2021/01/04','YYYY/DD/MM') FROM DUAL;
SELECT TO_DATE('20210401','YYYYMMDD') FROM DUAL;
SELECT TO_DATE('0401-21','MMDD-YY') FROM DUAL;

-- 2) 숫자 변환 함수
-- TO_NUMBER(문자열)
SELECT TO_NUMBER('100') FROM DUAL;

SELECT name, kor FROM score WHERE kor >= '50'; -- 내부적으로 WHERE kor >= TO_NUMBER('50') 처리됩니다.

-- 3) 문자열 변환 함수
-- TO_CHAR(값,[형식])
-- (1) 숫자 형식
SELECT TO_CHAR(123) FROM DUAL; -- 문자열 '123'
SELECT TO_CHAR(123,'999999') FROM DUAL; -- 문자열 '   123'
SELECT TO_CHAR(123,'000000') FROM DUAL; -- 문자열 '000123'
SELECT TO_CHAR(1234, '9,999') FROM DUAL; -- 문자열 '1234,567'
SELECT TO_CHAR(12345, '9,999') FROM DUAL; -- 문자열 '######'(오류)
SELECT TO_CHAR(12345, '99,999') FROM DUAL; -- 문자열 '12,345'
SELECT TO_CHAR(3.14, '9.999') FROM DUAL; -- 문자열 '3.140'
SELECT TO_CHAR(3.14, '9.99') FROM DUAL; -- 문자열 '3.14'
SELECT TO_CHAR(3.14, '9.9') FROM DUAL; -- 문자열 '3.1'
SELECT TO_CHAR(3.14, '9') FROM DUAL; -- 문자열 '3'
SELECT TO_CHAR(3.98, '9') FROM DUAL; -- 문자열 '4'(반올림)

-- (2) 날짜 형식
SELECT TO_CHAR(SYSDATE,'YYYY.MM.DD') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'YEAR MONTH DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE,'HH:MI:SS') FROM DUAL;

-- 6. 기타 함수

-- 1) NULL 처리 함수
-- (1) NVL(값, 값이 NULL일때 사용할 값)
SELECT kor, NVL(kor, 0), name FROM score;

-- 집계함수(SUM, AVG, MAX MIN, COUNT 등)들은 NULL값을 무시합니다
SELECT AVG(kor) 평균1, AVG(NVL(kor, 0)) 평균2 FROM score;

-- (2) NVL2(값, 값이 NULL이 아닐 때, 값이 NULL일 때)
SELECT kor, NVL2(kor, 'notNull', 'isNull') isnull, name FROM score;

-- 2) 분기 함수
-- DECODE(표현식, 조건1, 결과1, 조건2, 결과2, ..., 기본값)
-- 동등비교만 가능
SELECT DECODE('봄','봄','꽃놀이','여름','물놀이','가을','단풍놀이','겨울','눈싸움') AS 계절별놀이 FROM DUAL;
SELECT kor, DECODE(FLOOR(kor/10), NULL, '값없음', 7,'C',8,'B',9,'A',10,'+A','D') AS 성적, name FROM score;

-- 3) 분기 표현식
-- CASE 표현식 WHEN 비교식 THEN 결과값 ... ELSE 나머지경우 END
-- CASE WHEN 조건식 THEN 결과값 ... ELSE 나머지경우 END

-- CASE A값
-- WHEN A값 THEN 'A점'
-- WHEN B값 THEN 'B점'
-- ELSE '다른값'
-- END

-- CASE
-- WHEN A값 > B값 TEHN 'B값보다 크다'
-- WHEN A값 < B값 TEHN 'B값보다 작다'
-- ELSE A값과 B값은 같다
-- END

SELECT name,
    (NVL(kor,0) + eng + mat) / 3 AS 평균,
    (CASE
        WHEN (NVL(kor,0) + eng + mat) / 3 >= 90 THEN 'A학점'
        WHEN (NVL(kor,0) + eng + mat) / 3 >= 80 THEN 'B학점'
        WHEN (NVL(kor,0) + eng + mat) / 3 >= 70 THEN 'C학점'
        WHEN (NVL(kor,0) + eng + mat) / 3 >= 60 THEN 'D학점'
        ELSE 'F학점'
    END) AS 학점
FROM score;
