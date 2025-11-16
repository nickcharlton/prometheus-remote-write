require "protobuf"
require "faraday"
require "snappy"

require_relative "./lib/prometheus.pb.rb"

def build_metric(name, labels, value, timestamp = DateTime.now)
  name_label = Prometheus::Label.new
  name_label.name = "__name__"
  name_label.value = name

  prom_labels = labels.map do |name, value|
    label = Prometheus::Label.new
    label.name = name
    label.value = value

    label
  end

  sample = Prometheus::Sample.new
  sample.value = value
  sample.timestamp = timestamp.to_i * 1000

  Prometheus::TimeSeries.new(
    labels: [name_label] + prom_labels,
    samples: [sample]
  )
end

write_request = Prometheus::WriteRequest.new
write_request.timeseries << build_metric(
  "my_metric",
  {label1: "value1", label2: "value2"},
  10
)

url = "http://localhost:9090/api/v1/write"
uncompressed = write_request.encode
compressed = Snappy.deflate(uncompressed)

headers = {
  "Content-Encoding" => "snappy",
  "Content-Type" => "application/x-protobuf",
  "X-Prometheus-Remote-Write-Version" => "0.1.0",
  "User-Agent" => "prom-remote-write-example-ruby"
}

response = Faraday.post(url, compressed, headers)

puts "#{response.status}"
