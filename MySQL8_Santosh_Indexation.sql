select * from customers;

show index in customers;

EXPLAIN select * from customers where customer_id =9;

EXPLAIN select * from customers where points=1486;

create index idx_customers_points ON customers(points);

DROP index idx_customers_points ON customers;

EXPLAIN select * from customers where first_name="abc";

DROP index idx_customers_fname ON customers;
create index idx_customers_fname ON customers(first_name(4));
