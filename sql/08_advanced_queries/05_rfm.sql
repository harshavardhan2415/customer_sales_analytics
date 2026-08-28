USE customer_sales_analytics;

WITH customer_metrics AS
(
    SELECT

        c.customer_id,

        MAX(d.full_date)
            AS last_purchase_date,

        COUNT(DISTINCT f.order_id)
            AS frequency,

        SUM(f.sales)
            AS monetary

    FROM fact_sales f

    JOIN dim_customer c
        ON f.customer_key = c.customer_key

    JOIN dim_date d
        ON f.sales_date_key = d.date_key

    GROUP BY
        c.customer_id
),

rfm AS
(
    SELECT

        customer_id,

        DATEDIFF(
            (SELECT MAX(full_date)
             FROM dim_date),

            last_purchase_date
        ) AS recency,

        frequency,

        monetary

    FROM customer_metrics
),

scores AS
(
    SELECT

        *,

        NTILE(5) OVER
        (
            ORDER BY recency DESC
        ) AS r_score,

        NTILE(5) OVER
        (
            ORDER BY frequency
        ) AS f_score,

        NTILE(5) OVER
        (
            ORDER BY monetary
        ) AS m_score

    FROM rfm
)

SELECT

    customer_id,

    recency,

    frequency,

    monetary,

    r_score,

    f_score,

    m_score,

    CONCAT(
        r_score,
        f_score,
        m_score
    ) AS rfm_score,

    CASE

        WHEN r_score >= 4
         AND f_score >= 4
         AND m_score >= 4
            THEN 'Champions'

        WHEN r_score >= 3
         AND f_score >= 3
         AND m_score >= 3
            THEN 'Loyal Customers'

        WHEN r_score >= 4
         AND f_score <= 2
            THEN 'Potential Customers'

        WHEN r_score <= 2
         AND f_score >= 3
            THEN 'At Risk'

        ELSE 'Needs Attention'

    END AS customer_segment

FROM scores

ORDER BY monetary DESC;
