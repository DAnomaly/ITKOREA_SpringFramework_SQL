-- 계정 삭제
-- DROP USER SPRING CASCADE;

-- 계정 생성
-- 아이디   : SPRING
-- 비밀번호 : 1111
CREATE USER SPRING IDENTIFIED BY 1111;

-- 계정 권한 부여
-- CONNECT  : DB에 접속할 수 있는 세션을 생성, 테이블을 생성하거나 조회 할 수 있는 권한
-- RESOURCE : 대표적으로 PL/SQL을 사용할 수 있는 권한
-- DBA      : 모든 시스템 권한
GRANT DBA TO SPRING;