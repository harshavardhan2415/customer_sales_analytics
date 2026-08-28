
USE customer_sales_analytics;

-- Duplicate customers

SELECT
    customer_id,
    COUNT(*) AS records
FROM stg_customer_sales
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY records DESC;


-- Duplicate orders

SELECT
    order_id,
    COUNT(*) AS records
FROM stg_customer_sales
GROUP BY order_id
HAVING COUNT(*) > 1
ORDER BY records DESC;


-- Duplicate products

SELECT
    product_id,
    COUNT(*) AS records
FROM stg_customer_sales
GROUP BY product_id
HAVING COUNT(*) > 1
ORDER BY records DESC;

