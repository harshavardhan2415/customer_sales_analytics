USE customer_sales_analytics;

DROP PROCEDURE IF EXISTS sp_sales_summary;

DELIMITER $$

CREATE PROCEDURE sp_sales_summary
(
    IN p_start_date DATE,
    IN p_end_date DATE
)

BEGIN

    SELECT

        COUNT(DISTINCT f.order_id)
            AS total_orders,

        COUNT(DISTINCT f.customer_key)
            AS total_customers,

        SUM(f.quantity)
            AS total_quantity,

        SUM(f.sales)
            AS total_sales,

        SUM(f.profit)
            AS total_profit,

        ROUND(
            SUM(f.profit) /
            NULLIF(SUM(f.sales),0),
            4
        ) AS profit_margin

    FROM fact_sales f

    JOIN dim_date d
        ON f.sales_date_key = d.date_key

    WHERE d.full_date
        BETWEEN p_start_date
        AND p_end_date;

END$$

DELIMITER ;


Example:

CALL sp_sales_summary(
    '2023-01-01',
    '2023-12-31'
);
