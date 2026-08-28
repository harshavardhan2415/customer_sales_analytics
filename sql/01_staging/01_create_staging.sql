USE customer_sales_analytics; 
 
DROP TABLE IF EXISTS stg_customer_sales; 
 
CREATE TABLE stg_customer_sales 
( 
    staging_id BIGINT AUTO_INCREMENT PRIMARY KEY, 
 
    customer_id VARCHAR(30), 
    customer_name VARCHAR(100), 
    last_name VARCHAR(100), 
    date_of_birth VARCHAR(20), 
 
    sales DECIMAL(18,2), 
    sales_year INT, 
 
    outlet_type VARCHAR(50), 
    city_type VARCHAR(50), 
    category_of_goods VARCHAR(100), 
 
    region VARCHAR(50), 
    country VARCHAR(100), 
    segment VARCHAR(50), 
 
    sales_date VARCHAR(20), 
 
    order_id VARCHAR(30), 
    order_date VARCHAR(20), 
    ship_date VARCHAR(20), 
 
    ship_mode VARCHAR(50), 
 
    state VARCHAR(100), 
    postal_code VARCHAR(20), 
 
    product_id VARCHAR(30), 
    sub_category VARCHAR(100), 
    product_name VARCHAR(255), 
 
    quantity INT, 
    discount DECIMAL(10,4), 
    profit DECIMAL(18,2), 
 
    loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);