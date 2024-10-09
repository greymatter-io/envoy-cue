package v2

// RouteDiscoveryServiceClient is the client API for RouteDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#RouteDiscoveryServiceClient: _

#RouteDiscoveryService_StreamRoutesClient: _

#RouteDiscoveryService_DeltaRoutesClient: _

// RouteDiscoveryServiceServer is the server API for RouteDiscoveryService service.
// All implementations should embed UnimplementedRouteDiscoveryServiceServer
// for forward compatibility
#RouteDiscoveryServiceServer: _

// UnimplementedRouteDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedRouteDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.api.v2.UnimplementedRouteDiscoveryServiceServer"
}

// UnsafeRouteDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to RouteDiscoveryServiceServer will
// result in compilation errors.
#UnsafeRouteDiscoveryServiceServer: _

#RouteDiscoveryService_StreamRoutesServer: _

#RouteDiscoveryService_DeltaRoutesServer: _

// VirtualHostDiscoveryServiceClient is the client API for VirtualHostDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#VirtualHostDiscoveryServiceClient: _

#VirtualHostDiscoveryService_DeltaVirtualHostsClient: _

// VirtualHostDiscoveryServiceServer is the server API for VirtualHostDiscoveryService service.
// All implementations should embed UnimplementedVirtualHostDiscoveryServiceServer
// for forward compatibility
#VirtualHostDiscoveryServiceServer: _

// UnimplementedVirtualHostDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedVirtualHostDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.api.v2.UnimplementedVirtualHostDiscoveryServiceServer"
}

// UnsafeVirtualHostDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to VirtualHostDiscoveryServiceServer will
// result in compilation errors.
#UnsafeVirtualHostDiscoveryServiceServer: _

#VirtualHostDiscoveryService_DeltaVirtualHostsServer: _
