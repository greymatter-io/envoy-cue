package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration structure.
#TraceServiceConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.TraceServiceConfig"
	// The upstream gRPC cluster that hosts the metrics service.
	grpc_service?: v3.#GrpcService
}
