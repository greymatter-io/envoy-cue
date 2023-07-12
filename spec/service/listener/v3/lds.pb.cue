package v3

// [#not-implemented-hide:] Not configuration. Workaround c++ protobuf issue with importing
// services: https://github.com/google/protobuf/issues/4221 and protoxform to upgrade the file.
#LdsDummy: {
	"@type": "type.googleapis.com/envoy.service.listener.v3.LdsDummy"
}

// ListenerDiscoveryServiceClient is the client API for ListenerDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#ListenerDiscoveryServiceClient: _

#ListenerDiscoveryService_DeltaListenersClient: _

#ListenerDiscoveryService_StreamListenersClient: _

// ListenerDiscoveryServiceServer is the server API for ListenerDiscoveryService service.
#ListenerDiscoveryServiceServer: _

// UnimplementedListenerDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedListenerDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.listener.v3.UnimplementedListenerDiscoveryServiceServer"
}

#ListenerDiscoveryService_DeltaListenersServer: _

#ListenerDiscoveryService_StreamListenersServer: _
