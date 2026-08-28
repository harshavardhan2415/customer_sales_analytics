USE customer_sales_analytics;

CREATE OR REPLACE VIEW vw_customer_360 AS

SELECT

    c.customer_id,

    CONCAT(
        c.customer_name,
        ' ',
        c.last_name
    ) AS customer_name,

    c.segment,

    c.customer_age,

    c.customer_status,

    COUNT(DISTINCT f.order_id)
        AS total_orders,

    COALESCE(
        SUM(f.sales),
        0
    ) AS total_sales,

    COALESCE(
        SUM(f.profit),
        0
    ) AS total_profit,

    COALESCE(
        SUM(f.quantity),
        0
    ) AS total_quantity,

    ROUND(
        SUM(f.sales) /
        NULLIF(
            COUNT(DISTINCT f.order_id),
            0
        ),
        2
    ) AS average_order_value,

    ROUND(
        SUM(f.profit) /
        NULLIF(
            SUM(f.sales),
            0
        ),
        4
    ) AS profit_margin,

    MIN(d.full_date)
        AS first_purchase_date,

    MAX(d.full_date)
        AS last_purchase_date

FROM dim_customer c

LEFT JOIN fact_sales f
    ON c.customer_key = f.customer_key

LEFT JOIN dim_date d
    ON f.sales_date_key = d.date_key

GROUP BY

    c.customer_id,
    c.customer_name,
    c.last_name,
    c.segment,
    c.customer_age,
    c.customer_status;
