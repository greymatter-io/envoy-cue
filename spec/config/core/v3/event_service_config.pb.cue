package v3

// [#not-implemented-hide:]
// Configuration of the event reporting service endpoint.
#EventServiceConfig: {
	"@type": "type.googleapis.com/envoy.config.core.v3.EventServiceConfig"
	// Specifies the gRPC service that hosts the event reporting service.
	grpc_service?: #GrpcService
}
