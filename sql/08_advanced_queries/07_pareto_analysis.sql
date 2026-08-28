USE customer_sales_analytics;

WITH product_sales AS
(
    SELECT

        p.product_id,

        p.product_name,

        SUM(f.sales)
            AS total_sales

    FROM fact_sales f

    JOIN dim_product p
        ON f.product_key = p.product_key

    GROUP BY

        p.product_id,
        p.product_name
),

ranked AS
(
    SELECT

        *,

        SUM(total_sales) OVER()
            AS grand_total,

        SUM(total_sales) OVER
        (
            ORDER BY total_sales DESC

            ROWS BETWEEN
                UNBOUNDED PRECEDING
                AND CURRENT ROW

        ) AS cumulative_sales

    FROM product_sales
)

SELECT

    product_id,

    product_name,

    total_sales,

    ROUND(
        cumulative_sales /
        NULLIF(grand_total,0) * 100,
        2
    ) AS cumulative_percentage,

    CASE

        WHEN cumulative_sales /
             NULLIF(grand_total,0)
             <= 0.80

        THEN 'Top 80%'

        ELSE 'Remaining 20%'

    END AS pareto_group

FROM ranked

ORDER BY total_sales DESC;
