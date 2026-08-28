USE customer_sales_analytics;

CREATE OR REPLACE VIEW vw_sales_detail AS

SELECT

    f.sales_key,

    f.order_id,

    c.customer_id,

    CONCAT(
        c.customer_name,
        ' ',
        c.last_name
    ) AS customer_name,

    c.segment,

    c.customer_age,

    c.customer_status,

    p.product_id,

    p.product_name,

    p.sub_category,

    p.category_of_goods,

    l.region,

    l.country,

    l.state,

    l.postal_code,

    l.city_type,

    l.outlet_type,

    sd.full_date AS sales_date,

    od.full_date AS order_date,

    sh.full_date AS ship_date,

    f.sales,

    f.quantity,

    f.discount,

    f.profit,

    ROUND(
        f.profit /
        NULLIF(f.sales,0),
        4
    ) AS profit_margin,

    DATEDIFF(
        sh.full_date,
        od.full_date
    ) AS shipping_days,

    f.ship_mode

FROM fact_sales f

JOIN dim_customer c
    ON f.customer_key = c.customer_key

JOIN dim_product p
    ON f.product_key = p.product_key

JOIN dim_location l
    ON f.location_key = l.location_key

LEFT JOIN dim_date sd
    ON f.sales_date_key = sd.date_key

LEFT JOIN dim_date od
    ON f.order_date_key = od.date_key

LEFT JOIN dim_date sh
    ON f.ship_date_key = sh.date_key;
