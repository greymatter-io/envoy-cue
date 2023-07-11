package v3

// [#not-implemented-hide:] Not configuration. Workaround c++ protobuf issue
// with importing services: https://github.com/google/protobuf/issues/4221 and
// protoxform to upgrade the file.
#EcdsDummy: {
	"@type": "type.googleapis.com/envoy.service.extension.v3.EcdsDummy"
}

// ExtensionConfigDiscoveryServiceClient is the client API for ExtensionConfigDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#ExtensionConfigDiscoveryServiceClient: _

#ExtensionConfigDiscoveryService_StreamExtensionConfigsClient: _

#ExtensionConfigDiscoveryService_DeltaExtensionConfigsClient: _

// ExtensionConfigDiscoveryServiceServer is the server API for ExtensionConfigDiscoveryService service.
#ExtensionConfigDiscoveryServiceServer: _

// UnimplementedExtensionConfigDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedExtensionConfigDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.extension.v3.UnimplementedExtensionConfigDiscoveryServiceServer"
}

#ExtensionConfigDiscoveryService_StreamExtensionConfigsServer: _

#ExtensionConfigDiscoveryService_DeltaExtensionConfigsServer: _
