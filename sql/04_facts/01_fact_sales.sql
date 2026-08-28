USE customer_sales_analytics;

DROP TABLE IF EXISTS fact_sales;

CREATE TABLE fact_sales
(
    sales_key BIGINT AUTO_INCREMENT PRIMARY KEY,

    customer_key BIGINT NOT NULL,

    product_key BIGINT NOT NULL,

    location_key BIGINT NOT NULL,

    sales_date_key INT,

    order_date_key INT,

    ship_date_key INT,

    order_id VARCHAR(30) NOT NULL,

    sales DECIMAL(18,2),

    quantity INT,

    discount DECIMAL(10,4),

    profit DECIMAL(18,2),

    ship_mode VARCHAR(50),

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_customer

        FOREIGN KEY(customer_key)

        REFERENCES dim_customer(customer_key),

    CONSTRAINT fk_product

        FOREIGN KEY(product_key)

        REFERENCES dim_product(product_key),

    CONSTRAINT fk_location

        FOREIGN KEY(location_key)

        REFERENCES dim_location(location_key),

    CONSTRAINT fk_sales_date

        FOREIGN KEY(sales_date_key)

        REFERENCES dim_date(date_key),

    CONSTRAINT fk_order_date

        FOREIGN KEY(order_date_key)

        REFERENCES dim_date(date_key),

    CONSTRAINT fk_ship_date

        FOREIGN KEY(ship_date_key)

        REFERENCES dim_date(date_key)
);


Insert:

INSERT INTO fact_sales
(
    customer_key,
    product_key,
    location_key,

    sales_date_key,
    order_date_key,
    ship_date_key,

    order_id,

    sales,
    quantity,
    discount,
    profit,

    ship_mode
)

SELECT

    c.customer_key,

    p.product_key,

    l.location_key,

    CAST(
        DATE_FORMAT(
            STR_TO_DATE(
                s.sales_date,
                '%d-%m-%Y'
            ),
            '%Y%m%d'
        )
        AS UNSIGNED
    ),

    CAST(
        DATE_FORMAT(
            STR_TO_DATE(
                s.order_date,
                '%d-%m-%Y'
            ),
            '%Y%m%d'
        )
        AS UNSIGNED
    ),

    CAST(
        DATE_FORMAT(
            STR_TO_DATE(
                s.ship_date,
                '%d-%m-%Y'
            ),
            '%Y%m%d'
        )
        AS UNSIGNED
    ),

    s.order_id,

    s.sales,

    s.quantity,

    s.discount,

    s.profit,

    s.ship_mode

FROM stg_customer_sales s

JOIN dim_customer c
    ON s.customer_id = c.customer_id

JOIN dim_product p
    ON s.product_id = p.product_id

JOIN dim_location l

    ON s.region <=> l.region

    AND s.country <=> l.country

    AND s.state <=> l.state

    AND s.postal_code <=> l.postal_code

    AND s.city_type <=> l.city_type

    AND s.outlet_type <=> l.outlet_type;
