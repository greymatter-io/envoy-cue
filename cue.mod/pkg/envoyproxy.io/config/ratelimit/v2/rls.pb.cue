package v2

import (
	core "envoyproxy.io/api/v2/core"
)

// Rate limit :ref:`configuration overview <config_rate_limit_service>`.
#RateLimitServiceConfig: {
	"@type": "type.googleapis.com/envoy.config.ratelimit.v2.RateLimitServiceConfig"
	// Specifies the gRPC service that hosts the rate limit service. The client
	// will connect to this cluster when it needs to make rate limit service
	// requests.
	grpc_service?: core.#GrpcService
}
