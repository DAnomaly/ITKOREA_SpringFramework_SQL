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
* 210331.sql
	* 테이블 생성시 PRIMARY KEY를 포함하는 CREATE문
	* 테이블 생성시 FOREIGN KEY를 포함하는 CREATE문
### 2021.04.01
* 210401_01.sql
	* FOREIGN KEY 설명 : 1:1관계, 1:M관계, N:M관계
	* 테이블 생성 순서 : 부모(PK) -> 자식(FK)
	* FOREIGN KEY 예제 (PK,FK)
* 210401_02.sql
	* 제약조건(CONSTRAINT)에 대해서 (NOT NULL, UNIQUE, CHECK)
	* CONSTRAINT [제약조건이름] [제약조건]
	* ALTER TABLE [테이블명] ADD [제약조건]