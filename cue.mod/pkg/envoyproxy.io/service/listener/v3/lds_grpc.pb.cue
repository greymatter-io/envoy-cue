package v3

// ListenerDiscoveryServiceClient is the client API for ListenerDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#ListenerDiscoveryServiceClient: _

#ListenerDiscoveryService_DeltaListenersClient: _

#ListenerDiscoveryService_StreamListenersClient: _

// ListenerDiscoveryServiceServer is the server API for ListenerDiscoveryService service.
// All implementations should embed UnimplementedListenerDiscoveryServiceServer
// for forward compatibility
#ListenerDiscoveryServiceServer: _

// UnimplementedListenerDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedListenerDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.listener.v3.UnimplementedListenerDiscoveryServiceServer"
}

// UnsafeListenerDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to ListenerDiscoveryServiceServer will
// result in compilation errors.
#UnsafeListenerDiscoveryServiceServer: _

#ListenerDiscoveryService_DeltaListenersServer: _

#ListenerDiscoveryService_StreamListenersServer: _
