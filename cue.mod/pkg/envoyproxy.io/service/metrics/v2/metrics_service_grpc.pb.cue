package v2

// MetricsServiceClient is the client API for MetricsService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#MetricsServiceClient: _

#MetricsService_StreamMetricsClient: _

// MetricsServiceServer is the server API for MetricsService service.
// All implementations should embed UnimplementedMetricsServiceServer
// for forward compatibility
#MetricsServiceServer: _

// UnimplementedMetricsServiceServer should be embedded to have forward compatible implementations.
#UnimplementedMetricsServiceServer: {
	"@type": "type.googleapis.com/envoy.service.metrics.v2.UnimplementedMetricsServiceServer"
}

// UnsafeMetricsServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to MetricsServiceServer will
// result in compilation errors.
#UnsafeMetricsServiceServer: _

#MetricsService_StreamMetricsServer: _
