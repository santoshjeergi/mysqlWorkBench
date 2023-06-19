#show databases;

drop database if exists joindemo1;
create database if not exists joindemo1;

use joindemo1;

drop table if exists students;
create  table students ( id int auto_increment, bid int, stname varchar(20), reviewBy int , psp int not null, mentorname varchar(20) , primary key(id) );

drop table if exists batches;
create table batches (bid int, batchname varchar(20), instructorid int default 0, primary key(bid));

alter table students add constraint foreign key(bid) references batches(bid);

drop table if exists instructors;

create table instructors (id int, iname varchar(20), primary key(id));

alter table batches add constraint foreign key(instructorid) references instructors(id);

insert into instructors(id, iname) values
(54, "54name"),
(43, "43name");

insert into batches (bid, batchname, instructorid) values 
( 1, "jan", 54), 
(2, "feb", 43),
(3, 'mar', 54), 
(4, 'june', null);

insert into students (id, stname, bid, reviewBy, psp, mentorname) values
(21, "santosh", 2, 32, 70, "aman"),
(32, "kumar", 1, 21, 60, "mustaq"),
(211, "1santosh", 2, 32, 70, "aman"),
(322, "2kumar", 1, 21, 50, "sanjeev"),
(63, "newuser", null, 21, 50, "mustaq");

#count students based on (batchid, mentorname)
select bid, mentorname, count(id)
from students 
group by bid, mentorname;

#avg of all students
select avg(psp)
from students;

#avg psp for batch, count of students in each batch
select bid as BatchId,  avg(psp) as AvgPsp, count(id) as TotalStudents
from students
group by bid;

#count of students 

select * 
from students s
 right join batches b
on  s.bid = b.bid;


select * from students;
select * from batches;

select s.stname as studentName, b.batchname as batchName , i.iname as instructorName
from students s
join batches b
on s.bid = b.bid 
join instructors i
on b.instructorid = i.id;

select s.stname, revby.stname 
from students s
join students revby
on s.reviewBy = revby.id;

#synctatical sugar
select s.stname, b.batchname
from students s
join batches b
using(bid); 
 
 #natural join, FOREIGN KEY on 1 side and primary key on another side
select s.stname, b.batchname
from students s                
natural join batches b;


#default is inner join ( common in both the set)


drop table if exists juice;
drop table if exists food;
create table juice (id int, jname varchar(20), primary key(id));
create table food (id int, fname varchar(30), primary key(id));


insert into juice (id, jname) values 
(1, "orange"),
(3, "mango"),
(4, "strwberry");

insert into food (id, fname) values
(2, "bred"),
(4, "doughnut"),
(42, "sandwithc");

select * 
from juice
cross join food;


