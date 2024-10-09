package v2

import (
	_go "envoyproxy.io/deps/prometheus/client_model/go"
	core "envoyproxy.io/api/v2/core"
)

#StreamMetricsResponse: {
	"@type": "type.googleapis.com/envoy.service.metrics.v2.StreamMetricsResponse"
}

#StreamMetricsMessage: {
	"@type": "type.googleapis.com/envoy.service.metrics.v2.StreamMetricsMessage"
	// Identifier data effectively is a structured metadata. As a performance optimization this will
	// only be sent in the first message on the stream.
	identifier?: #StreamMetricsMessage_Identifier
	// A list of metric entries
	envoy_metrics?: [..._go.#MetricFamily]
}

#StreamMetricsMessage_Identifier: {
	"@type": "type.googleapis.com/envoy.service.metrics.v2.StreamMetricsMessage_Identifier"
	// The node sending metrics over the stream.
	node?: core.#Node
}
