package v3

// SecretDiscoveryServiceClient is the client API for SecretDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#SecretDiscoveryServiceClient: _

#SecretDiscoveryService_DeltaSecretsClient: _

#SecretDiscoveryService_StreamSecretsClient: _

// SecretDiscoveryServiceServer is the server API for SecretDiscoveryService service.
// All implementations should embed UnimplementedSecretDiscoveryServiceServer
// for forward compatibility
#SecretDiscoveryServiceServer: _

// UnimplementedSecretDiscoveryServiceServer should be embedded to have forward compatible implementations.
#UnimplementedSecretDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.secret.v3.UnimplementedSecretDiscoveryServiceServer"
}

// UnsafeSecretDiscoveryServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to SecretDiscoveryServiceServer will
// result in compilation errors.
#UnsafeSecretDiscoveryServiceServer: _

#SecretDiscoveryService_DeltaSecretsServer: _

#SecretDiscoveryService_StreamSecretsServer: _
