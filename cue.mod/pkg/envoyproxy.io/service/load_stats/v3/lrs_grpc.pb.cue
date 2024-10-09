package v3

// LoadReportingServiceClient is the client API for LoadReportingService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#LoadReportingServiceClient: _

#LoadReportingService_StreamLoadStatsClient: _

// LoadReportingServiceServer is the server API for LoadReportingService service.
// All implementations should embed UnimplementedLoadReportingServiceServer
// for forward compatibility
#LoadReportingServiceServer: _

// UnimplementedLoadReportingServiceServer should be embedded to have forward compatible implementations.
#UnimplementedLoadReportingServiceServer: {
	"@type": "type.googleapis.com/envoy.service.load_stats.v3.UnimplementedLoadReportingServiceServer"
}

// UnsafeLoadReportingServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to LoadReportingServiceServer will
// result in compilation errors.
#UnsafeLoadReportingServiceServer: _

#LoadReportingService_StreamLoadStatsServer: _
