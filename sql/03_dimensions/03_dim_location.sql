USE customer_sales_analytics;

DROP TABLE IF EXISTS dim_location;

CREATE TABLE dim_location
(
    location_key BIGINT AUTO_INCREMENT PRIMARY KEY,

    region VARCHAR(50),

    country VARCHAR(100),

    state VARCHAR(100),

    postal_code VARCHAR(20),

    city_type VARCHAR(50),

    outlet_type VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO dim_location
(
    region,
    country,
    state,
    postal_code,
    city_type,
    outlet_type
)

SELECT DISTINCT

    region,
    country,
    state,
    postal_code,
    city_type,
    outlet_type

FROM stg_customer_sales;
