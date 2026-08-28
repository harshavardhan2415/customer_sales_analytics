import csv
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="*****",
    database="customer_sales_analytics"
)

cursor = conn.cursor()

csv_path = r"****"

sql = """
INSERT INTO stg_customer_sales (
    customer_id,
    customer_name,
    last_name,
    date_of_birth,
    sales,
    sales_year,
    outlet_type,
    city_type,
    category_of_goods,
    region,
    country,
    segment,
    sales_date,
    order_id,
    order_date,
    ship_date,
    ship_mode,
    state,
    postal_code,
    product_id,
    sub_category,
    product_name,
    quantity,
    discount,
    profit
)
VALUES (
    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s
)
"""

with open(csv_path, "r", encoding="utf-8-sig", newline="") as file:
    reader = csv.reader(file)
    next(reader)  # skip header

    rows = list(reader)

cursor.executemany(sql, rows)
conn.commit()

print(f"Loaded {len(rows)} rows into stg_customer_sales")

cursor.close()
conn.close()