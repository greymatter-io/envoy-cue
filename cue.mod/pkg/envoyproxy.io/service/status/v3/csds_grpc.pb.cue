package v3

// ClientStatusDiscoveryServiceClient is the client API for ClientStatusDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#ClientStatusDiscoveryServiceClient: _

#ClientStatusDiscoveryService_StreamClientStatusClient: _

// ClientStatusDiscoveryServiceServer is the server API for ClientStatusDiscoveryService service.
// All implementations should embed UnimplementedClientStatusDiscoveryServiceServer
// for forward compatibility
#ClientStatusDiscoveryServiceServer: _

// UnimplementedClientStatusDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedClientStatusDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.status.v3.UnimplementedClientStatusDiscoveryServiceServer"
}

// UnsafeClientStatusDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to ClientStatusDiscoveryServiceServer will
// result in compilation errors.
#UnsafeClientStatusDiscoveryServiceServer: _

#ClientStatusDiscoveryService_StreamClientStatusServer: _
