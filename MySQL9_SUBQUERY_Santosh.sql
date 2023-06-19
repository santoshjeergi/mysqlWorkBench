-- Sub Queries

CREATE DATABASE IF NOT EXISTS SQL9;

USE SQL9;

DROP TABLE IF EXISTS stTable;
CREATE table stTable (
sid INT PRIMARY KEY NOT NULL,
sname VARCHAR(20),
psp INT 
);

DROP TABLE IF EXISTS bTable;
CREATE table bTable (
bid INT PRIMARY KEY NOT NULL,
bname VARCHAR(20)
);

ALTER TABLE stTable ADD  bid INT NOT NULL;
ALTER TABLE stTable ADD CONSTRAINT FOREIGN KEY(bid) REFERENCES  bTable(bid);


DROP TABLE IF EXISTS instTable;
CREATE table instTable (
iid INT PRIMARY KEY NOT NULL,
iname VARCHAR(20)
);

ALTER TABLE bTable ADD  iid INT NOT NULL;
ALTER TABLE bTable ADD CONSTRAINT FOREIGN KEY(iid) REFERENCES  instTable(iid);


insert into instTable(iid, iname) VALUES 
( 401, "I401"),
( 402, "I402");

insert into bTable(bid, bname, iid) VALUES 
( 301, "B301", 401),
( 302, "B302", 402),
( 303, "B303", 402);


insert into stTable(sid, sname, bid, psp) VALUES 
( 101, "S101", 301, 80),
( 102, "S102", 301, 70),
( 103, "S103", 302, 50),
( 104, "S104", 302, 80),
( 105, "S105", 302, 70),
( 106, "S106", 303, 50),
( 107, "S107", 303, 80),
( 108, "S108", 303, 70),
( 109, "S109", 302, 50);
