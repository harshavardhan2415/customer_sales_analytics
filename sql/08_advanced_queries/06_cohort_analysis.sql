USE customer_sales_analytics;

WITH customer_first_purchase AS
(
    SELECT

        customer_key,

        MIN(sales_date_key)
            AS first_purchase_key

    FROM fact_sales

    GROUP BY customer_key
),

customer_cohort AS
(
    SELECT

        customer_key,

        DATE_FORMAT(
            STR_TO_DATE(
                first_purchase_key,
                '%Y%m%d'
            ),
            '%Y-%m'
        ) AS cohort_month

    FROM customer_first_purchase
)

SELECT

    cc.cohort_month,

    COUNT(DISTINCT cc.customer_key)
        AS customers

FROM customer_cohort cc

GROUP BY cc.cohort_month

ORDER BY cc.cohort_month;


For a larger dataset, we can make this into a complete cohort retention matrix later.
