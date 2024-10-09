package v3

// AggregatedDiscoveryServiceClient is the client API for AggregatedDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#AggregatedDiscoveryServiceClient: _

#AggregatedDiscoveryService_StreamAggregatedResourcesClient: _

#AggregatedDiscoveryService_DeltaAggregatedResourcesClient: _

// AggregatedDiscoveryServiceServer is the server API for AggregatedDiscoveryService service.
// All implementations should embed UnimplementedAggregatedDiscoveryServiceServer
// for forward compatibility
#AggregatedDiscoveryServiceServer: _

// UnimplementedAggregatedDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedAggregatedDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.discovery.v3.UnimplementedAggregatedDiscoveryServiceServer"
}

// UnsafeAggregatedDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to AggregatedDiscoveryServiceServer will
// result in compilation errors.
#UnsafeAggregatedDiscoveryServiceServer: _

#AggregatedDiscoveryService_StreamAggregatedResourcesServer: _

#AggregatedDiscoveryService_DeltaAggregatedResourcesServer: _
