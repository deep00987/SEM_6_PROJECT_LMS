create database dev_s6;
use dev_s6;

drop database dev_s6;

CREATE TABLE `student` (
	`student_id` INT NOT NULL AUTO_INCREMENT,
	`fname` varchar(255) NOT NULL,
	`lname` varchar(255) NOT NULL,
	`email` varchar(255) NOT NULL UNIQUE,
	`password` varchar(4000) NOT NULL,
	`dept_id` INT NOT NULL,
	`term_id` INT NOT NULL,
	PRIMARY KEY (`student_id`)
    
);

CREATE TABLE `department` (
	`dept_id` INT NOT NULL AUTO_INCREMENT,
	`dept_name` varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (`dept_id`)
);

CREATE TABLE `term` (
	`term_id` INT NOT NULL AUTO_INCREMENT,
	`term_name` varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (`term_id`)
);

CREATE TABLE `course` (
	`course_id` INT NOT NULL AUTO_INCREMENT,
	`course_name` varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (`course_id`)
);

CREATE TABLE `term_course` (
	`term_id` INT NOT NULL,
	`course_id` INT NOT NULL
);

CREATE TABLE `student_course` (
	`student_id` INT NOT NULL,
	`course_id` INT NOT NULL
);

CREATE TABLE `teacher` (
	`teacher_id` INT NOT NULL AUTO_INCREMENT,
	`fname` varchar(255) NOT NULL,
	`lname` varchar(255) NOT NULL,
	`email` varchar(255) NOT NULL UNIQUE,
	`password` varchar(4000) NOT NULL,
	`dept_id` INT NOT NULL,
	PRIMARY KEY (`teacher_id`)
);

CREATE TABLE `teacher_course` (
	`teacher_id` INT NOT NULL,
	`course_id` INT NOT NULL
);

CREATE TABLE `dept_course` (
	`dept_id` INT NOT NULL,
	`course_id` INT NOT NULL
);


ALTER TABLE `student` ADD CONSTRAINT `student_fk0` FOREIGN KEY (`dept_id`) REFERENCES `department`(`dept_id`);

ALTER TABLE `student` ADD CONSTRAINT `student_fk1` FOREIGN KEY (`term_id`) REFERENCES `term`(`term_id`);

ALTER TABLE `term_course` ADD CONSTRAINT `term_course_fk0` FOREIGN KEY (`term_id`) REFERENCES `term`(`term_id`);

ALTER TABLE `term_course` ADD CONSTRAINT `term_course_fk1` FOREIGN KEY (`course_id`) REFERENCES `course`(`course_id`);

ALTER TABLE `student_course` ADD CONSTRAINT `student_course_fk0` FOREIGN KEY (`student_id`) REFERENCES `student`(`student_id`) ON DELETE CASCADE;

ALTER TABLE `student_course` ADD CONSTRAINT `student_course_fk1` FOREIGN KEY (`course_id`) REFERENCES `course`(`course_id`) ON DELETE CASCADE;

ALTER TABLE `teacher` ADD CONSTRAINT `teacher_fk0` FOREIGN KEY (`dept_id`) REFERENCES `department`(`dept_id`);

ALTER TABLE `teacher_course` ADD CONSTRAINT `teacher_course_fk0` FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`teacher_id`) ON DELETE CASCADE;

ALTER TABLE `teacher_course` ADD CONSTRAINT `teacher_course_fk1` FOREIGN KEY (`course_id`) REFERENCES `course`(`course_id`) ON DELETE CASCADE;

ALTER TABLE `dept_course` ADD CONSTRAINT `dept_course_fk0` FOREIGN KEY (`dept_id`) REFERENCES `department`(`dept_id`);

ALTER TABLE `dept_course` ADD CONSTRAINT `dept_course_fk1` FOREIGN KEY (`course_id`) REFERENCES `course`(`course_id`);

ALTER TABLE course
ADD course_code varchar(255);

