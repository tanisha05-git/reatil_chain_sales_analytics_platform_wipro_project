-- Indexes
CREATE INDEX idx_sales_date 
ON retail_schema.fact_sales(date_id);

CREATE INDEX idx_sales_customer 
ON retail_schema.fact_sales(customer_id);

-- Partition Example
CREATE TABLE retail_schema.fact_sales_partitioned (
    sales_id INT,
    customer_id INT,
    product_id INT,
    date_id DATE,
    quantity INT,
    total_amount DECIMAL(10,2)
)
PARTITION BY RANGE (YEAR(date_id));
