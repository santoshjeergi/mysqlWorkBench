drop database if exists lectudfMar30;
create database lectudfMar30;

use lectudfMar30;
drop table if exists stocksTable;

create table stocksTable (
stockid INT primary key,
sName VARCHAR(20),
quantity INT 
);

drop table IF EXISTS orderTable;
create table orderTable(
oid INT primary key,
stockId INT,
orderQuantity INT
);

alter table orderTable add constraint foreign key(stockId) references stocksTable(stockid);

insert into stocksTable(stockid, sName, quantity) values
(101, "Nestle", 10),
(102, "Britannia", 20),
(103, "ITC", 30),
(104, "HDFC", 60);

insert into orderTable(oid, stockId, orderQuantity) values 
(1, 101, 3),
(2, 102, 4),
(3, 101, 2),
(4, 102, 8);

with stockQuatityJoinedtable(sid, sname, qty) AS
#with stockQuatityJoinedtable AS
(
select st.stockid , st.sName,  ifnull(ot.orderQuantity, 0) as qty
from  stocksTable st
left join orderTable ot
on st.stockid = ot.stockId
),  
groupBasedOnStocs(sid,sname, qty) as 
(
 select sid,sname,SUM(qty) FROM stockQuatityJoinedtable 
 group by sid
 ), 
 stocksRemaining(sid, qLeft) as 
 (
   select sid , S.quantity - G.qty as remainingQty
   from groupBasedOnStocs G
   join stocksTable S
   ON G.sid = S.stockid
 )

select * from stocksRemaining;

select * from stocksTable;
select * from orderTable;
#step1, create the combined orderTable and productTable with left join to ensure nothing is leftout
#step2, group all the step1 table based on the stocKid, and calculate the sum
#step3, disaply the final stockList avaiable by subtracting stockTable and from the step2 table

WITH
 stock_order_mapping(sid, stockName, orderedQuantity) 
 AS
(
 select s.stockid, s.sName, IFNULL(o.orderQuantity, 0)
 from stocksTable s
 LEFT join orderTable o
 ON s.stockid = o.stockId
), group_stock_order(sid, stockName, totalOrdered) AS
(
    select sid, stockName, SUM(orderedQuantity) as totalOrdered
	from stock_order_mapping
	group by sid 
), final_stock_remaining(sid, quanityLeft) as
(
	select sid, s.quantity - g.totalOrdered as Remaining
    from group_stock_order g
    join stocksTable s
    ON g.sid = s.stockid
)
SELECT * from final_stock_remaining;



#Recirseive CTE

drop table if exists EmployeTable;
create table EmployeTable (
eId INT primary key,
fName varchar(20),
lName varchar(20),
reportId INT NULL);

insert into EmployeTable (eID, fName, lName, reportId) values
(110, "ceoJohn", "vand", NULL),
(120, "cfoPrincy","get", 110),
(130, "markinghead", "Ram", 110);

Insert into EmployeTable values(140, "techMarket", "sre", 130);
select * from EmployeTable;


with recursive employeHiercy AS ( 
 select eId,fName,lName, 0 as reportHierchy  from EmployeTable;
  UNION ALL
  select e.eId, e.fName, e.lName, e.reportHierchy+1
  from employeHiercy e;
  );
  
  select * from employeHiercy;
  use studentdemo; 
  select 