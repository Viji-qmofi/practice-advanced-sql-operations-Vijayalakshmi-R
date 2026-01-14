-- =========================================
-- Advanced SQL Practice
-- =========================================

-- Task 1: INNER JOIN
-- Show all orders with the customer's first and last name

SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.id;

-- -----------------------------------------
-- Task 2: LEFT JOIN
-- Show all orders, including orders without a customer

SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.id;

-- -----------------------------------------
-- Task 3: RIGHT JOIN
-- Show all customers and any orders they may have (including customers with no orders)

SELECT customers.id, customers.first_name, customers.last_name, orders.id, orders.total_amount
FROM orders
RIGHT JOIN customers
ON orders.customer_id = customers.id;

-- -----------------------------------------
-- Task 4: GROUP BY with COUNT
-- Count how many orders each customer has placed

SELECT customer_id, count(id) 
FROM orders
GROUP BY customer_id;

-- Another way with JOINs
SELECT
    c.id AS customer_id,
    c.first_name,
    c.last_name,
    COUNT(o.id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
GROUP BY c.id, c.first_name, c.last_name;

-- -----------------------------------------
-- Task 5: GROUP BY with SUM
-- Calculate the total amount spent by each customer

SELECT
    c.id AS customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS amount_spent
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
GROUP BY c.id, c.first_name, c.last_name;

-- -----------------------------------------
-- Task 6: GROUP BY with AVG
-- Find the average order amount per customer
SELECT
    c.id AS customer_id,
    c.first_name,
    c.last_name,
    AVG(o.total_amount) AS AVG_ORDER_amount
FROM customers c
LEFT JOIN orders o
    ON c.id = o.customer_id
GROUP BY c.id, c.first_name, c.last_name;

-- -----------------------------------------
-- Task 7: WHERE clause
-- Find orders placed after January 31, 2023

SELECT *
FROM orders
WHERE order_date > '2023-01-31';

-- -----------------------------------------
-- Task 8: HAVING clause
-- Find customers who have spent more than $300 total
SELECT 
	c.id AS customer_id,
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS amount_spent
FROM customers c
LEFT JOIN orders o
     ON c.id = o.customer_id
GROUP BY c.id, c.first_name, c.last_name
HaVING amount_spent > 300;

-- -----------------------------------------
-- Task 9: HAVING clause
-- Find customers who have placed at least 2 orders
SELECT
    c.first_name,
    c.last_name,
    COUNT(o.id) AS order_count
FROM customers c
JOIN orders o
    ON c.id = o.customer_id
GROUP BY c.first_name, c.last_name
HAVING COUNT(o.id) >= 2;

-- -----------------------------------------
-- Task 10: Subquery
-- Find customers who have placed more than one order
SELECT
    first_name,
    last_name
FROM customers
WHERE id IN (
    SELECT customer_id
    FROM orders
    -- WHERE customer_id IS NOT NULL
    GROUP BY customer_id
    HAVING COUNT(*) > 1
);

-- -----------------------------------------
-- Task 11: Subquery with aggregate
-- Find orders that are higher than the average order amount

SELECT *
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount)
    FROM orders
);

-- -----------------------------------------
-- Task 12: Subquery in WHERE
-- Find customers who have never placed an order

SELECT * FROM customers
WHERE id NOT IN (
SELECT customer_id
FROM orders
WHERE customer_id IS NOT NULL
);

-- -----------------------------------------
-- Task 13: Subquery with JOIN
-- Find customers whose total spending is above the overall average spending

SELECT
    c.first_name,
    c.last_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.id = o.customer_id
GROUP BY c.first_name, c.last_name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_amount)
    FROM orders
);
-- -----------------------------------------


