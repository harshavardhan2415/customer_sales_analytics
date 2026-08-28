USE customer_sales_analytics;

DROP TABLE IF EXISTS dim_product;

CREATE TABLE dim_product
(
    product_key BIGINT AUTO_INCREMENT PRIMARY KEY,

    product_id VARCHAR(30) NOT NULL,

    product_name VARCHAR(255),

    sub_category VARCHAR(100),

    category_of_goods VARCHAR(100),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE KEY uk_product_id(product_id)
);

INSERT INTO dim_product
(
    product_id,
    product_name,
    sub_category,
    category_of_goods
)

SELECT DISTINCT

    product_id,
    product_name,
    sub_category,
    category_of_goods

FROM stg_customer_sales

WHERE product_id IS NOT NULL
AND product_id <> '';
