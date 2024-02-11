  -- External table
CREATE OR REPLACE EXTERNAL TABLE
  `terraform-demo-412921.ny_taxi.external_green_tripdata` OPTIONS( format = 'PARQUET',
    uris = ['gs://dwh-zoomcamp-week3/green_tripdata_2022-*.parquet'] );

  -- Materialzed table
CREATE OR REPLACE TABLE
  terraform-demo-412921.ny_taxi.green_tripdata AS
SELECT
  *
FROM
  terraform-demo-412921.ny_taxi.external_green_tripdata;


  -- Question 1
SELECT
  COUNT(*)
FROM
  `ny_taxi.external_green_tripdata`;


  -- Question 2
SELECT
  COUNT(DISTINCT PULocationID) external_PULocationID
FROM
  `terraform-demo-412921.ny_taxi.external_green_tripdata`;

  
SELECT
  COUNT(DISTINCT PULocationID) Materilaized_PULocationID
FROM
  `terraform-demo-412921.ny_taxi.green_tripdata`;


  -- Question 3
SELECT
  COUNT(*)
FROM
  terraform-demo-412921.ny_taxi.green_tripdata
WHERE
  fare_amount = 0;


  -- Question 4
CREATE OR REPLACE TABLE
  terraform-demo-412921.ny_taxi.green_tripdata_partitioned_clustered
PARTITION BY
  DATE(lpep_pickup_datetime)
CLUSTER BY
  (PUlocationID) AS
SELECT
  *
FROM
  `terraform-demo-412921.ny_taxi.external_green_tripdata`;


  -- Question 5
  -- Non partitioned (materialized)
SELECT
  COUNT(DISTINCT PULocationID) Materilaized_PULocationID
FROM
  `terraform-demo-412921.ny_taxi.green_tripdata`
WHERE
  DATE(lpep_pickup_datetime) BETWEEN '2022-06-01'
  AND '2022-06-30';

  -- Partitioned_clustered
SELECT
  COUNT(DISTINCT PULocationID) partitioned_PULocationID
FROM
  `terraform-demo-412921.ny_taxi.green_tripdata_partitioned_clustered`
WHERE
  DATE(lpep_pickup_datetime) BETWEEN '2022-06-01'
  AND '2022-06-30';