INSERT INTO department (dept_name) 
VALUES
	("CS"),
    ("MATH");


INSERT INTO term (term_name) 
VALUES
	("TERM_1"),
    ("TERM_2"),
    ("TERM_3");
    

INSERT INTO course (course_code , course_name)
VALUES 
("CSCORE01" , "Programming in C/C++"),
("CSCORE02" ,"Computer System Architecture"),
("CSCORE03", "Discreate Structure"),
("CSCORE04" , "Object Oriented Programming"),
("CSCORE05" , "Data Structures and Algorithms"),
("CSCORE06" , "Networking And DBMS"),
("MTCORE01" , "Differential Equations"),
("MTCORE02" , "Linear Algebra"),
("MTCORE03" , "Calculus 2"),
("MTCORE04" , "Vector Calculus"),
("MTCORE05" , "Discreate Math and Graph Theory" ),
("MTCORE06" , "Calculus 3");

INSERT INTO dept_course (dept_id,course_id) 
VALUES
	(1,1),
    (1,2),
    (1,3),
    (1,4),
    (1,5),
    (1,6),
    (2,7),
    (2,8),
    (2,9),
    (2,10),
    (2,11),
    (2,12);


##retreve all courses info given department
Select department.dept_id, department.dept_name, course.course_id,course.course_name, course.course_code  
from department, dept_course, course, term  where 
department.dept_id = dept_course.dept_id AND 
dept_course.course_id = course.course_id AND 
department.dept_id = 1;

select fname,term_id, dept_id
from student; 

ALTER TABLE term_course
ADD dept_id INT NOT NULL;
ALTER TABLE `term_course` ADD CONSTRAINT `term_course_fk2` FOREIGN KEY (`dept_id`) REFERENCES `department`(`dept_id`);

INSERT INTO term_course (term_id, dept_id, course_id) 
VALUES
(1,1,1),
(1,1,2),
(1,1,7),
(2,1,3),
(2,1,4),
(2,1,8),
(3,1,5),
(3,1,6),
(1,2,7),
(1,2,8),
(1,2,1),
(2,2,9),
(2,2,10),
(2,2,4),
(3,2,11),
(3,2,12),
(3,2,5);

select * from student where 
student_id = 2;

select student.student_id ,course.course_id ,course.course_code, course.course_name   
from student, term_course, course 
where student.dept_id = term_course.dept_id 
AND student.term_id = term_course.term_id 
AND term_course.course_id = course.course_id 
AND student.student_id = 1;

select fname, lname, email, student.dept_id, dept_name, student.term_id, term_name
from student, department, term 
where student.dept_id = department.dept_id
AND student.term_id = term.term_id
AND student_id = 2;

INSERT INTO student_course (student_id, course_id)
VALUES (1, 1);

select course.course_id, course.course_name
from student_course, course 
where student_course.course_id = course.course_id 
AND student_id = 1;

UPDATE student 
SET term_id = 2
where student_id = 9;

DELETE FROM student_course 
WHERE student_id = 9 AND 
course_id = 9;

select * from course where course_id = 9;

select course.course_id, course.course_name, course_code 
from teacher, course, dept_course
where teacher.dept_id = dept_course.dept_id 
AND dept_course.course_id = course.course_id
AND teacher.teacher_id = 1;




CREATE TABLE `class` (
	`class_id` INT NOT NULL AUTO_INCREMENT,
	`teacher_id` INT NOT NULL,
	`course_id` INT NOT NULL,
	`class_title` varchar(255) NOT NULL,
	`class_link` varchar(255) NOT NULL,
	`class_contents` varchar(255),
	PRIMARY KEY (`class_id`)
);

ALTER TABLE `class` ADD CONSTRAINT `class_fk0` FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`teacher_id`) ON DELETE CASCADE;

ALTER TABLE `class` ADD CONSTRAINT `class_fk1` FOREIGN KEY (`course_id`) REFERENCES `course`(`course_id`) ON DELETE CASCADE;



