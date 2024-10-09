package v3

// ExternalProcessorClient is the client API for ExternalProcessor service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#ExternalProcessorClient: _

#ExternalProcessor_ProcessClient: _

// ExternalProcessorServer is the server API for ExternalProcessor service.
// All implementations should embed UnimplementedExternalProcessorServer
// for forward compatibility
#ExternalProcessorServer: _

// UnimplementedExternalProcessorServer should be embedded to have forward compatible implementations.
#UnimplementedExternalProcessorServer: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.UnimplementedExternalProcessorServer"
}

// UnsafeExternalProcessorServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to ExternalProcessorServer will
// result in compilation errors.
#UnsafeExternalProcessorServer: _

#ExternalProcessor_ProcessServer: _
