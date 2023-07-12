package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Metrics Service is configured as a built-in ``envoy.stat_sinks.metrics_service`` :ref:`StatsSink
// <envoy_v3_api_msg_config.metrics.v3.StatsSink>`. This opaque configuration will be used to create
// Metrics Service.
//
// Example:
//
// .. code-block:: yaml
//
//     stats_sinks:
//       - name: envoy.stat_sinks.metrics_service
//         typed_config:
//           "@type": type.googleapis.com/envoy.config.metrics.v3.MetricsServiceConfig
//           transport_api_version: V3
//
// [#extension: envoy.stat_sinks.metrics_service]
#MetricsServiceConfig: {
	"@type": "type.googleapis.com/envoy.config.metrics.v3.MetricsServiceConfig"
	// The upstream gRPC cluster that hosts the metrics service.
	grpc_service?: v3.#GrpcService
	// API version for metric service transport protocol. This describes the metric service gRPC
	// endpoint and version of messages used on the wire.
	transport_api_version?: v3.#ApiVersion
	// If true, counters are reported as the delta between flushing intervals. Otherwise, the current
	// counter value is reported. Defaults to false.
	// Eventually (https://github.com/envoyproxy/envoy/issues/10968) if this value is not set, the
	// sink will take updates from the :ref:`MetricsResponse <envoy_v3_api_msg_service.metrics.v3.StreamMetricsResponse>`.
	report_counters_as_deltas?: bool
	// If true, metrics will have their tags emitted as labels on the metrics objects sent to the MetricsService,
	// and the tag extracted name will be used instead of the full name, which may contain values used by the tag
	// extractor or additional tags added during stats creation.
	emit_tags_as_labels?: bool
}
