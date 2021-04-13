# ITKOREA_SpringFramework_SQL

## CLASS
* 과정명 : (디지털컨버젼스)스프링 프레임워크 기반 풀스택 개발자 양성과정
* 장소 : 코리아아이티신촌학원
* 기간 : 2021/03/03 ~ 2021/08/09 (890시간)

### 개발환경
* OracleXE 11
* Oracle SQL Developer

## FILE
### 2021.03.31
* [210331.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210331.sql)
	* 테이블 생성시 PRIMARY KEY를 포함하는 CREATE문
	* 테이블 생성시 FOREIGN KEY를 포함하는 CREATE문
### 2021.04.01
* [210401_01.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210401_01.sql)
	* FOREIGN KEY 설명 : 1:1관계, 1:M관계, N:M관계
	* 테이블 생성 순서 : 부모(PK) -> 자식(FK)
	* FOREIGN KEY 예제 (PK,FK)
* [210401_02.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210401_02.sql)
	* 제약조건(CONSTRAINT)에 대해서 (NOT NULL, UNIQUE, CHECK)
	* CONSTRAINT [제약조건이름] [제약조건]
	* ALTER TABLE [테이블명] ADD [제약조건]
### 2021.04.02
* [210402_01.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210402_01.sql)
	* ALTER TABLE를 통해 기본키(PRIMARY KEY), 외래키(FOREIGN KEY)를 추가
	* ALTER TABLE를 통해 기본키(PRIMARY KEY), 외래키(FOREIGN KEY)를 삭제
	* 제약조건의 확인
	```
	DESC USER_CONSTRAINTS; -- DD(Data Dictionary)의 정보 확인
	SELECT constraint_name, table_name from USER_CONSTRAINTS; -- 현제 유저의 모든 테이블의 제약조건을 확인
	``` 
	* 제약조건의 활성화/비활성화
	```
	ALTER TABLE PLAYER DISABLE CONSTRAINT PLAYER_NATION_FK; -- 'PLAYER_NATION_FK'제약조건 비활성화
	ALTER TABLE PLAYER ENABLE CONSTRAINT PLAYER_NATION_FK; -- 'PLAYER_NATION_FK'제약조건 활성화
	```
* [210402_02.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210402_02.sql)
	* 칼럼의 추가, 수정, 삭제, 이름변경
	```
	ALTER TABLE 테이블 ADD 칼럼명 타입; -- 칼럼 추가
	ALTER TABLE 테이블 MODIFY 칼럼명 타입; -- 칼럼 수정
	ALTER TABLE 테이블 DROP COLUMN 칼럼명; -- 칼럼 삭제
	ALTER TABLE 테이블 RENAME COLUMN 기존칼럼 TO 신규칼럼명; -- 칼럼 이름변경
	```
* [210402_03.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210402_03.sql)
	* 행(Row) 삽입 (INSERT)
	* 행(Row) 수정 (UPDATE)
	* 행(Row) 삭제 (DELETE)
* [210402_04.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210402_04.sql)
	* 테이블 생성 -> PRIMARY KEY -> FROEIGN KEY -> INSERT (예제)
* [210402_05.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210402_05.sql)   
	```오라클 내장 함수 1```
	* 집계 함수 : SUM, AVG, MAX, MIN, COUNT
	* 문자 함수 : INITCAP, UPPER, LOWER, LENGTH, SUBSTR, INSTR, LPAD, RPAD, CONCAT(||), RTRIM, LTRIM, TRIM
### 2021.04.05
* [210405_01.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210405_01.sql)   
	```오라클 내장 함수 2```
	* 숫자 함수 : ROUND, CEIL, FLOOR, TRUNC, ABS, SIGN, POWER
	* 날짜 함수 : SYSDATE, TIMESTAMP, EXRTACT, 날짜 연산, 개월 연산(ADD_MONTHS, MONTHS_BEWEEN)
	* 형 변환 함수 : TO_DATE, TO_NUMBER, TO_CHAR
	* 기타 함수 : NULL처리(NVL, NVL2), 분기 함수(DECODE), 분기 표현식(CASE-WHEN-THEN-END)
* [210405_02.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210405_02.sql) 
	* SELECT 연습 예제
* [210405_02-BLANK.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210405_02-BLANK.sql)
	* SELECT 연습 예제의 빈칸 버전
	* SELECT 연습하실 때 이 파일을 사용하시면 됩니다
### 2021.04.06
* [210406_01.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210406_01.sql)
	* SELECT 연습 예제 (GROUP BY, HAVING)
* [210406_01-BLANK.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210406_01-BLANK.sql)
	* 연습 예제의 빈칸 버전
* [210406_02.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210406_02.sql)
	* INNER JOIN, OUTTER JOIN에 대한 학습
* [210406_03.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210406_03.sql)
	* JOIN 연습 예제
* [210406_03-BLANK.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210406_03-BLANK.sql)
	* JOIN 연습 예제 빈칸 버전
### 2021.04.07
* [210407_01.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210407_01.sql)
	* 서브쿼리에 대한 학습
* [210407_02.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210407_02.sql)
	* 서브쿼리 연습 예제
* [210407_02-BLANK.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210407_02-BLANK.sql)
	* 서브쿼리 연습 예제 빈칸 버전
### 2021.04.08
* [210408_01.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210408_01.sql)
	* 인덱스에 대해서
* [210408_02.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210408_02.sql)
	* 뷰 생성
* [210408_03.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210408_03.sql)
	* 시퀀스
	* ROWNUM, ROWID
* [210408_04.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210408_04.sql)
	* DDL 연습
* [210408_04-BLANK.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210408_04-BLANK.sql)
	* 빈칸 버전
* [210408_05.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210408_05.sql)
	* DML 연습
* [210408_05-BLANK.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210408_05-BLANK.sql)
	* 빈칸 버전
### 2021.04.13
* [210413_01.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210413_01.sql)
	* PLSQL
	* (DECLARE) - BEGIN - (EXCEPTION) - END
	* IF ```(IF - (ELSIF) - (ELSE) - END IF)```
	* CASE ```(CASE - WHEN - (ELSE) - END CASE)```
	* WHILE ```(WHILE - LOOP - END LOOP)```
	* FOR ```(FOR - IN - LOOP - END LOOP)```
	* EXIT ```JAVA : break;```
	* CONTINUE ```JAVA : continue;```
	* TYPE ```테이블, 레코드, 테이블형 레코드 타입```
	* EXCEPTION ```예외 처리```
* [210413_02.sql](https://github.com/DAnomaly/ITKOREA_SpringFramework_SQL/blob/main/210413_02.sql)
	* 프로시저 (PROCEDURE)
	* 사용자 함수 (FUNCTION)
	* 트리거 (TRIGGER)