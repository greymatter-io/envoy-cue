package v2alpha

import (
	core "envoyproxy.io/api/v2/core"
)

// [#not-implemented-hide:]
// An events envoy sends to the management server.
#StreamEventsRequest: {
	"@type": "type.googleapis.com/envoy.service.event_reporting.v2alpha.StreamEventsRequest"
	// Identifier data that will only be sent in the first message on the stream. This is effectively
	// structured metadata and is a performance optimization.
	identifier?: #StreamEventsRequest_Identifier
	// Batch of events. When the stream is already active, it will be the events occurred
	// since the last message had been sent. If the server receives unknown event type, it should
	// silently ignore it.
	//
	// The following events are supported:
	//
	// * :ref:`HealthCheckEvent <envoy_api_msg_data.core.v2alpha.HealthCheckEvent>`
	// * :ref:`OutlierDetectionEvent <envoy_api_msg_data.cluster.v2alpha.OutlierDetectionEvent>`
	events?: _
}

// [#not-implemented-hide:]
// The management server may send envoy a StreamEventsResponse to tell which events the server
// is interested in. In future, with aggregated event reporting service, this message will
// contain, for example, clusters the envoy should send events for, or event types the server
// wants to process.
#StreamEventsResponse: {
	"@type": "type.googleapis.com/envoy.service.event_reporting.v2alpha.StreamEventsResponse"
}

#StreamEventsRequest_Identifier: {
	"@type": "type.googleapis.com/envoy.service.event_reporting.v2alpha.StreamEventsRequest_Identifier"
	// The node sending the event messages over the stream.
	node?: core.#Node
}

// EventReportingServiceClient is the client API for EventReportingService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#EventReportingServiceClient: _

#EventReportingService_StreamEventsClient: _

// EventReportingServiceServer is the server API for EventReportingService service.
#EventReportingServiceServer: _

// UnimplementedEventReportingServiceServer can be embedded to have forward compatible implementations.
#UnimplementedEventReportingServiceServer: {
	"@type": "type.googleapis.com/envoy.service.event_reporting.v2alpha.UnimplementedEventReportingServiceServer"
}

#EventReportingService_StreamEventsServer: _
