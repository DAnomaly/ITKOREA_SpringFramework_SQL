
DROP TABLE schedule;
DROP TABLE player;
DROP TABLE event;
DROP TABLE nation;

-- 1. 국가(nation)테이블
CREATE TABLE nation(
    nation_code NUMBER(3),
    nation_name VARCHAR2(30),
    nation_prev_rank NUMBER,
    nation_curr_rank NUMBER,
    nation_parti_person NUMBER,
    nation_parti_event NUMBER
);

-- 2. 종목(event) 테이블
CREATE TABLE event(
    event_code NUMBER(5),
    event_name VARCHAR2(30),
    event_info VARCHAR2(1000),
    evnet_first_year NUMBER(4)
);

-- 3. 선수(player) 테이블
CREATE TABLE player(
    player_code NUMBER(5),
    nation_code NUMBER(3),
    event_code NUMBER(5),
    player_name VARCHAR2(30),
    player_age NUMBER(3),
    player_rank NUMBER
);

-- 4. 일정(schedule) 테이블
CREATE TABLE schedule(
    nation_code NUMBER(3),
    event_code NUMBER(5),
    schedule_info VARCHAR2(1000),
    schedule_begin DATE,
    schedule_end DATE
);

-- 각 테이블에 기본키(PRIMARY KEY)를 추가하기
ALTER TABLE nation ADD CONSTRAINT nation_pk PRIMARY KEY (nation_code);
ALTER TABLE event ADD CONSTRAINT event_pk PRIMARY KEY (event_code);
ALTER TABLE player ADD CONSTRAINT player_pk PRIMARY KEY (player_code);
ALTER TABLE schedule ADD CONSTRAINT schedule_pk PRIMARY KEY (nation_code, event_code);

-- 각 테이블에 외래키(FOREIGN KEY)를 추가하기
ALTER TABLE player ADD CONSTRAINT player_nation_fk FOREIGN KEY (nation_code) REFERENCES nation(nation_code);
ALTER TABLE player ADD CONSTRAINT player_event_fk FOREIGN KEY (event_code) REFERENCES event(event_code);
ALTER TABLE schedule ADD CONSTRAINT schedule_nation_fk FOREIGN KEY (nation_code) REFERENCES nation(nation_code);
ALTER TABLE schedule ADD CONSTRAINT schedule_event_fk FOREIGN KEY (event_code) REFERENCES event(event_code);

-- 제약조건의 삭제
-- ALTER TABLE 테이블 DROP CONSTRAINT 제약조건;
-- 기본키 제약조건 삭제를 위해서는 이를 참조하는 외래키를 먼저 삭제할 필요가 있다
ALTER TABLE player DROP CONSTRAINT player_nation_fk;
ALTER TABLE schedule DROP CONSTRAINT schedule_nation_fk;
ALTER TABLE nation DROP CONSTRAINT nation_pk;

ALTER TABLE schedule DROP CONSTRAINT schedule_event_fk;
ALTER TABLE player DROP CONSTRAINT player_event_fk;
ALTER TABLE event DROP CONSTRAINT event_pk;

ALTER TABLE player DROP CONSTRAINT player_pk;
ALTER TABLE schedule DROP CONSTRAINT schedule_pk;

-- 제약조건의 확인
-- 제약조건을 저장하고 있는 DD(Data Dictionary) : USER_CONSTRAINTS
DESC USER_CONSTRAINTS;

SELECT constraint_name, table_name from USER_CONSTRAINTS;
SELECT constraint_name, table_name from USER_CONSTRAINTS WHERE TABLE_NAME = 'PLAYER';

-- 제약조건의 비활성화