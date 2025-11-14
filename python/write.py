import calendar
from datetime import datetime

import requests
import snappy

from prometheus_pb2 import WriteRequest


def dt2ts(dt):
    """Converts a datetime object to UTC timestamp
    naive datetime will be considered UTC.
    """
    return calendar.timegm(dt.utctimetuple())


def send(write_request, url="http://localhost:9090/api/v1/write"):
    uncompressed = write_request.SerializeToString()
    compressed = snappy.compress(uncompressed)

    headers = {
        "Content-Encoding": "snappy",
        "Content-Type": "application/x-protobuf",
        "X-Prometheus-Remote-Write-Version": "0.1.0",
        "User-Agent": "metrics-worker"
    }
    try:
        response = requests.post(url, headers=headers, data=compressed)
        print(response.status_code, response.text)
    except Exception as e:
        print(e)


def add_metric(write_request, name: str, labels: dict, value: float, timestamp: int = None):
    series = write_request.timeseries.add()

    # name label always required
    label = series.labels.add()
    label.name = "__name__"
    label.value = name

    for label_name, label_value in labels.items():
        label = series.labels.add()
        label.name = label_name
        label.value = label_value

    sample = series.samples.add()
    sample.value = value

    print(datetime.utcnow())
    print(dt2ts(datetime.utcnow()))
    print(dt2ts(datetime.utcnow()) * 1000)
    print(timestamp)

    sample.timestamp = timestamp or (dt2ts(datetime.utcnow()) * 1000)


def write():
    write_request = WriteRequest()
    # Create as many of these
    add_metric(write_request, "my_metric", {"label1": "value1", "label2": "value2"}, 18)
    add_metric(write_request, "my_metric", {"label1": "value3", "label2": "value4"}, 19, 1763124831000)
    # Send to remote write endpoint
    send(write_request)


write()
