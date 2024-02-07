if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

import pyarrow as pa
import pyarrow.parquet as pq
import os

os.environ['GOOGLE_APPLICATION_CREDENTIALS']="/home/src/my-creds-412921-aa19f6312e09.json"
project_id = 'terraform-demo-412921'
bucket_name = 'mage-zoomcamp-week-2'
table_name = 'green_taxi_data'
root_path = f'{bucket_name}/{table_name}'
@data_exporter
def export_data(data, *args, **kwargs):
    gcs = pa.fs.GcsFileSystem()

    table = pa.Table.from_pandas(data)

    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols=['lpep_pickup_date'],
        filesystem=gcs
    )
  

