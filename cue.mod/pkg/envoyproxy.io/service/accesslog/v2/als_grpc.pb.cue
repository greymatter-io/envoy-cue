package v2

// AccessLogServiceClient is the client API for AccessLogService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#AccessLogServiceClient: _

#AccessLogService_StreamAccessLogsClient: _

// AccessLogServiceServer is the server API for AccessLogService service.
// All implementations should embed UnimplementedAccessLogServiceServer
// for forward compatibility
#AccessLogServiceServer: _

// UnimplementedAccessLogServiceServer should be embedded to have forward compatible implementations.
#UnimplementedAccessLogServiceServer: {
	"@type": "type.googleapis.com/envoy.service.accesslog.v2.UnimplementedAccessLogServiceServer"
}

// UnsafeAccessLogServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to AccessLogServiceServer will
// result in compilation errors.
#UnsafeAccessLogServiceServer: _

#AccessLogService_StreamAccessLogsServer: _
