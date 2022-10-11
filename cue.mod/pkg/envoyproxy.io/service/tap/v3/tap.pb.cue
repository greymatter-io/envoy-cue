package v3

import (
	v3 "envoyproxy.io/data/tap/v3"
	v31 "envoyproxy.io/config/core/v3"
)

// [#not-implemented-hide:] Stream message for the Tap API. Envoy will open a stream to the server
// and stream taps without ever expecting a response.
#StreamTapsRequest: {
	"@type": "type.googleapis.com/envoy.service.tap.v3.StreamTapsRequest"
	// Identifier data effectively is a structured metadata. As a performance optimization this will
	// only be sent in the first message on the stream.
	identifier?: #StreamTapsRequest_Identifier
	// The trace id. this can be used to merge together a streaming trace. Note that the trace_id
	// is not guaranteed to be spatially or temporally unique.
	trace_id?: uint64
	// The trace data.
	trace?: v3.#TraceWrapper
}

// [#not-implemented-hide:]
#StreamTapsResponse: {
	"@type": "type.googleapis.com/envoy.service.tap.v3.StreamTapsResponse"
}

#StreamTapsRequest_Identifier: {
	"@type": "type.googleapis.com/envoy.service.tap.v3.StreamTapsRequest_Identifier"
	// The node sending taps over the stream.
	node?: v31.#Node
	// The opaque identifier that was set in the :ref:`output config
	// <envoy_v3_api_field_config.tap.v3.StreamingGrpcSink.tap_id>`.
	tap_id?: string
}

// TapSinkServiceClient is the client API for TapSinkService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#TapSinkServiceClient: _

#TapSinkService_StreamTapsClient: _

// TapSinkServiceServer is the server API for TapSinkService service.
#TapSinkServiceServer: _

// UnimplementedTapSinkServiceServer can be embedded to have forward compatible implementations.
#UnimplementedTapSinkServiceServer: {
	"@type": "type.googleapis.com/envoy.service.tap.v3.UnimplementedTapSinkServiceServer"
}

#TapSinkService_StreamTapsServer: _
