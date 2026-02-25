ALTER TABLE retail_schema.fact_sales
CLUSTER BY (date_id);

-- Time Travel Query
SELECT * 
FROM retail_schema.fact_sales 
AT (TIMESTAMP => '2026-02-01 10:00:00');
