import pandas as pd
import sqlalchemy
import yaml

# Load config
with open("../config/config.yaml") as f:
    config = yaml.safe_load(f)

engine = sqlalchemy.create_engine(config["database_url"])

def extract():
    sales = pd.read_csv("../data/raw/sales.csv")
    customers = pd.read_csv("../data/raw/customers.csv")
    products = pd.read_csv("../data/raw/products.csv")
    return sales, customers, products

def transform(sales):
    sales['total_amount'] = sales['quantity'] * sales['price']
    sales.drop_duplicates(inplace=True)
    return sales

def load(df, table_name):
    df.to_sql(table_name, engine, if_exists='append', index=False)

if __name__ == "__main__":
    sales, customers, products = extract()
    sales = transform(sales)

    load(customers, "dim_customer")
    load(products, "dim_product")
    load(sales, "fact_sales")
