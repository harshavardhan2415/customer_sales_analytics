USE customer_sales_analytics;

CREATE OR REPLACE VIEW vw_monthly_sales AS

SELECT

    d.year_number,

    d.month_number,

    d.month_name,

    SUM(f.sales)
        AS total_sales,

    SUM(f.profit)
        AS total_profit,

    SUM(f.quantity)
        AS total_quantity,

    COUNT(DISTINCT f.order_id)
        AS total_orders,

    AVG(f.discount)
        AS average_discount

FROM fact_sales f

JOIN dim_date d
    ON f.sales_date_key = d.date_key

GROUP BY

    d.year_number,
    d.month_number,
    d.month_name;
