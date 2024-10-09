package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration for the OpenTelemetry tracer.
//
//	[#extension: envoy.tracers.opentelemetry]
//
// [#next-free-field: 6]
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
	//	Note: The ``request_headers_to_add`` property in the OTLP HTTP exporter service
	//	does not support the :ref:`format specifier <config_access_log_format>` as used for
	//	:ref:`HTTP access logging <config_access_log>`.
	//	The values configured are added as HTTP headers on the OTLP export request
	//	without any formatting applied.
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
}