select student.email,course.course_name, course.course_code, course.course_id, department.dept_name, term.term_name
from student, department, term, term_course,course
WHERE student.dept_id = department.dept_id 
AND student.term_id = term.term_id
AND department.dept_id = term_course.dept_id 
AND term.term_id = term_course.term_id
AND term_course.course_id = course.course_id
AND student.student_id = 4;

select fname, lname, email,teacher_id, department.dept_name, teacher.dept_id
from teacher, department
where teacher.dept_id = department.dept_id 
AND teacher.teacher_id = 1;

## testing starts
use dev_s6;

CREATE TABLE `class_room` (
	`class_room_id` INT NOT NULL AUTO_INCREMENT,
	`teacher_id` INT NOT NULL,
	`course_id` INT NOT NULL,
	`class_name` varchar(255) NOT NULL,
	`varchar` varchar(255) NOT NULL UNIQUE,
	PRIMARY KEY (`class_room_id`)
);

drop table student_class;

CREATE TABLE `student_class` (
	`class_room_id` INT NOT NULL,
	`student_id` INT NOT NULL
);

CREATE TABLE `class_post` (
	`class_post_id` INT NOT NULL AUTO_INCREMENT,
	`class_room_id` INT NOT NULL,
	`teacher_id` INT,
	`student_id` INT,
	`content` varchar(255) NOT NULL,
    `attachment` varchar(255) NULL,
	PRIMARY KEY (`class_post_id`)
);

DROP TABLE class_post;

ALTER TABLE `class_room` ADD CONSTRAINT `class_room_fk0` FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`teacher_id`) ON DELETE CASCADE;

ALTER TABLE `class_room` ADD CONSTRAINT `class_room_fk1` FOREIGN KEY (`course_id`) REFERENCES `course`(`course_id`) ON DELETE CASCADE;

ALTER TABLE `student_class` ADD CONSTRAINT `student_class_fk0` FOREIGN KEY (`class_room_id`) REFERENCES `class_room`(`class_room_id`) ON DELETE CASCADE;

ALTER TABLE `student_class` ADD CONSTRAINT `student_class_fk1` FOREIGN KEY (`student_id`) REFERENCES `student`(`student_id`) ON DELETE CASCADE;

ALTER TABLE `class_post` ADD CONSTRAINT `class_post_fk0` FOREIGN KEY (`class_id`) REFERENCES `class_room`(`class_room_id`);

ALTER TABLE `class_post` ADD CONSTRAINT `class_post_fk1` FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`teacher_id`);

ALTER TABLE `class_post` ADD CONSTRAINT `class_post_fk2` FOREIGN KEY (`student_id`) REFERENCES `student`(`student_id`);

ALTER TABLE `class_post` ADD CONSTRAINT `class_post_fk3` FOREIGN KEY (`class_room_id`) REFERENCES `class_room`(`class_room_id`) ON DELETE CASCADE;

ALTER TABLE class_room 
ADD created_at timestamp NOT NULL  DEFAULT CURRENT_TIMESTAMP;

alter TABLE class_post ADD created_at timestamp NOT NULL  DEFAULT CURRENT_TIMESTAMP;

alter table class_room drop `class_code`;
alter table class_room add course_code varchar(255) not null;

INSERT INTO class_room (teacher_id, course_code, course_id, class_name)
VALUES
(2, 'MTCORE01', 7, 'Differential equartion SEM 1');

SELECT class_room_id from class_room where teacher_id = 2 AND course_id = 7;


##given student_id find classroom asociatied with said student
select class_room.class_room_id, class_room.teacher_id,teacher.fname, teacher.lname, class_room.course_code, course.course_id, course.course_name,
class_room.class_name
from student_course, class_room, course, teacher
where student_course.course_id = class_room.course_id 
AND class_room.course_id = course.course_id
AND class_room.teacher_id = teacher.teacher_id
AND student_course.student_id = 1;

