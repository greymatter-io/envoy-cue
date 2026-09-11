package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Available trace context options for handling different trace header formats.
#ZipkinConfig_TraceContextOption: "USE_B3" | "USE_B3_WITH_W3C_PROPAGATION"

ZipkinConfig_TraceContextOption_USE_B3:                      "USE_B3"
ZipkinConfig_TraceContextOption_USE_B3_WITH_W3C_PROPAGATION: "USE_B3_WITH_W3C_PROPAGATION"

// Available Zipkin collector endpoint versions.
#ZipkinConfig_CollectorEndpointVersion: "DEPRECATED_AND_UNAVAILABLE_DO_NOT_USE" | "HTTP_JSON" | "HTTP_PROTO" | "GRPC"

ZipkinConfig_CollectorEndpointVersion_DEPRECATED_AND_UNAVAILABLE_DO_NOT_USE: "DEPRECATED_AND_UNAVAILABLE_DO_NOT_USE"
ZipkinConfig_CollectorEndpointVersion_HTTP_JSON:                             "HTTP_JSON"
ZipkinConfig_CollectorEndpointVersion_HTTP_PROTO:                            "HTTP_PROTO"
ZipkinConfig_CollectorEndpointVersion_GRPC:                                  "GRPC"

// Configuration for the Zipkin tracer.
// [#extension: envoy.tracers.zipkin]
// [#next-free-field: 11]
#ZipkinConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.ZipkinConfig"
	// The cluster manager cluster that hosts the Zipkin collectors.
	//
	// .. note::
	//
	//	This field will be deprecated in future releases in favor of
	//	:ref:`collector_service <envoy_v3_api_field_config.trace.v3.ZipkinConfig.collector_service>`.
	//
	//	Either this field or ``collector_service`` must be specified.
	collector_cluster?: string
	// The API endpoint of the Zipkin service where the spans will be sent. When
	// using a standard Zipkin installation.
	//
	// .. note::
	//
	//	This field will be deprecated in future releases in favor of
	//	:ref:`collector_service <envoy_v3_api_field_config.trace.v3.ZipkinConfig.collector_service>`.
	//
	//	Required when using ``collector_cluster``.
	collector_endpoint?: string
	// Determines whether a 128bit trace id will be used when creating a new
	// trace instance. The default value is false, which will result in a 64 bit trace id being used.
	trace_id_128bit?: bool
	// Determines whether client and server spans will share the same span context.
	// The default value is true.
	shared_span_context?: bool
	// Determines the selected collector endpoint version.
	collector_endpoint_version?: #ZipkinConfig_CollectorEndpointVersion
	// Optional hostname to use when sending spans to the collector_cluster. Useful for collectors
	// that require a specific hostname. Defaults to :ref:`collector_cluster <envoy_v3_api_field_config.trace.v3.ZipkinConfig.collector_cluster>` above.
	//
	// .. note::
	//
	//	This field will be deprecated in future releases in favor of
	//	:ref:`collector_service <envoy_v3_api_field_config.trace.v3.ZipkinConfig.collector_service>`.
	collector_hostname?: string
	// If this is set to true, then Envoy will be treated as an independent hop in trace chain. A complete span pair will be created for a single
	// request. Server span will be created for the downstream request and client span will be created for the related upstream request.
	// This should be set to true in the following cases:
	//
	// * The Envoy Proxy is used as gateway or ingress.
	// * The Envoy Proxy is used as sidecar but inbound traffic capturing or outbound traffic capturing is disabled.
	// * Any case that the :ref:`start_child_span of router <envoy_v3_api_field_extensions.filters.http.router.v3.Router.start_child_span>` is set to true.
	//
	// .. attention::
	//
	//	If this is set to true, then the
	//	:ref:`start_child_span of router <envoy_v3_api_field_extensions.filters.http.router.v3.Router.start_child_span>`
	//	SHOULD be set to true also to ensure the correctness of trace chain.
	//
	//	Both this field and ``start_child_span`` are deprecated by the
	//	:ref:`spawn_upstream_span <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.Tracing.spawn_upstream_span>`.
	//	Please use that ``spawn_upstream_span`` field to control the span creation.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/zipkin.proto.
	split_spans_for_request?: bool
	// Determines which trace context format to use for trace header extraction and propagation.
	// This controls both downstream request header extraction and upstream request header injection.
	// Here is the spec for W3C trace headers: https://www.w3.org/TR/trace-context/
	// The default value is USE_B3 to maintain backward compatibility.
	trace_context_option?: #ZipkinConfig_TraceContextOption
	// HTTP service configuration for the Zipkin collector.
	// When specified, this configuration takes precedence over the legacy fields:
	// collector_cluster, collector_endpoint, and collector_hostname.
	// This provides a complete HTTP service configuration including cluster, URI, timeout, and headers.
	// If not specified, the legacy fields above will be used for backward compatibility.
	//
	// Required fields when using collector_service:
	//
	// * “http_uri.cluster“ - Must be specified and non-empty
	// * “http_uri.uri“ - Must be specified and non-empty
	// * “http_uri.timeout“ - Optional
	//
	// Full URI Support with Automatic Parsing:
	//
	// The “uri“ field supports both path-only and full URI formats:
	//
	// .. code-block:: yaml
	//
	//	tracing:
	//	  provider:
	//	    name: envoy.tracers.zipkin
	//	    typed_config:
	//	      "@type": type.googleapis.com/envoy.config.trace.v3.ZipkinConfig
	//	      collector_service:
	//	        http_uri:
	//	          # Full URI format - hostname and path are extracted automatically
	//	          uri: "https://zipkin-collector.example.com/api/v2/spans"
	//	          cluster: zipkin
	//	          timeout: 5s
	//	        request_headers_to_add:
	//	          - header:
	//	              key: "X-Custom-Token"
	//	              value: "your-custom-token"
	//	          - header:
	//	              key: "X-Service-ID"
	//	              value: "your-service-id"
	//
	// URI Parsing Behavior:
	//
	// * Full URI: “"https://zipkin-collector.example.com/api/v2/spans"“
	//
	//   - Hostname: “zipkin-collector.example.com“ (sets HTTP “Host“ header)
	//   - Path: “/api/v2/spans“ (sets HTTP request path)
	//
	// * Path only: “"/api/v2/spans"“
	//
	//   - Hostname: Uses cluster name as fallback
	//   - Path: “/api/v2/spans“
	collector_service?: v3.#HttpService
	// Determines whether trace IDs will include a timestamp in the first 4 bytes.
	// When enabled, trace IDs are generated with the format: [32-bit epoch seconds][32-bit random].
	// The default value is false, which results in fully random trace IDs.
	// For 128-bit trace IDs, the timestamp is encoded in the high 32 bits of the high 64-bit word.
	timestamp_trace_ids?: bool
}
