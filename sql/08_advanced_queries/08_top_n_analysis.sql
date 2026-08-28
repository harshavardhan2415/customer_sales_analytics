USE customer_sales_analytics;

WITH product_sales AS
(
    SELECT

        p.category_of_goods,

        p.product_name,

        SUM(f.sales)
            AS total_sales

    FROM fact_sales f

    JOIN dim_product p
        ON f.product_key = p.product_key

    GROUP BY

        p.category_of_goods,
        p.product_name
),

ranked AS
(
    SELECT

        *,

        DENSE_RANK() OVER
        (
            PARTITION BY category_of_goods

            ORDER BY total_sales DESC

        ) AS product_rank

    FROM product_sales
)

SELECT *

FROM ranked

WHERE product_rank <= 5

ORDER BY

    category_of_goods,

    product_rank;
