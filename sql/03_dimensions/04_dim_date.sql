USE customer_sales_analytics;

DROP TABLE IF EXISTS dim_date;

CREATE TABLE dim_date
(
    date_key INT PRIMARY KEY,

    full_date DATE NOT NULL,

    day_number INT,

    day_name VARCHAR(20),

    week_number INT,

    month_number INT,

    month_name VARCHAR(20),

    quarter_number INT,

    quarter_name VARCHAR(10),

    year_number INT,

    is_weekend BOOLEAN
);


Generate calendar:

SET SESSION cte_max_recursion_depth = 10000;

WITH RECURSIVE dates AS
(
    SELECT DATE('2020-01-01') AS dt

    UNION ALL

    SELECT
        DATE_ADD(dt, INTERVAL 1 DAY)

    FROM dates

    WHERE dt < '2025-12-31'
)

INSERT INTO dim_date
(
    date_key,
    full_date,
    day_number,
    day_name,
    week_number,
    month_number,
    month_name,
    quarter_number,
    quarter_name,
    year_number,
    is_weekend
)

SELECT

    CAST(
        DATE_FORMAT(dt, '%Y%m%d')
        AS UNSIGNED
    ),

    dt,

    DAY(dt),

    DAYNAME(dt),

    WEEK(dt, 3),

    MONTH(dt),

    MONTHNAME(dt),

    QUARTER(dt),

    CONCAT(
        'Q',
        QUARTER(dt)
    ),

    YEAR(dt),

    CASE

        WHEN DAYOFWEEK(dt) IN (1,7)
        THEN TRUE

        ELSE FALSE

    END

FROM dates;
