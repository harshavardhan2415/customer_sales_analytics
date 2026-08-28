USE customer_sales_analytics;

WITH customer_metrics AS
(
    SELECT

        c.customer_id,

        COUNT(DISTINCT f.order_id)
            AS orders,

        SUM(f.sales)
            AS sales,

        SUM(f.profit)
            AS profit

    FROM fact_sales f

    JOIN dim_customer c
        ON f.customer_key = c.customer_key

    GROUP BY c.customer_id
)

SELECT

    customer_id,

    orders,

    sales,

    profit,

    CASE

        WHEN sales >= 100000
         AND orders >= 10
         AND profit > 0

        THEN 'High Value'

        WHEN sales >= 50000
         AND orders >= 5

        THEN 'Medium Value'

        WHEN profit < 0

        THEN 'Loss Making'

        ELSE 'Low Value'

    END AS customer_segment

FROM customer_metrics

ORDER BY sales DESC;
