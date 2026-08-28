USE customer_sales_analytics;

WITH daily_sales AS
(
    SELECT

        d.full_date,

        SUM(f.sales)
            AS daily_sales

    FROM fact_sales f

    JOIN dim_date d
        ON f.sales_date_key = d.date_key

    GROUP BY d.full_date
),

statistics AS
(
    SELECT

        AVG(daily_sales)
            AS average_sales,

        STDDEV_POP(daily_sales)
            AS standard_deviation

    FROM daily_sales
)

SELECT

    ds.full_date,

    ds.daily_sales,

    ROUND(

        (
            ds.daily_sales
            - s.average_sales
        )
        /
        NULLIF(
            s.standard_deviation,
            0
        ),

        2

    ) AS z_score,

    CASE

        WHEN ABS(
            (
                ds.daily_sales
                - s.average_sales
            )
            /
            NULLIF(
                s.standard_deviation,
                0
            )
        ) >= 3

        THEN 'Extreme Anomaly'

        WHEN ABS(
            (
                ds.daily_sales
                - s.average_sales
            )
            /
            NULLIF(
                s.standard_deviation,
                0
            )
        ) >= 2

        THEN 'Potential Anomaly'

        ELSE 'Normal'

    END AS anomaly_status

FROM daily_sales ds

CROSS JOIN statistics s

ORDER BY ABS(z_score) DESC;
