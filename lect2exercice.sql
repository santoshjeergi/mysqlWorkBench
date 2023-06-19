
drop database  if exists studentdemo;
create database if not exists studentdemo;
use  studentdemo;


drop table if exists student;

create table student (
id INT PRIMARY KEY,
fname VARCHAR(20),
lname VARCHAR(20),
mid INT
 );

 drop table if exists batch;
 CREATE TABLE batch (
 id INT PRIMARY KEY,
 sDate VARCHAR(10),
 eDate VARCHAR(10)
 );
 
 create table instructor(
  id INT primary KEY,
 dob varchar(10),
 experience INT
 );
 
 drop table if exists lecture;
 create table lecture (
 id INT primary key,
 topic varchar(10),
 iid INT
 );
 
 ALTER TABLE lecture add constraint lectFK foreign key(iid)
 references instructor(id);
 
  drop table if exists mentor;
 create table mentor (
  id INT primary key,
   dob varchar(10),
 experience INT
 );
 
 ALTER TABLE student add constraint fk11 
 foreign key(mid) references mentor(id);
 
 create table batchLecture( /*BL*/
 bid INT,
 lid INT
 );
 
 ALTER TABLE batchLecture add constraint fkBathc_Lecture1 
 foreign key(bid) references batch(id);
  ALTER TABLE batchLecture add constraint fkBathc_Lecture2 
 foreign key(bid) references batch(id);
 
 create table studentPrevBatch( /*BL*/
 sid INT,
 bid INT
 );
  
 ALTER TABLE studentPrevBatch add constraint fk1 
 foreign key(sid) references student(id);
 ALTER TABLE studentPrevBatch add constraint fk2 
 foreign key(bid) references batch(id);
 
 
 
 