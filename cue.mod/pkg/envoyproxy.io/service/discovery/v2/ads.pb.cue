package v2

// [#not-implemented-hide:] Not configuration. Workaround c++ protobuf issue with importing
// services: https://github.com/google/protobuf/issues/4221
#AdsDummy: {
	"@type": "type.googleapis.com/envoy.service.discovery.v2.AdsDummy"
}

// AggregatedDiscoveryServiceClient is the client API for AggregatedDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#AggregatedDiscoveryServiceClient: _

#AggregatedDiscoveryService_StreamAggregatedResourcesClient: _

#AggregatedDiscoveryService_DeltaAggregatedResourcesClient: _

// AggregatedDiscoveryServiceServer is the server API for AggregatedDiscoveryService service.
#AggregatedDiscoveryServiceServer: _

// UnimplementedAggregatedDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedAggregatedDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.discovery.v2.UnimplementedAggregatedDiscoveryServiceServer"
}

#AggregatedDiscoveryService_StreamAggregatedResourcesServer: _

#AggregatedDiscoveryService_DeltaAggregatedResourcesServer: _
