package v3

// gRPC HTTP/1.1 Bridge filter config.
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.grpc_http1_bridge.v3.Config"
	// If true then requests with content type set to ``application/x-protobuf`` will be automatically converted to gRPC.
	// This works by prepending the payload data with the gRPC header frame, as defined by the wiring format, and
	// Content-Type will be updated accordingly before sending the request.
	// For the requests that went through this upgrade the filter will also strip the frame before forwarding the
	// response to the client.
	upgrade_protobuf_to_grpc?: bool
}
