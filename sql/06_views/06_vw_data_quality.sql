USE customer_sales_analytics;

CREATE OR REPLACE VIEW vw_data_quality AS

SELECT

    staging_id,

    customer_id,

    order_id,

    product_id,

    sales,

    quantity,

    discount,

    profit,

    sales_year,

    sales_date,

    order_date,

    ship_date,

    CASE

        WHEN sales IS NULL
            THEN 'Missing Sales'

        WHEN sales < 0
            THEN 'Negative Sales'

        WHEN quantity IS NULL
            THEN 'Missing Quantity'

        WHEN quantity <= 0
            THEN 'Invalid Quantity'

        WHEN discount < 0
          OR discount > 1
            THEN 'Invalid Discount'

        WHEN STR_TO_DATE(
            ship_date,
            '%d-%m-%Y'
        )
        <
        STR_TO_DATE(
            order_date,
            '%d-%m-%Y'
        )
            THEN 'Invalid Shipping Date'

        WHEN sales_year <>
             YEAR(
                STR_TO_DATE(
                    sales_date,
                    '%d-%m-%Y'
                )
             )
            THEN 'Sales Year Mismatch'

        ELSE 'Valid'

    END AS quality_status

FROM stg_customer_sales;
