-- 인덱스
-- 1. 빠른 검색을 위해서 특정 칼럼에 설정하는 색인
-- 2. 검색 속도를 높이지만, 삽입/갱신 삭제 시 인덱스의 갱신 때문에 성능이 떨어진다.
-- 3. 기본키(pk), 유니크(unique) 칼럼은 자동으로 인덱스가 설정된다
-- 4. WHERE절에서 자주 사용되는 칼럼은 인덱스로 설정하는 것이 좋다

-- 고유인덱스
-- department 테이블의 dept_name 칼럼에 고유인덱스 IDX_NAME을 설정한다.
CREATE UNIQUE INDEX IDX_NAME ON department(dept_name);

-- 비고유인덱스 생성 (인덱스 부착 칼럼에 중복을 허용
-- employee 테이블의 name 칼럼에 비고유인덱스 idx_name을 생성한다
CREATE INDEX IDX_NAME ON department(dept_name);

-- 인덱스 조회
-- 사용자가 작성한 인덱스 목록 : user_indexes
DESC user_indexes;

SELECT index_name, uniqueness 
  FROM user_indexes
 WHERE table_name = 'DEPARTMENT';

SELECT index_name, uniqueness 
  FROM user_indexes
 WHERE table_name = 'EMPLOYEE';
 
-- 인덱스 삭제
DROP INDEX IDX_NAME;