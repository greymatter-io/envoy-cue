package v2

// Available Zipkin collector endpoint versions.
#ZipkinConfig_CollectorEndpointVersion: "HTTP_JSON_V1" | "HTTP_JSON" | "HTTP_PROTO" | "GRPC"

ZipkinConfig_CollectorEndpointVersion_HTTP_JSON_V1: "HTTP_JSON_V1"
ZipkinConfig_CollectorEndpointVersion_HTTP_JSON:    "HTTP_JSON"
ZipkinConfig_CollectorEndpointVersion_HTTP_PROTO:   "HTTP_PROTO"
ZipkinConfig_CollectorEndpointVersion_GRPC:         "GRPC"

// Configuration for the Zipkin tracer.
// [#extension: envoy.tracers.zipkin]
// [#next-free-field: 6]
#ZipkinConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v2.ZipkinConfig"
	// The cluster manager cluster that hosts the Zipkin collectors. Note that the
	// Zipkin cluster must be defined in the :ref:`Bootstrap static cluster
	// resources <envoy_api_field_config.bootstrap.v2.Bootstrap.StaticResources.clusters>`.
	collector_cluster?: string
	// The API endpoint of the Zipkin service where the spans will be sent. When
	// using a standard Zipkin installation, the API endpoint is typically
	// /api/v1/spans, which is the default value.
	collector_endpoint?: string
	// Determines whether a 128bit trace id will be used when creating a new
	// trace instance. The default value is false, which will result in a 64 bit trace id being used.
	trace_id_128bit?: bool
	// Determines whether client and server spans will share the same span context.
	// The default value is true.
	shared_span_context?: bool
	// Determines the selected collector endpoint version. By default, the ``HTTP_JSON_V1`` will be
	// used.
	collector_endpoint_version?: #ZipkinConfig_CollectorEndpointVersion
}
