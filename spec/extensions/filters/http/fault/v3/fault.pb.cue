package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/v3"
	v31 "envoyproxy.io/envoy-cue/spec/extensions/filters/common/fault/v3"
	v32 "envoyproxy.io/envoy-cue/spec/config/route/v3"
)

// [#next-free-field: 6]
#FaultAbort: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.fault.v3.FaultAbort"
	// HTTP status code to use to abort the HTTP request.
	http_status?: uint32
	// gRPC status code to use to abort the gRPC request.
	grpc_status?: uint32
	// Fault aborts are controlled via an HTTP header (if applicable).
	header_abort?: #FaultAbort_HeaderAbort
	// The percentage of requests/operations/connections that will be aborted with the error code
	// provided.
	percentage?: v3.#FractionalPercent
}

// [#next-free-field: 16]
#HTTPFault: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.fault.v3.HTTPFault"
	// If specified, the filter will inject delays based on the values in the
	// object.
	delay?: v31.#FaultDelay
	// If specified, the filter will abort requests based on the values in
	// the object. At least ``abort`` or ``delay`` must be specified.
	abort?: #FaultAbort
	// Specifies the name of the (destination) upstream cluster that the
	// filter should match on. Fault injection will be restricted to requests
	// bound to the specific upstream cluster.
	upstream_cluster?: string
	// Specifies a set of headers that the filter should match on. The fault
	// injection filter can be applied selectively to requests that match a set of
	// headers specified in the fault filter config. The chances of actual fault
	// injection further depend on the value of the :ref:`percentage
	// <envoy_v3_api_field_extensions.filters.http.fault.v3.FaultAbort.percentage>` field.
	// The filter will check the request's headers against all the specified
	// headers in the filter config. A match will happen if all the headers in the
	// config are present in the request with the same values (or based on
	// presence if the ``value`` field is not in the config).
	headers?: [...v32.#HeaderMatcher]
	// Faults are injected for the specified list of downstream hosts. If this
	// setting is not set, faults are injected for all downstream nodes.
	// Downstream node name is taken from :ref:`the HTTP
	// x-envoy-downstream-service-node
	// <config_http_conn_man_headers_downstream-service-node>` header and compared
	// against downstream_nodes list.
	downstream_nodes?: [...string]
	// The maximum number of faults that can be active at a single time via the configured fault
	// filter. Note that because this setting can be overridden at the route level, it's possible
	// for the number of active faults to be greater than this value (if injected via a different
	// route). If not specified, defaults to unlimited. This setting can be overridden via
	// ``runtime <config_http_filters_fault_injection_runtime>`` and any faults that are not injected
	// due to overflow will be indicated via the ``faults_overflow
	// <config_http_filters_fault_injection_stats>`` stat.
	//
	// .. attention::
	//   Like other :ref:`circuit breakers <arch_overview_circuit_break>` in Envoy, this is a fuzzy
	//   limit. It's possible for the number of active faults to rise slightly above the configured
	//   amount due to the implementation details.
	max_active_faults?: uint32
	// The response rate limit to be applied to the response body of the stream. When configured,
	// the percentage can be overridden by the :ref:`fault.http.rate_limit.response_percent
	// <config_http_filters_fault_injection_runtime>` runtime key.
	//
	// .. attention::
	//  This is a per-stream limit versus a connection level limit. This means that concurrent streams
	//  will each get an independent limit.
	response_rate_limit?: v31.#FaultRateLimit
	// The runtime key to override the :ref:`default <config_http_filters_fault_injection_runtime>`
	// runtime. The default is: fault.http.delay.fixed_delay_percent
	delay_percent_runtime?: string
	// The runtime key to override the :ref:`default <config_http_filters_fault_injection_runtime>`
	// runtime. The default is: fault.http.abort.abort_percent
	abort_percent_runtime?: string
	// The runtime key to override the :ref:`default <config_http_filters_fault_injection_runtime>`
	// runtime. The default is: fault.http.delay.fixed_duration_ms
	delay_duration_runtime?: string
	// The runtime key to override the :ref:`default <config_http_filters_fault_injection_runtime>`
	// runtime. The default is: fault.http.abort.http_status
	abort_http_status_runtime?: string
	// The runtime key to override the :ref:`default <config_http_filters_fault_injection_runtime>`
	// runtime. The default is: fault.http.max_active_faults
	max_active_faults_runtime?: string
	// The runtime key to override the :ref:`default <config_http_filters_fault_injection_runtime>`
	// runtime. The default is: fault.http.rate_limit.response_percent
	response_rate_limit_percent_runtime?: string
	// The runtime key to override the :ref:`default <config_http_filters_fault_injection_runtime>`
	// runtime. The default is: fault.http.abort.grpc_status
	abort_grpc_status_runtime?: string
	// To control whether stats storage is allocated dynamically for each downstream server.
	// If set to true, "x-envoy-downstream-service-cluster" field of header will be ignored by this filter.
	// If set to false, dynamic stats storage will be allocated for the downstream cluster name.
	// Default value is false.
	disable_downstream_cluster_stats?: bool
}

// Fault aborts are controlled via an HTTP header (if applicable). See the
// :ref:`HTTP fault filter <config_http_filters_fault_injection_http_header>` documentation for
// more information.
#FaultAbort_HeaderAbort: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.fault.v3.FaultAbort_HeaderAbort"
}
