USE customer_sales_analytics;

CREATE INDEX idx_fact_customer
ON fact_sales(customer_key);

CREATE INDEX idx_fact_product
ON fact_sales(product_key);

CREATE INDEX idx_fact_location
ON fact_sales(location_key);

CREATE INDEX idx_fact_sales_date
ON fact_sales(sales_date_key);

CREATE INDEX idx_fact_order_date
ON fact_sales(order_date_key);

CREATE INDEX idx_fact_ship_date
ON fact_sales(ship_date_key);

CREATE INDEX idx_fact_order_id
ON fact_sales(order_id);

CREATE INDEX idx_customer_segment
ON dim_customer(segment);

CREATE INDEX idx_product_category
ON dim_product(category_of_goods);

CREATE INDEX idx_product_subcategory
ON dim_product(sub_category);

CREATE INDEX idx_location_region
ON dim_location(region);

CREATE INDEX idx_location_state
ON dim_location(state);
