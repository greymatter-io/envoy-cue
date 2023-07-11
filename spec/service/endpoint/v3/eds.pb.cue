package v3

// [#not-implemented-hide:] Not configuration. Workaround c++ protobuf issue with importing
// services: https://github.com/google/protobuf/issues/4221 and protoxform to upgrade the file.
#EdsDummy: {
	"@type": "type.googleapis.com/envoy.service.endpoint.v3.EdsDummy"
}

// EndpointDiscoveryServiceClient is the client API for EndpointDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#EndpointDiscoveryServiceClient: _

#EndpointDiscoveryService_StreamEndpointsClient: _

#EndpointDiscoveryService_DeltaEndpointsClient: _

// EndpointDiscoveryServiceServer is the server API for EndpointDiscoveryService service.
#EndpointDiscoveryServiceServer: _

// UnimplementedEndpointDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedEndpointDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.endpoint.v3.UnimplementedEndpointDiscoveryServiceServer"
}

#EndpointDiscoveryService_StreamEndpointsServer: _

#EndpointDiscoveryService_DeltaEndpointsServer: _
