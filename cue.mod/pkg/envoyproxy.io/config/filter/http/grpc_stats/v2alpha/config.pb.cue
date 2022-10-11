package v2alpha

import (
	core "envoyproxy.io/api/v2/core"
)

// gRPC statistics filter configuration
#FilterConfig: {
	"@type": "type.googleapis.com/envoy.config.filter.http.grpc_stats.v2alpha.FilterConfig"
	// If true, the filter maintains a filter state object with the request and response message
	// counts.
	emit_filter_state?: bool
	// If set, specifies an allowlist of service/methods that will have individual stats
	// emitted for them. Any call that does not match the allowlist will be counted
	// in a stat with no method specifier: `cluster.<name>.grpc.*`.
	individual_method_stats_allowlist?: core.#GrpcMethodList
	// If set to true, emit stats for all service/method names.
	//
	// If set to false, emit stats for all service/message types to the same stats without including
	// the service/method in the name, with prefix `cluster.<name>.grpc`. This can be useful if
	// service/method granularity is not needed, or if each cluster only receives a single method.
	//
	// .. attention::
	//   This option is only safe if all clients are trusted. If this option is enabled
	//   with untrusted clients, the clients could cause unbounded growth in the number of stats in
	//   Envoy, using unbounded memory and potentially slowing down stats pipelines.
	//
	// .. attention::
	//   If neither `individual_method_stats_allowlist` nor `stats_for_all_methods` is set, the
	//   behavior will default to `stats_for_all_methods=false`. This default value is changed due
	//   to the previous value being deprecated. This behavior can be changed with runtime override
	//   `envoy.deprecated_features.grpc_stats_filter_enable_stats_for_all_methods_by_default`.
	stats_for_all_methods?: bool
}

// gRPC statistics filter state object in protobuf form.
#FilterObject: {
	"@type": "type.googleapis.com/envoy.config.filter.http.grpc_stats.v2alpha.FilterObject"
	// Count of request messages in the request stream.
	request_message_count?: uint64
	// Count of response messages in the response stream.
	response_message_count?: uint64
}
