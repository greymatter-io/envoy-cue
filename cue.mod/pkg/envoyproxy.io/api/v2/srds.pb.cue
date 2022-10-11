package v2

// [#not-implemented-hide:] Not configuration. Workaround c++ protobuf issue with importing
// services: https://github.com/google/protobuf/issues/4221 and protoxform to upgrade the file.
#SrdsDummy: {
	"@type": "type.googleapis.com/envoy.api.v2.SrdsDummy"
}

// ScopedRoutesDiscoveryServiceClient is the client API for ScopedRoutesDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#ScopedRoutesDiscoveryServiceClient: _

#ScopedRoutesDiscoveryService_StreamScopedRoutesClient: _

#ScopedRoutesDiscoveryService_DeltaScopedRoutesClient: _

// ScopedRoutesDiscoveryServiceServer is the server API for ScopedRoutesDiscoveryService service.
#ScopedRoutesDiscoveryServiceServer: _

// UnimplementedScopedRoutesDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedScopedRoutesDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.api.v2.UnimplementedScopedRoutesDiscoveryServiceServer"
}

#ScopedRoutesDiscoveryService_StreamScopedRoutesServer: _

#ScopedRoutesDiscoveryService_DeltaScopedRoutesServer: _
