package v3

// [#not-implemented-hide:] Not configuration. Workaround c++ protobuf issue with importing
// services: https://github.com/google/protobuf/issues/4221 and protoxform to upgrade the file.
#LedsDummy: {
	"@type": "type.googleapis.com/envoy.service.endpoint.v3.LedsDummy"
}

// LocalityEndpointDiscoveryServiceClient is the client API for LocalityEndpointDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#LocalityEndpointDiscoveryServiceClient: _

#LocalityEndpointDiscoveryService_DeltaLocalityEndpointsClient: _

// LocalityEndpointDiscoveryServiceServer is the server API for LocalityEndpointDiscoveryService service.
#LocalityEndpointDiscoveryServiceServer: _

// UnimplementedLocalityEndpointDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedLocalityEndpointDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.endpoint.v3.UnimplementedLocalityEndpointDiscoveryServiceServer"
}

#LocalityEndpointDiscoveryService_DeltaLocalityEndpointsServer: _
