package v2alpha1

// gRPC reverse bridge filter configuration
#FilterConfig: {
	"@type": "type.googleapis.com/envoy.config.filter.http.grpc_http1_reverse_bridge.v2alpha1.FilterConfig"
	// The content-type to pass to the upstream when the gRPC bridge filter is applied.
	// The filter will also validate that the upstream responds with the same content type.
	content_type?: string
	// If true, Envoy will assume that the upstream doesn't understand gRPC frames and
	// strip the gRPC frame from the request, and add it back in to the response. This will
	// hide the gRPC semantics from the upstream, allowing it to receive and respond with a
	// simple binary encoded protobuf.
	withhold_grpc_frames?: bool
}

// gRPC reverse bridge filter configuration per virtualhost/route/weighted-cluster level.
#FilterConfigPerRoute: {
	"@type": "type.googleapis.com/envoy.config.filter.http.grpc_http1_reverse_bridge.v2alpha1.FilterConfigPerRoute"
	// If true, disables gRPC reverse bridge filter for this particular vhost or route.
	// If disabled is specified in multiple per-filter-configs, the most specific one will be used.
	disabled?: bool
}
