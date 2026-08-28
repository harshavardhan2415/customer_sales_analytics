USE customer_sales_analytics;

DROP TABLE IF EXISTS dim_customer;

CREATE TABLE dim_customer
(
    customer_key BIGINT AUTO_INCREMENT PRIMARY KEY,

    customer_id VARCHAR(30) NOT NULL,

    customer_name VARCHAR(100),

    last_name VARCHAR(100),

    date_of_birth DATE,

    segment VARCHAR(50),

    customer_age INT,

    customer_status VARCHAR(30),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE KEY uk_customer_id(customer_id)
);



INSERT INTO dim_customer
(
customer_id,
customer_name,
last_name,
date_of_birth,
segment,
customer_age,
customer_status
)
SELECT DISTINCT
customer_id,
customer_name,
last_name,
STR_TO_DATE(date_of_birth,'%Y-%m-%d'),
segment,
TIMESTAMPDIFF(YEAR,STR_TO_DATE(date_of_birth,'%Y-%m-%d'),CURDATE()),
CASE
WHEN TIMESTAMPDIFF(YEAR,STR_TO_DATE(date_of_birth,'%Y-%m-%d'),CURDATE()) >= 60 THEN 'Senior'
WHEN TIMESTAMPDIFF(YEAR,STR_TO_DATE(date_of_birth,'%Y-%m-%d'),CURDATE()) >= 40 THEN 'Middle Age'
ELSE 'Young Adult'
END
FROM stg_customer_sales
WHERE customer_id IS NOT NULL
AND customer_id <> '';
