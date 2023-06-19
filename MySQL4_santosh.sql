DROP database if exists customerDb;
create database customerDb;

use customerDb;

create table customers (
	customer_id int(11) NOT NULL AUTO_INCREMENT,  
	first_name VARCHAR(20) NOT NULL,
	last_name VARCHAR(20) NOT NULL,
	birth_date date default NULL,
	phone VARCHAR(20) default NULL,
	address VARCHAR(20) NOT NULL,
	city VARCHAR(20) NOT NULL,
	state CHAR(2) NOT NULL,
	points  INT(11) NOT NULL default '0',
	primary key (customer_id)
);

select * 
from customers;

insert into customers values
(23, 'shr', 'kumar', '1988-09-11', '9880', 'karnata high', 'Bang', 'KA', '900');

-- insert multiple values
insert into customers values
(46, 'shr1', 'kumar', '1988-09-11', '9880', 'karnata high', 'Bang', 'KA', '900'),
(27, 'shr1', 'kumar', '1988-09-11', '9880', 'karnata high', 'Bang', 'KA', '900');

-- can we skip any colum, default auto increment 
INSERT into customers values 
(DEFAULT, "ABC", 'XYZ', default , default, 'kar hj', 'haveri', 'ka', default);

-- Readability wise this is prefered
insert into customers (phone , city, state, points, first_name, last_name, customer_id, address) VALUES
(981, 'bng', 'kl', 65, 'da', 'daada', 42, 'rajajina');

update customers set first_name = 'myk', last_name = 'cgg'
where customer_id = 27;

update customers 
set points = points + 1000
where customer_id >= 46; 

delete from customers where customer_id = 47;
select * 
from customers;


select 10, "hi", "hello";

select 10 As cid, 'sabtosh' as firstname, 'kumar' as last_name;

select first_name, customer_id, points, phone from customers;  

-- Expression within column.

SELECT *
FROM customers;

SELECT *
FROM customers
LIMIT 2
OFFSET 1;

insert into customers values
(10, 'uName10', 'kumar', '1988-09-11', '9880', 'karnata high', 'Bang', 'KA', '900'),
(12, 'uName11', 'kumar', '1988-09-11', '9880', 'karnata high', 'Bang', 'KA', '900');

select * from customers;


select 
CONCAT(first_name , ' ', last_name) AS fullname,
phone,
points > 800 AS pointsGT900,
points * 2 AS doublePoints
	from customers;
    
-- cuscustomer_id != 10;
select * from customers where customer_id <> 1990; 

select * from customers where birth_date IS NOT NULL;

select * from customers where points >= 1000 AND points <= 1900 OR state = 'KA';

select * from customers  where CITY LIKE '%_ang%';

select * 
from customers 
order by phone DESC
LIMIT 1
offset 2;
 
-- same as above 
 select * 
from customers 
order by phone DESC
LIMIT 2, 1;


