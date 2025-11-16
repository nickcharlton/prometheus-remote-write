# Prometheus Remote Write Examples

[Prometheus][1] works very well as a monitoring and alerting toolkit, but its
[design assumes you'd be scraping metrics from an exporter][2]. For most
situations (computers, containers, cloud services, etc.), this conceptually
works fine. But there's plenty of other situations where you really can only
_push_ metrics.

Prometheus does support this through either [remote write][3] or the [push
gateway][4]. For transient jobs, the push gateway is a better approach, but
what if you can't use it? The main libraries don't support using remote write
directly, but it's easier to implement than it might first appear.

These examples come from trying to use Prometheus for telemetry data from an
internet of things/remote sensing project, where scraping just wasn't working
well.

## Python

This comes from [jzakhar][5]'s [Gist][6], with minor modifications, without 
this the Ruby implementation (which was originally needed) couldn't have been
possible.

```
$ python -m pip install -r requirements.txt
$ python write.py
```

## Ruby

The Ruby version fairly closely follows the design of the Python version. It
uses the [`protobuf` library][7] (a pure Ruby implementation of Protocol
Buffers) as it's nicer to work with (and the Google library wouldn't work).
It uses [Faraday][8] for the HTTP client mostly because
[`prometheus-api-client`][9] does.

The definitions were generated using the plugin as part of the Ruby `protobuf` 
library:

```
protoc --plugin=protoc-gen-ruby-protobuf=$(which protoc-gen-ruby) --ruby-protobuf_out=lib -I definitions definitions/prometheus.pb.rb
```

## Implementation notes

* You need the [`protobuf` tool][10] locally to compile `.proto` definitions 
  locally
* Timestamps are in millis (i.e.: unix timestamp * 1000)
* Prometheus expects the metrics being sent to be in timestamp order

[1]: https://prometheus.io/
[2]: https://prometheus.io/docs/introduction/overview/
[3]: https://prometheus.io/docs/specs/prw/remote_write_spec/
[4]: https://prometheus.io/docs/instrumenting/pushing/
[5]: https://github.com/jzakhar
[6]: https://gist.github.com/jzakhar/c61aaa64eacc6f048223902de04d1ffa
[7]: https://github.com/ruby-protobuf/protobuf
[8]: https://github.com/lostisland/faraday
[9]: https://github.com/prometheus/prometheus_api_client_ruby
[10]: http://code.google.com/p/protobuf
