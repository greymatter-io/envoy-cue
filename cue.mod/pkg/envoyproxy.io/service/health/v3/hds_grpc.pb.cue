package v3

// HealthDiscoveryServiceClient is the client API for HealthDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#HealthDiscoveryServiceClient: _

#HealthDiscoveryService_StreamHealthCheckClient: _

// HealthDiscoveryServiceServer is the server API for HealthDiscoveryService service.
// All implementations should embed UnimplementedHealthDiscoveryServiceServer
// for forward compatibility
#HealthDiscoveryServiceServer: _

// UnimplementedHealthDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedHealthDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.health.v3.UnimplementedHealthDiscoveryServiceServer"
}

// UnsafeHealthDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to HealthDiscoveryServiceServer will
// result in compilation errors.
#UnsafeHealthDiscoveryServiceServer: _

#HealthDiscoveryService_StreamHealthCheckServer: _
