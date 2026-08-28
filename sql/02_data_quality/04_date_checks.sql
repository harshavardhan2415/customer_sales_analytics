USE customer_sales_analytics;

SELECT
    staging_id,
    customer_id,
    order_id,

    sales_date,
    order_date,
    ship_date,

    STR_TO_DATE(
        sales_date,
        '%Y-%m-%d'
    ) AS parsed_sales_date,

    STR_TO_DATE(
        order_date,
        '%Y-%m-%d'
    ) AS parsed_order_date,

    STR_TO_DATE(
        ship_date,
        '%Y-%m-%d'
    ) AS parsed_ship_date

FROM stg_customer_sales;


SELECT
    staging_id,
    order_id,
    order_date,
    ship_date

FROM stg_customer_sales

WHERE STR_TO_DATE(
          ship_date,
          '%Y-%m-%d'
      )
      <
      STR_TO_DATE(
          order_date,
          '%Y-%m-%d'
      );

// Sales year mismatch


SELECT COUNT(*) AS mismatch_count
FROM stg_customer_sales
WHERE sales_year <>
      YEAR(STR_TO_DATE(sales_date, '%Y-%m-%d'));

ALTER TABLE stg_customer_sales
DROP COLUMN sales_year;
// Invalid DOB

SELECT *
FROM stg_customer_sales

WHERE STR_TO_DATE(
          date_of_birth,
          '%Y-%m-%d'
      ) IS NULL;

ALTER TABLE stg_customer_sales
DROP COLUMN sales_year;

describe stg_customer_sales;