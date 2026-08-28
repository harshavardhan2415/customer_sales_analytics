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

SELECT

    customer_id,

    customer_name,

    total_sales,

    total_profit,

    RANK() OVER
    (
        ORDER BY total_sales DESC
    ) AS sales_rank,

    DENSE_RANK() OVER
    (
        ORDER BY total_profit DESC
    ) AS profit_rank,

    ROUND(

        100 *
        total_sales /
        SUM(total_sales) OVER(),

        2

    ) AS sales_percentage

FROM customer_sales

ORDER BY sales_rank;
