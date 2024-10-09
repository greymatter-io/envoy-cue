package v3

// LocalityEndpointDiscoveryServiceClient is the client API for LocalityEndpointDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#LocalityEndpointDiscoveryServiceClient: _

#LocalityEndpointDiscoveryService_DeltaLocalityEndpointsClient: _

// LocalityEndpointDiscoveryServiceServer is the server API for LocalityEndpointDiscoveryService service.
// All implementations should embed UnimplementedLocalityEndpointDiscoveryServiceServer
// for forward compatibility
#LocalityEndpointDiscoveryServiceServer: _

// UnimplementedLocalityEndpointDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedLocalityEndpointDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.endpoint.v3.UnimplementedLocalityEndpointDiscoveryServiceServer"
}

// UnsafeLocalityEndpointDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to LocalityEndpointDiscoveryServiceServer will
// result in compilation errors.
#UnsafeLocalityEndpointDiscoveryServiceServer: _

#LocalityEndpointDiscoveryService_DeltaLocalityEndpointsServer: _
