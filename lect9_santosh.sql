drop database  if exists newdb;
create database newdb;

use newdb;

drop table  if exists studentTable;
drop table  if exists batchTable;
drop table  if exists instrTable;

create table studentTable(
sid INT,
sName varchar(19),
bid INT,
psp INT, primary key(sid));

create table batchTable(
bid INT,
bName varchar(20),
iid INT,
primary key(bid));

create table instrTable(
iid INT,
iName varchar(20),
primary key(iid));

alter table studentTable add constraint foreign key(bid) references batchTable(bid);
alter table batchTable add constraint foreign key(iid) references instrTable(iid);

insert into instrTable(iid, iName) values 
(11, "aman"),
(13, "sumit");

insert into batchTable(bid, bName, iid) values
(1, "batch1", 11),
(2, "batch2", 13),
(3, "batch3", 13);

insert into studentTable(sid, sName, bid, psp) values
(101, "s101", 1, 75),
(102, "s102", 1, 55),
(103, "s103", 1, 90),
(104, "s104", 1, 64),
(105, "s105", 1, 87), 
(106, "s106", 2, 76);



select * from studentTable where psp > 
(select psp from studentTable where sid = 106);

drop table  if exists taTable;
create table taTable(
tid INT,
tName varchar(19),
sid INT,
primary key(tid), 
unique key(sid, tName));
alter table taTable add constraint foreign key(sid) references studentTable(sid);

insert into taTable(tid, tName, sid) values 
(501, "t5O1", 103),
(502, "t5O2", 104),
(503, "t5O2", NULL);

#SELECT WHO ARE ta AND STUDENT
select * 
from taTable 
where sid is not NULL and sid IN 
(select sid from studentTable);

select s.sid as StudentId, t.tid as TaId
from studentTable s
where sid in
(SELECT sid from taTable t where sid is not NULL);

#Select all students who have psp greater than all students of batch 2


select * 
from studentTable sout
where psp > 
(select MAX(psp)
from studentTable sin 
where sin.bid = 2);

#OR 

select * 
from studentTable sout
where psp > ALL 
(select MAX(psp)
from studentTable sin 
where sin.bid = 2);

#avg psp per instructor


select i.iName, AVG(s.psp) as AverageIId 
from instrTable i
join batchTable b
on i.iid = b.iid
join  studentTable s
on s.bid = b.bid
GROUP by i.iid;

