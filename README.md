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

[1]: https://prometheus.io/
[2]: https://prometheus.io/docs/introduction/overview/
[3]: https://prometheus.io/docs/specs/prw/remote_write_spec/
[4]: https://prometheus.io/docs/instrumenting/pushing/
[5]: https://github.com/jzakhar
[6]: https://gist.github.com/jzakhar/c61aaa64eacc6f048223902de04d1ffa
