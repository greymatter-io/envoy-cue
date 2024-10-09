package v2

// RuntimeDiscoveryServiceClient is the client API for RuntimeDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#RuntimeDiscoveryServiceClient: _

#RuntimeDiscoveryService_StreamRuntimeClient: _

#RuntimeDiscoveryService_DeltaRuntimeClient: _

// RuntimeDiscoveryServiceServer is the server API for RuntimeDiscoveryService service.
// All implementations should embed UnimplementedRuntimeDiscoveryServiceServer
// for forward compatibility
#RuntimeDiscoveryServiceServer: _

// UnimplementedRuntimeDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedRuntimeDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.discovery.v2.UnimplementedRuntimeDiscoveryServiceServer"
}

// UnsafeRuntimeDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to RuntimeDiscoveryServiceServer will
// result in compilation errors.
#UnsafeRuntimeDiscoveryServiceServer: _

#RuntimeDiscoveryService_StreamRuntimeServer: _

#RuntimeDiscoveryService_DeltaRuntimeServer: _
