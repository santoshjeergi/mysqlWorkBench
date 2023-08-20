drop database if exists lectudfMar30;
create database lectudfMar30;

drop table if exists stocksTable;

create table stocksTable (
stockid INT primary key,
sName VARCHAR(20),
quantity INT 
);

drop table IF EXISTS orderTable;
create table orderTable(
oid INT,
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
(1, 101, 2),
(2, 102, 8);

#step1, create the combined orderTable and productTable with left join to ensure nothing is leftout
#step2, group all the step1 table based on the stocKid, and calculate the sum
#step3, disaply the final stockList avaiable by subtracting stockTable and from the step2 table

WITH
 stock_order_mapping(sid, stockName, orderedQuantity) 
 AS
(
 select s.stockid, s.sName, o.orderQuantity 
 from stocksTable s
 join orderTable o
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
