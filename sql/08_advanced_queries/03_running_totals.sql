USE customer_sales_analytics;

WITH monthly_sales AS
(
    SELECT

        d.year_number,

        d.month_number,

        d.month_name,

        SUM(f.sales)
            AS monthly_sales

    FROM fact_sales f

    JOIN dim_date d
        ON f.sales_date_key = d.date_key

    GROUP BY

        d.year_number,
        d.month_number,
        d.month_name
)

SELECT

    year_number,

    month_number,

    month_name,

    monthly_sales,

    SUM(monthly_sales) OVER
    (
        PARTITION BY year_number

        ORDER BY month_number

        ROWS BETWEEN
            UNBOUNDED PRECEDING
            AND CURRENT ROW

    ) AS ytd_sales

FROM monthly_sales

ORDER BY

    year_number,
    month_number;
