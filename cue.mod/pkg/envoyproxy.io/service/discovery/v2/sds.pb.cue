package v2

// [#not-implemented-hide:] Not configuration. Workaround c++ protobuf issue with importing
// services: https://github.com/google/protobuf/issues/4221
#SdsDummy: {
	"@type": "type.googleapis.com/envoy.service.discovery.v2.SdsDummy"
}

// SecretDiscoveryServiceClient is the client API for SecretDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#SecretDiscoveryServiceClient: _

#SecretDiscoveryService_DeltaSecretsClient: _

#SecretDiscoveryService_StreamSecretsClient: _

// SecretDiscoveryServiceServer is the server API for SecretDiscoveryService service.
#SecretDiscoveryServiceServer: _

// UnimplementedSecretDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedSecretDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.discovery.v2.UnimplementedSecretDiscoveryServiceServer"
}

#SecretDiscoveryService_DeltaSecretsServer: _

#SecretDiscoveryService_StreamSecretsServer: _