SELECT class_room.class_room_id, course.course_name,course.course_code
FROM class_room, course
where class_room.course_id = course.course_id
AND class_room.class_room_id = 15;

INSERT INTO class_post (class_room_id, teacher_id, content, attachment)
VALUES
(15, 1, "NEW ANNOUNCEMNET TEST" , "ROUTINE_CMS_UG_2022.pdf");


SELECT * from class_post where class_room_id = 15;

INSERT INTO student_class (student_id, class_room_id)
VALUES (1,22);


SELECT class_room.class_room_id, course.course_code, class_room.class_name, teacher.fname, teacher.lname
FROM student_class, class_room, course, teacher  
WHERE student_class.class_room_id = class_room.class_room_id
AND class_room.course_id = course.course_id 
AND class_room.teacher_id = teacher.teacher_id
AND student_class.student_id = 1;

SELECT class_room.class_room_id,class_room.class_name,teacher.teacher_id, teacher.fname, teacher.lname, department.dept_name, 
course.course_name, course.course_code 
FROM student_class, class_room, teacher, course, department 
WHERE student_class.class_room_id = class_room.class_room_id 
AND class_room.teacher_id = teacher.teacher_id
AND teacher.dept_id = department.dept_id
AND class_room.course_id = course.course_id
AND student_class.class_room_id = 23;

select student.student_id,student.fname, student.lname, student.email, 
department.dept_name
from student, department
WHERE student.dept_id = department.dept_id
AND student.student_id = 1;

select class_post.class_post_id, class_post.class_room_id, teacher.teacher_id, class_post.student_id, 
teacher.fname, teacher.lname, class_post.content, class_post.attachment, 
class_post.created_at
from class_post, teacher 
Where class_post.teacher_id = teacher.teacher_id 
AND class_post.class_room_id = 24;

CREATE TABLE `class_comments` (
	`comment_id` INT NOT NULL AUTO_INCREMENT,
	`class_room_id` INT NOT NULL,
	`class_post_id` INT NOT NULL,
	`student_id` INT,
	`teacher_id` INT,
	`content` varchar(255) NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
	PRIMARY KEY (`comment_id`)
);

ALTER TABLE `class_comments` ADD CONSTRAINT `class_comments_fk0` FOREIGN KEY (`class_room_id`) REFERENCES `class_room`(`class_room_id`) ON DELETE CASCADE;

ALTER TABLE `class_comments` ADD CONSTRAINT `class_comments_fk1` FOREIGN KEY (`class_post_id`) REFERENCES `class_post`(`class_post_id`) ON DELETE CASCADE;

ALTER TABLE `class_comments` ADD CONSTRAINT `class_comments_fk2` FOREIGN KEY (`student_id`) REFERENCES `student`(`student_id`) ON DELETE CASCADE;

ALTER TABLE `class_comments` ADD CONSTRAINT `class_comments_fk3` FOREIGN KEY (`teacher_id`) REFERENCES `teacher`(`teacher_id`) ON DELETE CASCADE;


select class_comments.comment_id, class_comments.student_id, 
class_comments.class_post_id, class_comments.class_room_id,
class_comments.content, student.fname, student.lname, student.dept_id, class_comments.created_at
from class_comments, student
where class_comments.student_id = student.student_id
AND class_comments.class_room_id = 30
AND class_comments.class_post_id = 35;

INSERT INTO class_comments (class_room_id, class_post_id, student_id, content)
VALUES (30, 35, 1, "test comment");

select class_comments.comment_id, class_comments.teacher_id,
class_comments.class_post_id, class_comments.class_room_id,          
class_comments.content, teacher.fname, teacher.lname, teacher.dept_id, class_comments.created_at
from class_comments, teacher
where class_comments.teacher_id = teacher.teacher_id
AND class_comments.class_room_id = 30
AND class_comments.class_post_id = 36;





