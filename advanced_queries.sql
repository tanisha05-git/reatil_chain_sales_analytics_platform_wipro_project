-- Monthly Revenue with Growth
WITH monthly_sales AS (
    SELECT 
        d.year,
        d.month,
        SUM(f.total_amount) AS revenue
    FROM retail_schema.fact_sales f
    JOIN retail_schema.dim_date d 
        ON f.date_id = d.date_id
    GROUP BY d.year, d.month
)

SELECT *,
       LAG(revenue) OVER (ORDER BY year, month) AS prev_month_revenue,
       revenue - LAG(revenue) OVER (ORDER BY year, month) AS growth
FROM monthly_sales;


-- Top 5 Customers per State
SELECT *
FROM (
    SELECT 
        c.state,
        c.name,
        SUM(f.total_amount) AS total_spent,
        RANK() OVER (
            PARTITION BY c.state 
            ORDER BY SUM(f.total_amount) DESC
        ) AS rnk
    FROM retail_schema.fact_sales f
    JOIN retail_schema.dim_customer c 
        ON f.customer_id = c.customer_id
    GROUP BY c.state, c.name
) t
WHERE rnk <= 5;
