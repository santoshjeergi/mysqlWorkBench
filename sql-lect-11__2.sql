USE sql_store;

SELECT * FROM products;
SELECT * FROM order_items;

-- CTE
WITH prdOrders(pid, oqty) AS
(
	SELECT p.product_id, IFNULL(oi.quantity, 0)
    FROM products p
    LEFT JOIN order_items oi
		ON p.product_id = oi.product_id
), prdOrdersGrouped (pid, oqty) AS
(
	SELECT pid, SUM(oqty)
    FROM prdOrders
    GROUP BY pid
), rmngProducts (pid, pname, qty) AS
(
	SELECT p.product_id, p.name, p.quantity_in_stock - pog.oqty
    FROM products p
    JOIN prdOrdersGrouped pog
		ON p.product_id = pog.pid
)
SELECT * FROM rmngProducts;

-- Recursive CTE = Fib
WITH RECURSIVE fib (a, b, n) AS
(
	SELECT 0, 1, 0
    UNION
    SELECT b, a + b, n + 1 FROM fib WHERE n < 4
)
SELECT * FROM fib;

-- 0, 1, 0
-- 1, 1, 1
-- 1, 2, 2
-- 2, 3, 3
-- 3, 5, 4

USE sql_hr;

SELECT * FROM employees;

WITH RECURSIVE cte (eid, ename, path) AS
(
	SELECT employee_id, first_name, CAST(employee_id AS CHAR(100))
    FROM employees WHERE reports_to IS NULL
    UNION
    SELECT e.employee_id, e.first_name, CONCAT(e.employee_id, ' -> ', m.path)
    FROM employees e
    JOIN cte m
		ON e.reports_to = m.eid
)
SELECT * FROM cte;

-- 37270, yovonnda, 37270 (y)

-- 33391, darcy, 33391 -> 37270 (y)
-- 37851, sayer, 37851 -> 37851 (y)

-- 40448
-- 56274
-- 63196
-- 67009

--  1. String: length, upper, lower, ltrim, rtrim, trim, left, right, substring, locate
--	2. Date, Time, DateTime: now, curdate, curtime, year, month, day, dayname,  date_add, date_sub, date_diff
--  3. Decimals: round, truncate, ceiling, floor, abs, rand 
-- BULTIN FUnctions 

USE sql_store;

-- string
SELECT * FROM customers;
SELECT first_name, LENGTH(first_name), UPPER(first_name), LOWER(first_name) FROM customers;
SELECT first_name, LTRIM(first_name), RTRIM(first_name), TRIM(first_name) FROM customers;
SELECT first_name, LEFT(first_name, 4), RIGHT(first_name, 4) FROM customers;
SELECT first_name, SUBSTRING(first_name, 3, 2) FROM customers;
SELECT first_name, LOCATE('mm', first_name) FROM customers;

-- date and time functions (date, time, datetime)
SELECT * FROM orders;
SELECT now(), curdate(), curtime();
SELECT now(), year(now()), month(now()), day(now()), dayname(now());
SELECT order_date, year(order_date), month(order_date), day(order_date), dayname(order_date) FROM orders;

SELECT order_date, date_add(order_date, interval 1 month) FROM orders;
SELECT order_date, date_sub(order_date, interval 1 month) FROM orders;


-- orders placed during last 24 hours
SELECT *
FROM orders
WHERE order_date >= date_sub(now(), interval 24 hour);

SELECT order_Date, datediff(now(), order_date)
FROM orders;

-- decimal
SELECT 2.5137, round(2.5137, 2);
SELECT 2.5155, round(2.5155, 2);  
SELECT 2.5137, truncate(2.5137, 2);
SELECT 2.5155, truncate(2.5155, 2);  

SELECT 2.5, -2.5, abs(2.5), abs(-2.5);

-- ceiling
-- 4.9 -> 5
-- 4.0 -> 4

-- floor
-- 4.9 -> 4
-- 4 -> 4

SELECT 4.9, ceiling(4.9), floor(4.9);

SELECT rand();


-- group orders by year
SELECT * FROM orders;

SELECT month(order_date), COUNT(*)
FROM orders
GROUP BY month(order_date);





