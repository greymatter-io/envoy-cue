package v2

// [#not-implemented-hide:] Not configuration. Workaround c++ protobuf issue with importing
// services: https://github.com/google/protobuf/issues/4221 and protoxform to upgrade the file.
#RdsDummy: {
	"@type": "type.googleapis.com/envoy.api.v2.RdsDummy"
}

// RouteDiscoveryServiceClient is the client API for RouteDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#RouteDiscoveryServiceClient: _

#RouteDiscoveryService_StreamRoutesClient: _

#RouteDiscoveryService_DeltaRoutesClient: _

// RouteDiscoveryServiceServer is the server API for RouteDiscoveryService service.
#RouteDiscoveryServiceServer: _

// UnimplementedRouteDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedRouteDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.api.v2.UnimplementedRouteDiscoveryServiceServer"
}

#RouteDiscoveryService_StreamRoutesServer: _

#RouteDiscoveryService_DeltaRoutesServer: _

// VirtualHostDiscoveryServiceClient is the client API for VirtualHostDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#VirtualHostDiscoveryServiceClient: _

#VirtualHostDiscoveryService_DeltaVirtualHostsClient: _

// VirtualHostDiscoveryServiceServer is the server API for VirtualHostDiscoveryService service.
#VirtualHostDiscoveryServiceServer: _

// UnimplementedVirtualHostDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedVirtualHostDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.api.v2.UnimplementedVirtualHostDiscoveryServiceServer"
}

#VirtualHostDiscoveryService_DeltaVirtualHostsServer: _
