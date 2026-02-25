CREATE TABLE retail_schema.dim_customer (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    segment VARCHAR(50)
);

CREATE TABLE retail_schema.dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE retail_schema.dim_date (
    date_id DATE PRIMARY KEY,
    year INT,
    quarter INT,
    month INT,
    day INT
);

CREATE TABLE retail_schema.fact_sales (
    sales_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    date_id DATE,
    quantity INT,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id) REFERENCES retail_schema.dim_customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES retail_schema.dim_product(product_id),
    FOREIGN KEY (date_id) REFERENCES retail_schema.dim_date(date_id)
);
