DROP DATABASE IF EXISTS indexing;
CREATE DATABASE  IF NOT EXISTS idexing;
USE idexing;

DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS batch;
DROP TABLE IF EXISTS Instructor;
DROP TABLE IF EXISTS TA;

CREATE TABLE IF NOT EXISTS students (
stId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
stname VARCHAR(10),
batchId INT,
phone VARCHAR(10),
psp INT );   /*Problem solving percentage*/

CREATE TABLE IF NOT EXISTS batch (
bId INT,
bname varchar(20),
Instructorname varchar(20),
InstructorId INT,
phone varchar(10) default null );

CREATE TABLE IF NOT EXISTS Instructor (
iId int primary key,
iname varchar(20) default null,
iPhone varchar(10) );

CREATE TABLE IF NOT EXISTS TA ( /*Teaching assistant, its sort of peer student who has stepped to help in additional role*/
taId int primary key,
taName varchar(20),
stId int );

#alter table students add constraint primary key(stId);
alter table batch add constraint primary key(bId);
alter table students add constraint foreign key(batchId) references batch(bId);
alter table batch add constraint foreign key(InstructorId) references Instructor(iId);
ALTER TABLE TA ADD CONSTRAINT foreign key(stId) references students(stId);
ALTER TABLE Instructor ADD UNIQUE(iPhone);  /*UNIQUE constraint ensures that all values in a column are different.*/

INSERT INTO Instructor(iId, iname, iPhone) values 
(500, "I500", "56637"),
(501, "I501", "566371"),
(502, "I502", "566372");

insert into batch (bId, bName, Instructorname, InstructorId) values
( 1, "B1", "ankit", 500),
( 2, "B2", "ragav", 500),
( 3, "B3", "renjit", 502);

insert into students (stId, stname, batchId, phone, psp) values
(30, "abStudent", 1, "8972923", 80),
(45, "abStudent", 2, "812923", 90),
(76, "abStudent", 3, "82923", 95),
(12, "abStudent", 3, "897293", 60);

insert into TA (taId, taname, stId) values
(300, "abStudent", 45),
(405, "abStudent", 76),
(706, "abStudent", null),
(102, "abStudent", null);


#Subquery inside the from clause, 
# display Averge psp for every instructor -approch1

CREATE VIEW DISPLAY_AVG_PERINSTRUCTOR AS /* create view , to hide the underneath commands*/
select  I.iId , AVG(S.psp) as avgPsp from Instructor I
JOIN batch B ON B.InstructorId = I.iId
JOIN students S ON S.batchId = B.bId
GROUP BY I.iId;

SELECT * FROM DISPLAY_AVG_PERINSTRUCTOR;

 # display Averge psp for every instructor -approch2 in from clause
 select iid as InstId, AVG(PSP) as avgPsp from
 (  select I.iId as iid , S.psp as PSP
    from  Instructor I
    JOIN batch B on B.InstructorId = I.iId
    JOIN students S on S.batchId = B.bId  
 ) as temp 
 GROUP BY iid;
 
#indexation
explain select * from students where stId=12;
explain select * from students where  phone="8972923";
drop index idex_phone on students;
create index idex_phone on students(phone);
explain select * from students where  phone="8972923";


#subQueries

#Select students whose psp > 85 in bid 3
select  * from  students where psp > 85 and batchId =3; 
#Select students whose psp > student with sId=30 psp 
select * from 
students s1  
join students s2
on s1.psp > s2.psp AND s2.stId = 30; 

SELECT * 
FROM students s1
WHERE psp > 
(
 SELECT psp 
 FROM students s2
 WHERE s2.stId = 30
);

#Select TA who are also TA  - approch1
select stId from TA where stId IN 
 ( select stId from students);
 
#Select TA who are also TA  - approch2 using join
 select s.stId  from students s join TA t ON s.stId = t.stId;
 
 
 
 #select all students who have psp > all students of batch1 -approch1
 # - find all student who is bettre than the best student in batch 1
select * from students where psp > 
( select MAX(psp) from students where batchId=1);

#select all students who have psp > all students of batch1 -approch2
select * from students where psp > ALL
(select psp from students where batchId=1);


 #select all students who have psp > any students of batch2 -approch1
 # - find all student who is bettre than the min psp  student in batch 2
 select * from students where psp > 
 ANY  (select psp from students where batchId =2);
  #select all students who have psp > any students of batch2 -approch2
 select * from students where psp > (select MIN(psp) from students where batchId =2);


#Corelated subQueries
#find all the students whose psp> the average psp in there own batch
select * from students oustudent where psp >
( select AVG(psp) from students instudent where instudent.batchId = oustudent.batchId);

#correlate subQuery in the select clause
select *, (select AVG(psp) from students sin where sout.batchId = sin.batchId) as Avergae from students sout;