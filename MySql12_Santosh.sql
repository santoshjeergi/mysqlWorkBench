drop database if exists udf;
create database udf;

drop tables  if exists pointTable;

create table pointTable (
fname varchar(20),
state varchar(20),
points int default 0
);
insert into pointTable(fname, state, points)  values
("u1", "KA", 100),
("u2", "KA", 200),
("u3", "KL", 200),
("u4", "KL", 300),
("u5", "ap", 200),
("u6", "ap", 100);

select fname, state, 
(select AVG(points) from pointTable pi where pi.state = po.state) as Average 
from pointTable po;

DROP function if exists fn_AvgPointsOfstate;
DELIMITER $$
CREATE FUNCTION fn_AvgPointsOfstate
(
 stateInarg CHAR(2)
)
RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE Average INT;
	select AVG(points) into Average from pointTable pi where state = stateInarg;
	RETURN Average;
END$$

select fname, state, fn_AvgPointsOfstate(state) as avgStatePoints from pointTable;


#An another example

#customers  cust_id, cust_name, state, points 
#orders order_id, cust_id, 
#order_items order_id , quty, unit_price, prod_id;
#products -> prname, pid, price.

drop table if exists order_items;

drop table if exists products;
create table products (   prod_id INT primary key,   prod_name VARCHAR(20),   unitPrice INT  );

drop table if exists orders;

drop table if exists customers;
create table customers ( cust_id INT primary key, cust_name VARCHAR(20), state VARCHAR(30), points INT);

drop table if exists orders;
create table orders ( order_id INT primary key, cust_id INT);
alter table orders add constraint foreign key(cust_id) references customers(cust_id);

drop table if exists order_items;
create table order_items (oder_item_id INT primary key, prod_id INT,  quantity INT, order_id INT);
alter table order_items add constraint foreign key(prod_id) references products(prod_id);
alter table order_items add constraint foreign key(order_id) references orders(order_id);

insert into products (prod_id, prod_name, unitPrice) values  (501, "soap", 20), (502, "book", 10), (503, "pencil", 5);

insert into customers (cust_id, cust_name, state, points) values 
(101, "cust1", "st1", 100),  
(102, "cust2", "st1", 120),
(103, "cust3", "st2", 130),
(104, "cust4", "st2", 130),
(105, "cust5", "st3", 120);

insert into  orders(order_id, cust_id) values  (201, 101), (202, 101), (203, 102), (204, 102), (205, 103);

insert into  order_items(oder_item_id, prod_id, quantity, order_id) values 
( 301, 501, 5, 201), # soap 20 * 5
(302, 502, 6, 201),
(303, 503, 9, 203),
(304, 501, 9, 204),
(305, 502, 9, 205);

select * from products; 
select * from customers;
select * from orders;
select * from order_items;

#Question: total No of quantity per customer, 

select cust_id, cust_name, 
(
	select  IFNULL(SUM(quantity), 0)
    from orders oin
    #JOIN orders  oin
    #ON cin.cust_id = oin.cust_id
    JOIN order_items oitemin
    ON oitemin.order_id = oin.order_id
    WHERE co.cust_id = oin.cust_id
) TotalQuanity 
from customers co;

drop function  if exists totalQuanity;
DELIMITER $$
CREATE FUNCTION totalQuanity
(
   custId INT
)
RETURNS INTEGER
DETERMINISTIC
BEGIN
	DECLARE  TotalQuanity INT;
	 select  IFNULL(SUM(quantity), 0) into TotalQuanity
    from orders oin
    JOIN order_items oitemin
    ON oitemin.order_id = oin.order_id
    WHERE cust_id = custId;	
	RETURN TotalQuanity;
END$$

select * ,totalQuanity(cust_id)  from customers

#Requirement, print the t
-- id, name, points, state
-- avgpointforthestateofcustomer (cstmrid)
-- totalqtyforcustomer (cstmrid)
-- totalmoneyspentbycstmr (cstmrid)

-- the above can be done via 3 udfs
-- the above can be done with one sp


