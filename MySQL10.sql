CREATE database if not exists SQL10;

USE SQL10;


DROP  TABLE IF EXISTS StudTable;
CREATE TABLE StudTable(
sid INT  PRIMARY KEY AUTO_INCREMENT NOT NULL,
sname VARCHAR(10),
bid INT,
psp INT,
phone VARCHAR(10) DEFAULT NULL,
bdate VARCHAR(20) DEFAULT NULL
);

DROP TABLE IF EXISTS batTable;
CREATE TABLE batTable(
bid INT PRIMARY KEY,
bname VARCHAR(10),
iid INT
);  

DROP TABLE IF EXISTS instTable;
CREATE TABLE instTable(
iid INT PRIMARY KEY,
iname VARCHAR(10)
);  

ALTER TABLE studTable ADD CONSTRAINT bidFk FOREIGN KEY(bid) REFERENCES  batTable(bid);
ALTER TABLE batTable ADD CONSTRAINT iidFk FOREIGN KEY(iid) REFERENCES  instTable(iid);

INSERT INTO instTable(iid, iname) VALUES
( 401, "I401"),
(402, "I402"),
(403, "I403"); 

INSERT INTO batTable(bid, bname, iid) VALUES
( 101, "b101", 401),
(102, "b102", 402),
(103, "b103", 401); 

INSERT INTO studTable(sid, sname, bid, psp,phone,bdate) VALUES
( 1, "id1", 101, 90, "4564", NULL),
( 2, "id2", 101, 50, NULL, NULL),
( 3, "id3", 101, 60, NULL, "5Mar2000"),
( 4, "id4", 102, 80,"4564", NULL),
( 5, "id5", 102, 40, NULL, "5Mar2000"),
( 6, "id6", 102, 20, "4564", NULL),
( 7, "id7", 103, 50, NULL, NULL),
( 8, "id8", 103, 70, "4564", NULL);
 
-- Create View of iid and its students corresponding psp.

SELECT instAlias.iid, AVG(psp)
FROM instTable  instAlias 
JOIN batTable batAlias 
ON instAlias.iid = batAlias.iid
JOIN studTable stAlias
ON stAlias.bid = batAlias.bid
GROUP BY instAlias.iid;


SELECT instAlias.iid, instAlias.iname, stAlias.sid, stAlias.sname
FROM instTable  instAlias 
JOIN batTable batAlias 
ON instAlias.iid = batAlias.iid
JOIN studTable stAlias
ON stAlias.bid = batAlias.bid;

DROP VIEW IF EXISTS InsStudentMapping;
CREATE VIEW InsStudentMapping AS 
(
	SELECT instAlias.iid, instAlias.iname, stAlias.sid, stAlias.sname
	FROM instTable  instAlias 
	JOIN batTable batAlias 
	ON instAlias.iid = batAlias.iid
	JOIN studTable stAlias
	ON stAlias.bid = batAlias.bid
);

SELECT * FROM InsStudentMapping;

SELECT *, IF(psp > 70, "ELIGIBLE", "NOT ELIGIBLE") as Eligibility
 FROM studTable;

SELECT *, 
CASE 
WHEN psp >= 90 THEN "Prority1"
WHEN psp >= 80 THEN "Priority2"
WHEN psp >= 60 THEN "Priority3"
ELSE "Priority4"
END AS  priorityId
FROM studTable;

SELECT * , IFNULL(phone, "PhoneNumber not provided")
FROM studTable;


SELECT * , coalesce(phone, bdate, "personalInfoNot provided") as pinfo
FROM studTable;

SELECT * FROM studTable
UNION 
SELECT * FROM studTable;

SELECT * FROM studTable
UNION ALL
SELECT * FROM studTable;


-- windowing functions

SELECT sid, sname, psp, 
ROW_NUMBER() OVER (ORDER BY psp DESC) as RNum,
RANK() OVER (ORDER BY psp DESC) as Rnk,
DENSE_RANK() OVER (ORDER BY psp DESC) AS DenseRnk
FROM studTable;


SELECT sid, sname, bid, psp, 
ROW_NUMBER() OVER (PARTITION BY bid ORDER by psp DESC) as Rnum,
RANK() OVER (PARTITION BY bid ORDER BY psp DESC) as Rnk,
DENSE_RANK() OVER (PARTITION BY bid ORDER BY psp DESC) AS DenseRank
FROM studTable
order by bid asc;


SELECT * FROM
(
	SELECT sid, sname, bid, psp, 
	ROW_NUMBER() OVER (PARTITION BY bid ORDER by psp DESC) as Rnum,
	RANK() OVER (PARTITION BY bid ORDER BY psp DESC) as Rnk,
	DENSE_RANK() OVER (PARTITION BY bid ORDER BY psp DESC) AS DenseRank
	FROM studTable
	order by bid asc
) Tbl
WHERE Rnk=2;