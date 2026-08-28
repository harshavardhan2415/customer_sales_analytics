USE customer_sales_analytics;

CREATE OR REPLACE VIEW vw_region_performance AS

SELECT

    l.region,

    l.state,

    l.city_type,

    l.outlet_type,

    COUNT(DISTINCT f.order_id)
        AS total_orders,

    COUNT(DISTINCT f.customer_key)
        AS customers,

    SUM(f.sales)
        AS total_sales,

    SUM(f.profit)
        AS total_profit,

    SUM(f.quantity)
        AS total_quantity,

    ROUND(
        SUM(f.profit) /
        NULLIF(SUM(f.sales),0),
        4
    ) AS profit_margin

FROM fact_sales f

JOIN dim_location l
    ON f.location_key = l.location_key

GROUP BY

    l.region,
    l.state,
    l.city_type,
    l.outlet_type;
