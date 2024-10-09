package v3

import (
	v3 "envoyproxy.io/config/core/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// gRPC statistics filter configuration
// [#next-free-field: 6]
#FilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.grpc_stats.v3.FilterConfig"
	// If true, the filter maintains a filter state object with the request and response message
	// counts.
	emit_filter_state?: bool
	// If set, specifies an allowlist of service/methods that will have individual stats
	// emitted for them. Any call that does not match the allowlist will be counted
	// in a stat with no method specifier: “cluster.<name>.grpc.*“.
	individual_method_stats_allowlist?: v3.#GrpcMethodList
	// If set to true, emit stats for all service/method names.
	//
	// If set to false, emit stats for all service/message types to the same stats without including
	// the service/method in the name, with prefix “cluster.<name>.grpc“. This can be useful if
	// service/method granularity is not needed, or if each cluster only receives a single method.
	//
	// .. attention::
	//
	//	This option is only safe if all clients are trusted. If this option is enabled
	//	with untrusted clients, the clients could cause unbounded growth in the number of stats in
	//	Envoy, using unbounded memory and potentially slowing down stats pipelines.
	//
	// .. attention::
	//
	//	If neither ``individual_method_stats_allowlist`` nor ``stats_for_all_methods`` is set, the
	//	behavior will default to ``stats_for_all_methods=false``.
	stats_for_all_methods?: wrapperspb.#BoolValue
	// If true, the filter will gather a histogram for the request time of the upstream.
	// It works with :ref:`stats_for_all_methods
	// <envoy_v3_api_field_extensions.filters.http.grpc_stats.v3.FilterConfig.stats_for_all_methods>`
	// and :ref:`individual_method_stats_allowlist
	// <envoy_v3_api_field_extensions.filters.http.grpc_stats.v3.FilterConfig.individual_method_stats_allowlist>` the same way
	// request_message_count and response_message_count works.
	enable_upstream_stats?: bool
	// If true, the filter will replace dots in the grpc_service_name with underscores before emitting
	// the metrics. Only works when :ref:`stats_for_all_methods
	// <envoy_v3_api_field_extensions.filters.http.grpc_stats.v3.FilterConfig.stats_for_all_methods>`
	// is set to true. It could cause metrics to be merged if the edited service name conflicts with
	// an existing service. For example there are both service "foo.bar" & "foo_bar" running.
	// This config can fix incorrect gRPC metrics with dots because the existing stats tag extractor
	// assumes no dots in the gRPC service name. By default this is set as false.
	replace_dots_in_grpc_service_name?: bool
}

// gRPC statistics filter state object in protobuf form.
#FilterObject: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.grpc_stats.v3.FilterObject"
	// Count of request messages in the request stream.
	request_message_count?: uint64
	// Count of response messages in the response stream.
	response_message_count?: uint64
}
