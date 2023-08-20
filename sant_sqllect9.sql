drop database if exists lect89;
create database if not exists lect89;

drop table  if exists student;
create table student(
sid int primary key not null,
sname varchar(10),
pnum varchar(10) default null,
psp int,
batchid int
#primary key(sid)
);

ALTER TABLE student add constraint foreign key(batchid) references batch(bid);

create table batch(
bid int primary key not null,
bname varchar(10)
);

insert into batch

insert into student(sid, sname, psp, batchid, pnum)  

