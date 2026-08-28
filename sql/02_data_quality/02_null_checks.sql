USE customer_sales_analytics;

SELECT
    COUNT(*) AS total_rows,

    SUM(customer_id IS NULL OR customer_id = '') AS missing_customer_id,

    SUM(customer_name IS NULL OR customer_name = '') AS missing_customer_name,

    SUM(date_of_birth IS NULL OR date_of_birth = '') AS missing_dob,

    SUM(sales IS NULL) AS missing_sales,

    SUM(order_id IS NULL OR order_id = '') AS missing_order_id,

    SUM(product_id IS NULL OR product_id = '') AS missing_product_id,

    SUM(product_name IS NULL OR product_name = '') AS missing_product_name,

    SUM(quantity IS NULL) AS missing_quantity,

    SUM(discount IS NULL) AS missing_discount,

    SUM(profit IS NULL) AS missing_profit

FROM stg_customer_sales;
