USE customer_sales_analytics;
DROP PROCEDURE IF EXISTS sp_rfm_analysis;
DELIMITER $$
CREATE PROCEDURE sp_rfm_analysis()
BEGIN
WITH customer_metrics AS
(
SELECT
c.customer_id,
MAX(d.full_date) AS last_purchase_date,
COUNT(DISTINCT f.order_id) AS frequency,
SUM(f.sales) AS monetary
FROM fact_sales f
JOIN dim_customer c ON f.customer_key=c.customer_key
JOIN dim_date d ON f.sales_date_key=d.date_key
GROUP BY c.customer_id
),
rfm AS
(
SELECT
customer_id,
DATEDIFF((SELECT MAX(full_date) FROM dim_date),last_purchase_date) AS recency,
frequency,
monetary
FROM customer_metrics
)
SELECT
customer_id,
recency,
frequency,
monetary,
NTILE(5) OVER(ORDER BY recency DESC) AS recency_score,
NTILE(5) OVER(ORDER BY frequency) AS frequency_score,
NTILE(5) OVER(ORDER BY monetary) AS monetary_score
FROM rfm;
END$$
DELIMITER ;