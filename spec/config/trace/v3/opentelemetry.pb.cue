package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for the OpenTelemetry tracer.
//
//	[#extension: envoy.tracers.opentelemetry]
//
// [#next-free-field: 9]
#OpenTelemetryConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.OpenTelemetryConfig"
	// The upstream gRPC cluster that will receive OTLP traces.
	// Note that the tracer drops traces if the server does not read data fast enough.
	// This field can be left empty to disable reporting traces to the gRPC service.
	// Only one of “grpc_service“, “http_service“ may be used.
	grpc_service?: v3.#GrpcService
	// The upstream HTTP cluster that will receive OTLP traces.
	// This field can be left empty to disable reporting traces to the HTTP service.
	// Only one of “grpc_service“, “http_service“ may be used.
	//
	// .. note::
	//
	//	The ``request_headers_to_add`` property in the OTLP HTTP exporter service supports
	//	substitution formatters. The formatters cannot access any HTTP or connection properties, but
	//	can load content such as environment variables or files or secrets.
	http_service?: v3.#HttpService
	// The name for the service. This will be populated in the ResourceSpan Resource attributes.
	// If it is not provided, it will default to "unknown_service:envoy".
	service_name?: string
	// An ordered list of resource detectors
	// [#extension-category: envoy.tracers.opentelemetry.resource_detectors]
	resource_detectors?: [...v3.#TypedExtensionConfig]
	// Specifies the sampler to be used by the OpenTelemetry tracer.
	// The configured sampler implements the Sampler interface defined by the OpenTelemetry specification.
	// This field can be left empty. In this case, the default Envoy sampling decision is used.
	//
	// See: `OpenTelemetry sampler specification <https://opentelemetry.io/docs/specs/otel/trace/sdk/#sampler>`_
	// [#extension-category: envoy.tracers.opentelemetry.samplers]
	sampler?: v3.#TypedExtensionConfig
	// Envoy caches the span in memory when the OpenTelemetry backend service is temporarily unavailable.
	// This field specifies the maximum number of spans that can be cached. If not specified, the
	// default is 1024.
	max_cache_size?: uint32
	// Specifies whether to set the telemetry SDK resource attributes.
	// The following attributes will be set:
	//
	// - telemetry.sdk.language
	// - telemetry.sdk.name
	// - telemetry.sdk.version
	//
	// If not specified, the default is to set these attributes.
	set_telemetry_sdk_resource_attributes?: bool
	// Specifies whether to set the “service.name“ resource attribute.
	// If not specified, the default is to set this attribute.
	set_service_name_resource_attribute?: bool
}
