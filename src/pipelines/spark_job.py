from pyspark.sql import SparkSession


def run():
    spark = SparkSession.builder.appName("demo").getOrCreate()
    df = spark.createDataFrame([(1, "a"), (2, "b")], ["id", "val"])
    df.show()
    spark.stop()
