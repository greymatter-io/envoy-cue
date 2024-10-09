package v3

// ExtensionConfigDiscoveryServiceClient is the client API for ExtensionConfigDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#ExtensionConfigDiscoveryServiceClient: _

#ExtensionConfigDiscoveryService_StreamExtensionConfigsClient: _

#ExtensionConfigDiscoveryService_DeltaExtensionConfigsClient: _

// ExtensionConfigDiscoveryServiceServer is the server API for ExtensionConfigDiscoveryService service.
// All implementations should embed UnimplementedExtensionConfigDiscoveryServiceServer
// for forward compatibility
#ExtensionConfigDiscoveryServiceServer: _

// UnimplementedExtensionConfigDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedExtensionConfigDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.extension.v3.UnimplementedExtensionConfigDiscoveryServiceServer"
}

// UnsafeExtensionConfigDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to ExtensionConfigDiscoveryServiceServer will
// result in compilation errors.
#UnsafeExtensionConfigDiscoveryServiceServer: _

#ExtensionConfigDiscoveryService_StreamExtensionConfigsServer: _

#ExtensionConfigDiscoveryService_DeltaExtensionConfigsServer: _
