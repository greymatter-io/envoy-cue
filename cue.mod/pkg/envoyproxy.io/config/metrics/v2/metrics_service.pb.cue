package v2

import (
	core "envoyproxy.io/api/v2/core"
)

// Metrics Service is configured as a built-in *envoy.stat_sinks.metrics_service* :ref:`StatsSink
// <envoy_api_msg_config.metrics.v2.StatsSink>`. This opaque configuration will be used to create
// Metrics Service.
// [#extension: envoy.stat_sinks.metrics_service]
#MetricsServiceConfig: {
	"@type": "type.googleapis.com/envoy.config.metrics.v2.MetricsServiceConfig"
	// The upstream gRPC cluster that hosts the metrics service.
	grpc_service?: core.#GrpcService
}
