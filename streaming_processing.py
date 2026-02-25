from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("RetailStreaming") \
    .getOrCreate()

schema = spark.read.csv(
    "../data/raw/sales.csv",
    header=True,
    inferSchema=True
).schema

df_stream = spark.readStream \
    .format("csv") \
    .option("header", True) \
    .schema(schema) \
    .load("../data/raw/")

query = df_stream.groupBy("product_id") \
    .sum("quantity") \
    .writeStream \
    .outputMode("complete") \
    .format("console") \
    .start()

query.awaitTermination()
