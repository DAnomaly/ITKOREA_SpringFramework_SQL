
DROP TABLE lecture;
DROP TABLE enroll;
DROP TABLE course;
DROP TABLE student;
DROP TABLE professor;

CREATE TABLE student(
    student_no NUMBER,
    student_name VARCHAR2(18),
    student_address VARCHAR2(30),
    student_grade NUMBER(2),
    professor_no NUMBER,
    CONSTRAINT student_pk PRIMARY KEY (student_no)
);

CREATE TABLE professor(
    professor_no NUMBER,
    professor_name VARCHAR2(18),
    professor_class VARCHAR2(20),
    CONSTRAINT professor_pk PRIMARY KEY (professor_no)
);

CREATE TABLE lecture(
    lecture_no NUMBER,
    professor_no NUMBER,
    enroll_no NUMBER,
    lecture_name VARCHAR2(25),
    lectrue_location VARCHAR2(25),
    CONSTRAINT lecture_pk PRIMARY KEY (lecture_no)
);

CREATE TABLE enroll(
    enroll_no NUMBER,
    student_no NUMBER,
    course_no NUMBER,
    enroll_date DATE,
    CONSTRAINT enroll_pk PRIMARY KEY (enroll_no)
);

CREATE TABLE course(
    course_no NUMBER,
    course_name VARCHAR2(25),
    course_pass NUMBER,
    CONSTRAINT course_pk PRIMARY KEY (course_no)
);

ALTER TABLE student ADD CONSTRAINT student_professor_fk FOREIGN KEY (professor_no) REFERENCES professor(professor_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_professor_fk FOREIGN KEY (professor_no) REFERENCES professor(professor_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_enroll_fk FOREIGN KEY (enroll_no) REFERENCES enroll(enroll_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_student_fk FOREIGN KEY (student_no) REFERENCES student(student_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_course_fk FOREIGN KEY (course_no) REFERENCES course(course_no);

INSERT INTO professor VALUES (1,'김선생','기계');
INSERT INTO professor VALUES (2,'이선생','보안');
INSERT INTO professor VALUES (3,'고선생','정보');

INSERT INTO course VALUES (1,'전기',60);
INSERT INTO course VALUES (2,'통신',60);
INSERT INTO course VALUES (3,'안전',80);

INSERT INTO student VALUES (21001,'김학생','서울',1,1);
INSERT INTO student VALUES (20001,'강학생','강원',2,2);
INSERT INTO student VALUES (20002,'구학생','경기',2,3);

INSERT INTO enroll VALUES (1,21001,1,SYSDATE);
INSERT INTO enroll VALUES (2,20001,2,SYSDATE);
INSERT INTO enroll VALUES (3,20002,3,SYSDATE);

INSERT INTO lecture VALUES (11,1,1,'전기*기초','101');
INSERT INTO lecture VALUES (21,2,2,'통신*기초','201');
INSERT INTO lecture VALUES (31,3,3,'안전',208);

COMMIT;