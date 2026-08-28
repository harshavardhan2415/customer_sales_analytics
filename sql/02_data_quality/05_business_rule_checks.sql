USE customer_sales_analytics;

-- Negative sales

SELECT *
FROM stg_customer_sales
WHERE sales < 0;


-- Invalid quantity

SELECT *
FROM stg_customer_sales
WHERE quantity <= 0;


-- Invalid discount

SELECT *
FROM stg_customer_sales
WHERE discount < 0
   OR discount > 1;


-- Missing profit

SELECT *
FROM stg_customer_sales
WHERE profit IS NULL;


-- Negative profit

SELECT *
FROM stg_customer_sales
WHERE profit < 0;


-- Missing order IDs

SELECT *
FROM stg_customer_sales
WHERE order_id IS NULL
   OR order_id = '';
