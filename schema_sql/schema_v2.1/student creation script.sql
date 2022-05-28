show databases;
use s6_project;

show tables;

create table students
    (
	 student_ID    INT NOT NULL AUTO_INCREMENT,
     fname         varchar(20) not null,
     lname         varchar(20) not null,
     department    varchar(30) not null,
     year          INT not null,
     email         varchar(64) not null unique,
     password	   varchar(4000) not null,
     
     PRIMARY KEY (student_ID) 
    );
    
    drop table students;
    delete from students where student_ID > 0;
    INSERT INTO students (fname, lname, department, year, email, password)
		VALUES 
		('Dwip', 'Mondal', 'CS', 1, 'mondaldeep2000@gmail.com','dwip@1234'),
        ('student2', 'student2_lname', 'CS' ,2, 'student2@gmail.com', 'student2@1234'),
		('student3', 'student3_lname', 'CS' ,3, 'student3@gmail.com','student3@1234'),
        ('avik', 'Mondal', 'MATH', 1, 'aivk@gmail.com','avik@1234'),
        ('vij', 'ayer', 'MATH' ,2, 'vij@gmail.com', 'vij@1234'),
		('arip', 'goel', 'MATH' ,3, 'arip@gmail.com','arip@1234')
        ;