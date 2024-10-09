package v3

// TraceServiceClient is the client API for TraceService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#TraceServiceClient: _

#TraceService_StreamTracesClient: _

// TraceServiceServer is the server API for TraceService service.
// All implementations should embed UnimplementedTraceServiceServer
// for forward compatibility
#TraceServiceServer: _

// UnimplementedTraceServiceServer should be embedded to have forward compatible implementations.
#UnimplementedTraceServiceServer: {
	"@type": "type.googleapis.com/envoy.service.trace.v3.UnimplementedTraceServiceServer"
}

// UnsafeTraceServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to TraceServiceServer will
// result in compilation errors.
#UnsafeTraceServiceServer: _

#TraceService_StreamTracesServer: _
