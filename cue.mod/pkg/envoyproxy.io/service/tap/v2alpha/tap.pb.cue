package v2alpha

import (
	core "envoyproxy.io/api/v2/core"
	v2alpha "envoyproxy.io/data/tap/v2alpha"
)

// [#not-implemented-hide:] Stream message for the Tap API. Envoy will open a stream to the server
// and stream taps without ever expecting a response.
#StreamTapsRequest: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.StreamTapsRequest"
	// Identifier data effectively is a structured metadata. As a performance optimization this will
	// only be sent in the first message on the stream.
	identifier?: #StreamTapsRequest_Identifier
	// The trace id. this can be used to merge together a streaming trace. Note that the trace_id
	// is not guaranteed to be spatially or temporally unique.
	trace_id?: uint64
	// The trace data.
	trace?: v2alpha.#TraceWrapper
}

// [#not-implemented-hide:]
#StreamTapsResponse: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.StreamTapsResponse"
}

#StreamTapsRequest_Identifier: {
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.StreamTapsRequest_Identifier"
	// The node sending taps over the stream.
	node?: core.#Node
	// The opaque identifier that was set in the :ref:`output config
	// <envoy_api_field_service.tap.v2alpha.StreamingGrpcSink.tap_id>`.
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
	"@type": "type.googleapis.com/envoy.service.tap.v2alpha.UnimplementedTapSinkServiceServer"
}

#TapSinkService_StreamTapsServer: _
