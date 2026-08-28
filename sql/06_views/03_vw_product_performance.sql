USE customer_sales_analytics;

CREATE OR REPLACE VIEW vw_product_performance AS

SELECT

    p.product_id,

    p.product_name,

    p.sub_category,

    p.category_of_goods,

    COUNT(DISTINCT f.order_id)
        AS total_orders,

    SUM(f.quantity)
        AS units_sold,

    SUM(f.sales)
        AS total_sales,

    SUM(f.profit)
        AS total_profit,

    AVG(f.discount)
        AS average_discount,

    ROUND(
        SUM(f.profit) /
        NULLIF(SUM(f.sales),0),
        4
    ) AS profit_margin

FROM dim_product p

LEFT JOIN fact_sales f
    ON p.product_key = f.product_key

GROUP BY

    p.product_id,
    p.product_name,
    p.sub_category,
    p.category_of_goods;
