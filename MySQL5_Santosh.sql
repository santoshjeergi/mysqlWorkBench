-- JOINs
create database if not exists JoinDemo;

use JoinDemo;

DROP TABLE IF EXISTS students;
create table students (
sid INT(10) NOT NULL AUTO_INCREMENT ,
fname VARCHAR(10),
lname VARCHAR(10),
email VARCHAR(10),
primary key (sid)
);

ALTER TABLE students
ADD CONSTRAINT email_uk unique key(email);

DROP TABLE IF EXISTS batches;
create table batches (
id INT PRIMARY KEY,
bname VARCHAR(20)
);

ALTER TABLE students add bid int not NULL;

ALTER TABLE students
ADD CONSTRAINT foreignKey_batch FOREIGN KEY(bid) REFERENCES batches(id);

INSERT into batches VALUES
(1, "jan2022"),
(2, "feb2022");

SHOW FULL TABLES;

INSERT into students VALUES
(34, 'abc1', 'xyz1', 'e1@a.com', 2),
(DEFAULT, '1abc', 'xyz', 'b@a.com', 1);

select * from JoinDemo.students;

select * from JoinDemo.batches;


SELECT 
CONCAT(s.fname,'',s.lname) AS fullname,  b.bname
FROM  students s
JOIN  batches b
ON (s.bid = b.id);

SELECT 
CONCAT(s.fname,'',s.lname) AS fullname,  b.bname
FROM  students s
JOIN  batches b
ON (s.bid = b.id)
WHERE b.bname = "jan2022";


-- Self Join
DROP TABLE IF EXISTS studentReview;
CREATE TABLE studentReview (
     sid INT NOT NULL AUTO_INCREMENT,
     sName VARCHAR(20),
     email VARCHAR(10) DEFAULT NULL,
     revId INT,
     PRIMARY KEY (sid)   
);

 -- CONSTRAINT reviewname FOREIGN KEY (sid) REFERENCES studentReview (revId)
ALTER TABLE studentReview 
ADD CONSTRAINT SelfRefReviewId FOREIGN KEY(revId)
REFERENCES studentReview(sid);

DELETE from studentReview where sid = 121;

INSERT into studentReview VALUES
(121, "san", "s@r.com", NULL);

INSERT into studentReview VALUES
(13, "san13", "s@r.com", 121),
(14, "san14", "s@r.com", 13),
(15, "san15", "s@r.com", 14);


select * from studentReview;

select s.sName, r.SName 
FROM studentReview s
JOIN studentReview r
ON s.revId = r.sid;

-- Multi table Join

CREATE TABLE studentsMj (
sid INT PRIMARY KEY NOT NULL,
sname VARCHAR(20)
);

CREATE TABLE batchMj (
bid INT, 
bname VARCHAR(20),
PRIMARY KEY(bid) 
);

CREATE TABLE instructorMj (
iid INT, 
instName VARCHAR(20)
);
ALTER TABLE instructorMj ADD CONSTRAINT primary key(iid);

ALTER TABLE studentsMj ADD Sbid INT NOT NULL;

ALTER TABLE batchMj ADD Biid INT NOT NULL;

ALTER TABLE studentsMj ADD CONSTRAINT FOREIGN KEY(Sbid) REFERENCES   batchMj(bid);

ALTER TABLE batchMj ADD CONSTRAINT FOREIGN KEY(Biid) REFERENCES instructorMj(iid);
  
INSERT INTO  instructorMj VALUES 
( 450, "ajayInstr450"),
( 451, "amayInstr451");

INSERT INTO batchMj VALUES 
(300, "batch300", 451),
(301, "batch301", 450);

INSERT INTO studentsMj VALUES
(12, "student12", 301),
(15, "student15", 300);

select * 
FROM studentsMj s
JOIN  batchMj b
ON s.Sbid = b.bid
JOIN  instructorMj i
ON b.Biid = i.iid;

select s.sname, i.instName 
FROM studentsMj s
JOIN  batchMj b
ON s.Sbid = b.bid
JOIN  instructorMj i
ON b.Biid = i.iid;



-- Synctatical 

-- s.bid == b.bid , instead of ON  s.bid == b.bid , USING is fine
select s.sname, i.instName 
FROM studentsMj s
JOIN  batchMj b
USING bid; 


SELECT * from studentsMj 
NATURAL JOIN batchMj;

-- DEFAULT JOIN IN INNER JOIN

-- Left over LEFT JOIN

-- right join 

