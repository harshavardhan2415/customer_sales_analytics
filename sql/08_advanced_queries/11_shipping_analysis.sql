USE customer_sales_analytics;

SELECT

    f.ship_mode,

    COUNT(DISTINCT f.order_id)
        AS total_orders,

    AVG(
        DATEDIFF(
            ship.full_date,
            ord.full_date
        )
    ) AS average_shipping_days,

    MIN(
        DATEDIFF(
            ship.full_date,
            ord.full_date
        )
    ) AS minimum_shipping_days,

    MAX(
        DATEDIFF(
            ship.full_date,
            ord.full_date
        )
    ) AS maximum_shipping_days,

    SUM(
        CASE

            WHEN DATEDIFF(
                ship.full_date,
                ord.full_date
            ) > 5

            THEN 1

            ELSE 0

        END
    ) AS delayed_orders

FROM fact_sales f

JOIN dim_date ord
    ON f.order_date_key = ord.date_key

JOIN dim_date ship
    ON f.ship_date_key = ship.date_key

GROUP BY f.ship_mode

ORDER BY average_shipping_days;
