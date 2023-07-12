package v2

import (
	core "envoyproxy.io/envoy-cue/spec/api/v2/core"
)

// Configuration structure.
#TraceServiceConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v2.TraceServiceConfig"
	// The upstream gRPC cluster that hosts the metrics service.
	grpc_service?: core.#GrpcService
}
