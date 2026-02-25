from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("RetailBatchProcessing") \
    .getOrCreate()

df = spark.read.csv(
    "../data/raw/sales.csv",
    header=True,
    inferSchema=True
)

df_grouped = df.groupBy("product_id") \
               .sum("quantity")

df_grouped.write \
    .mode("overwrite") \
    .parquet("../data/processed/product_sales")

spark.stop()
