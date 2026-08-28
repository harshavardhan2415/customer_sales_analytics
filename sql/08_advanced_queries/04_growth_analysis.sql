USE customer_sales_analytics;

WITH monthly_sales AS
(
    SELECT

        d.year_number,

        d.month_number,

        SUM(f.sales)
            AS sales

    FROM fact_sales f

    JOIN dim_date d
        ON f.sales_date_key = d.date_key

    GROUP BY

        d.year_number,
        d.month_number
),

comparison AS
(
    SELECT

        *,

        LAG(sales) OVER
        (
            ORDER BY
                year_number,
                month_number
        ) AS previous_month_sales

    FROM monthly_sales
)

SELECT

    year_number,

    month_number,

    sales,

    previous_month_sales,

    sales - previous_month_sales
        AS sales_change,

    ROUND(

        100 *
        (
            sales - previous_month_sales
        )
        /
        NULLIF(previous_month_sales,0),

        2

    ) AS growth_percentage

FROM comparison

ORDER BY

    year_number,
    month_number;
