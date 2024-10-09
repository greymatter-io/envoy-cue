package v2

// EndpointDiscoveryServiceClient is the client API for EndpointDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#EndpointDiscoveryServiceClient: _

#EndpointDiscoveryService_StreamEndpointsClient: _

#EndpointDiscoveryService_DeltaEndpointsClient: _

// EndpointDiscoveryServiceServer is the server API for EndpointDiscoveryService service.
// All implementations should embed UnimplementedEndpointDiscoveryServiceServer
// for forward compatibility
#EndpointDiscoveryServiceServer: _

// UnimplementedEndpointDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedEndpointDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.api.v2.UnimplementedEndpointDiscoveryServiceServer"
}

// UnsafeEndpointDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to EndpointDiscoveryServiceServer will
// result in compilation errors.
#UnsafeEndpointDiscoveryServiceServer: _

#EndpointDiscoveryService_StreamEndpointsServer: _

#EndpointDiscoveryService_DeltaEndpointsServer: _
