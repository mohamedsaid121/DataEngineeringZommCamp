if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


def camel_to_snake(str):
    out = ''
    if str[-2:] == 'ID':
        str = str[:-2] +'_'+ 'id'
    if str[:2] in ['PU', 'DO']:
        str = str[:2].lower() + '_' + str[2:]
    for i in str:
        if i.isupper():
            out += '_' + i.lower()
        else:
            out += i
    return out.lstrip('_')


@transformer
def transform(data, *args, **kwargs):

    data = data[data['passenger_count'] > 0]
    data = data[data['trip_distance'] > 0]
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date

    for i, col in enumerate(data.columns):
        data.columns.values[i] = camel_to_snake(col)
    return data


@test
def test_passenger(output, *args) -> None:

    """
    Template code for testing the output of the block.
    """
    print(output.columns)
    assert output["passenger_count"].isin([0]).sum()== 0, 'Rides with zero passenger'

@test
def test_trip(output, *args) -> None:

    """
    Template code for testing the output of the block.
    """
    assert output["trip_distance"].isin([0]).sum()== 0,  'Trip with zero distance'

@test
def test_vendor(output, *args) -> None:

    """
    Template code for testing the output of the block.
    """
    assert  'vendor_id' in (output.columns),    'check vendor_id name in columns'

 

 


