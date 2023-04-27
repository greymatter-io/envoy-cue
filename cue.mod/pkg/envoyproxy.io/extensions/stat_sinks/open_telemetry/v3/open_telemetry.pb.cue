package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// [#next-free-field: 6]
#SinkConfig: {
	"@type": "type.googleapis.com/envoy.extensions.stat_sinks.open_telemetry.v3.SinkConfig"
	// The upstream gRPC cluster that implements the OTLP/gRPC collector.
	grpc_service?: v3.#GrpcService
	// If set to true, counters will be emitted as deltas, and the OTLP message will have
	// ``AGGREGATION_TEMPORALITY_DELTA`` set as AggregationTemporality.
	report_counters_as_deltas?: bool
	// If set to true, histograms will be emitted as deltas, and the OTLP message will have
	// ``AGGREGATION_TEMPORALITY_DELTA`` set as AggregationTemporality.
	report_histograms_as_deltas?: bool
	// If set to true, metrics will have their tags emitted as OTLP attributes, which may
	// contain values used by the tag extractor or additional tags added during stats creation.
	// Otherwise, no attributes will be associated with the export message. Default value is true.
	emit_tags_as_attributes?: bool
	// If set to true, metric names will be represented as the tag extracted name instead
	// of the full metric name. Default value is true.
	use_tag_extracted_name?: bool
}
