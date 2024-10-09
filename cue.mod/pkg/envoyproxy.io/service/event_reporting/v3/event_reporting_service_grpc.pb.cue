package v3

// EventReportingServiceClient is the client API for EventReportingService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
#EventReportingServiceClient: _

#EventReportingService_StreamEventsClient: _

// EventReportingServiceServer is the server API for EventReportingService service.
// All implementations should embed UnimplementedEventReportingServiceServer
// for forward compatibility
#EventReportingServiceServer: _

// UnimplementedEventReportingServiceServer should be embedded to have forward compatible implementations.
#UnimplementedEventReportingServiceServer: {
	"@type": "type.googleapis.com/envoy.service.event_reporting.v3.UnimplementedEventReportingServiceServer"
}

// UnsafeEventReportingServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to EventReportingServiceServer will
// result in compilation errors.
#UnsafeEventReportingServiceServer: _

#EventReportingService_StreamEventsServer: _
