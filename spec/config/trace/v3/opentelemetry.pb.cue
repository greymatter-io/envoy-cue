package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for the OpenTelemetry tracer.
//  [#extension: envoy.tracers.opentelemetry]
#OpenTelemetryConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.OpenTelemetryConfig"
	// The upstream gRPC cluster that will receive OTLP traces.
	// Note that the tracer drops traces if the server does not read data fast enough.
	grpc_service?: v3.#GrpcService
	// The name for the service. This will be populated in the ResourceSpan Resource attributes.
	// If it is not provided, it will default to "unknown_service:envoy".
	service_name?: string
}
