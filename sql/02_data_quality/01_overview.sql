USE customer_sales_analytics;

SELECT
    COUNT(*) AS total_records,

    COUNT(DISTINCT customer_id) AS unique_customers,

    COUNT(DISTINCT order_id) AS unique_orders,

    COUNT(DISTINCT product_id) AS unique_products,

    COUNT(DISTINCT state) AS unique_states,

    COUNT(DISTINCT region) AS unique_regions

FROM stg_customer_sales;
