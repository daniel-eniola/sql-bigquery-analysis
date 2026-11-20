-- Dataset: warehouse_orders (my own project), tables: warehouse and orders
-- Join key: warehouse_id

-- 17. Preview the warehouse table
-- Shows all columns for the 10 warehouses, each with the state it is in.
SELECT
 *
FROM
 `project-cc781377-6842-4add-a3a.warehouse_orders.warehouse`;

-- 18. Preview the first 100 rows of the orders table
-- LIMIT keeps the result small. The full table has 9,999 orders.
SELECT
 *
FROM
 `project-cc781377-6842-4add-a3a.warehouse_orders.orders`
LIMIT 100;

-- 19. Join orders to warehouses, using table aliases
-- Matches each order to its warehouse on warehouse_id. Returned 9,999 rows.
SELECT
 *
FROM
 `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS orders
JOIN
 `project-cc781377-6842-4add-a3a.warehouse_orders.warehouse` AS warehouse
ON orders.warehouse_id = warehouse.warehouse_id;

-- 20. Same join, keeping only the columns needed
-- orders.* keeps every orders column, plus the warehouse name and state. Returned 9,999 rows.
SELECT
 orders.*,
 warehouse.warehouse_alias,
 warehouse.state
FROM
 `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS orders
JOIN
 `project-cc781377-6842-4add-a3a.warehouse_orders.warehouse` AS warehouse
ON orders.warehouse_id = warehouse.warehouse_id;

-- 21. Count the states across the joined rows (COUNT)
-- COUNT counts every row, including repeats, so it returns 9,999 instead of the number of states.
SELECT
 COUNT(warehouse.state) AS num_states
FROM
 `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS orders
JOIN
 `project-cc781377-6842-4add-a3a.warehouse_orders.warehouse` AS warehouse
ON orders.warehouse_id = warehouse.warehouse_id;

-- 22. Count the distinct states (COUNT DISTINCT)
-- DISTINCT removes the repeats, so each state is counted once. Returned 3.
SELECT
 COUNT (DISTINCT warehouse.state) AS num_states
FROM
 `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS orders
JOIN
 `project-cc781377-6842-4add-a3a.warehouse_orders.warehouse` AS warehouse
ON orders.warehouse_id = warehouse.warehouse_id;

-- 23. Count the orders placed in each state
-- GROUP BY warehouse.state gives one row per state, and COUNT DISTINCT counts each order once. Returned 3 rows.
SELECT
 warehouse.state,
 COUNT(DISTINCT orders.order_id) AS num_orders
FROM
 `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS orders
JOIN
 `project-cc781377-6842-4add-a3a.warehouse_orders.warehouse` AS warehouse
ON orders.warehouse_id = warehouse.warehouse_id
GROUP BY
 warehouse.state;

-- 24. Same query, without table names in the SELECT
-- state and order_id each exist in only one table, so BigQuery knows where they come from. Same 3 rows.
SELECT
 state,
 COUNT(DISTINCT order_id) AS num_orders
FROM
 `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS orders
JOIN
 `project-cc781377-6842-4add-a3a.warehouse_orders.warehouse` AS warehouse
ON orders.warehouse_id = warehouse.warehouse_id
GROUP BY
 warehouse.state;

-- 28. Label each warehouse by the share of all orders it fulfilled
-- A subquery gets the total orders (9,999). CASE divides each warehouse's orders by that total and labels the share: 0-20%, 21-60% or more than 60%.
-- HAVING keeps only the warehouses that have orders. Returned 6 rows.
SELECT
 Warehouse.warehouse_id,
 CONCAT(Warehouse.state, ': ', Warehouse.warehouse_alias) AS warehouse_name,
 COUNT(Orders.order_id) AS number_of_orders,
 (SELECT COUNT(*) FROM `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS Orders) AS total_orders,
 CASE
  WHEN COUNT(Orders.order_id)/(SELECT COUNT(*) FROM `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS Orders) <= 0.20
  THEN 'Fulfilled 0-20% of Orders'
  WHEN COUNT(Orders.order_id)/(SELECT COUNT(*) FROM `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS Orders) > 0.20
  AND COUNT(Orders.order_id)/(SELECT COUNT(*) FROM `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS Orders) <= 0.60
  THEN 'Fulfilled 21-60% of Orders'
  ELSE 'Fulfilled more than 60% of Orders'
 END AS fulfillment_summary
FROM `project-cc781377-6842-4add-a3a.warehouse_orders.warehouse` AS Warehouse
LEFT JOIN `project-cc781377-6842-4add-a3a.warehouse_orders.orders` AS Orders
ON Orders.warehouse_id = Warehouse.warehouse_id
GROUP BY
 Warehouse.warehouse_id,
 warehouse_name
HAVING
 COUNT(Orders.order_id) > 0;
