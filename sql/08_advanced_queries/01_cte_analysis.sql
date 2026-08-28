USE customer_sales_analytics;

WITH customer_sales AS
(
    SELECT

        c.customer_id,

        CONCAT(
            c.customer_name,
            ' ',
            c.last_name
        ) AS customer_name,

        SUM(f.sales)
            AS total_sales,

        SUM(f.profit)
            AS total_profit

    FROM fact_sales f

    JOIN dim_customer c
        ON f.customer_key = c.customer_key

    GROUP BY

        c.customer_id,
        c.customer_name,
        c.last_name
)

SELECT *

FROM customer_sales

WHERE total_sales >
(
    SELECT AVG(total_sales)
    FROM customer_sales
)

ORDER BY total_sales DESC;
