USE customer_sales_analytics;

DROP PROCEDURE IF EXISTS sp_customer_summary;

DELIMITER $$

CREATE PROCEDURE sp_customer_summary
(
    IN p_customer_id VARCHAR(30)
)

BEGIN

    SELECT

        c.customer_id,

        CONCAT(
            c.customer_name,
            ' ',
            c.last_name
        ) AS customer_name,

        c.segment,

        c.customer_age,

        COUNT(DISTINCT f.order_id)
            AS total_orders,

        SUM(f.sales)
            AS total_sales,

        SUM(f.profit)
            AS total_profit,

        SUM(f.quantity)
            AS total_quantity,

        ROUND(
            SUM(f.sales) /
            NULLIF(
                COUNT(DISTINCT f.order_id),
                0
            ),
            2
        ) AS average_order_value

    FROM dim_customer c

    LEFT JOIN fact_sales f
        ON c.customer_key = f.customer_key

    WHERE c.customer_id = p_customer_id

    GROUP BY

        c.customer_id,
        c.customer_name,
        c.last_name,
        c.segment,
        c.customer_age;

END$$

DELIMITER ;


Run:

CALL sp_customer_summary('CUST000001');
