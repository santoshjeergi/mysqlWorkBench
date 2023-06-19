-- show db default isolation level
show variables like '%iso%'; 
create database  if not exists sql6Agg;


USE sql6Agg;
-- set session transaction isolation level read uncommitted;
set session transaction isolation level read committed;
start transaction;
select * from studentsTrasact;


DROP TABLE IF EXISTS studentsTrasact;
create table studentsTrasact (
sid INT NOT NULL AUTO_INCREMENT ,
fname VARCHAR(10),
email VARCHAR(10),
bid INT,
primary key (sid)
);


INSERT into studentsTrasact(sid, fname, email, bid) VALUES
(13, "san13", "s@r.com", 121),
(14, "san14", "s@r.com", 13),
(15, "san15", "s@r.com", 14);

start transaction;
EXPLAIN select * from studentsTrasact;

update studentsTrasact set bid=187 where sid=15;


-- use JoinDemo;



-- rollback;
-- commit;