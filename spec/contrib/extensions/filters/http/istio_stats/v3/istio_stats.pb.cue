package v3

#MetricType: "COUNTER" | "GAUGE" | "HISTOGRAM"

MetricType_COUNTER:   "COUNTER"
MetricType_GAUGE:     "GAUGE"
MetricType_HISTOGRAM: "HISTOGRAM"

// Specifies the proxy deployment type.
#Reporter: "UNSPECIFIED" | "SERVER_GATEWAY"

Reporter_UNSPECIFIED:    "UNSPECIFIED"
Reporter_SERVER_GATEWAY: "SERVER_GATEWAY"

// Metric instance configuration overrides.
// The metric value and the metric type are optional and permit changing the
// reported value for an existing metric.
// The standard metrics are optimized and reported through a "fast-path".
// The customizations allow full configurability, at the cost of a "slower"
// path.
// [#next-free-field: 6]
#MetricConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.istio_stats.v3.MetricConfig"
	// (Optional) Collection of tag names and tag expressions to include in the
	// metric. Conflicts are resolved by the tag name by overriding previously
	// supplied values.
	dimensions?: [string]: string
	// (Optional) Metric name to restrict the override to a metric. If not
	// specified, applies to all.
	name?: string
	// (Optional) A list of tags to remove.
	tags_to_remove?: [...string]
	// NOT IMPLEMENTED. (Optional) Conditional enabling the override.
	match?: string
	// (Optional) If this is set to true, the metric(s) selected by this
	// configuration will not be generated or reported.
	drop?: bool
}

#MetricDefinition: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.istio_stats.v3.MetricDefinition"
	// Metric name.
	name?: string
	// Metric value expression.
	value?: string
	// Metric type.
	type?: #MetricType
}

// [#next-free-field: 13]
#PluginConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.istio_stats.v3.PluginConfig"
	// Optional: Disable using host header as a fallback if destination service is
	// not available from the control plane. Disable the fallback if the host
	// header originates outsides the mesh, like at ingress.
	disable_host_header_fallback?: bool
	// Optional. Allows configuration of the time between calls out to for TCP
	// metrics reporting. The default duration is “5s“.
	tcp_reporting_duration?: string
	// Metric overrides.
	metrics?: [...#MetricConfig]
	// Metric definitions.
	definitions?: [...#MetricDefinition]
	// Proxy deployment type.
	reporter?: #Reporter
	// Metric scope rotation interval. Set to 0 to disable the metric scope rotation.
	// Defaults to 0.
	// DEPRECATED.
	rotation_interval?: string
	// Metric expiry graceful deletion interval. No-op if the metric rotation is disabled.
	// Defaults to 5m. Must be >=1s.
	// DEPRECATED.
	graceful_deletion_interval?: string
}
