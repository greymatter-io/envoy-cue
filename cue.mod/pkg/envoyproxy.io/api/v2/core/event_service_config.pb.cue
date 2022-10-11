package core

// [#not-implemented-hide:]
// Configuration of the event reporting service endpoint.
#EventServiceConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.core.EventServiceConfig"
	// Specifies the gRPC service that hosts the event reporting service.
	grpc_service?: #GrpcService
}
