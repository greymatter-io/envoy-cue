package v2

import (
	core "envoyproxy.io/api/v2/core"
	v1 "envoyproxy.io/deps/census-instrumentation/opencensus-proto/gen-go/trace/v1"
)

#StreamTracesResponse: {
	"@type": "type.googleapis.com/envoy.service.trace.v2.StreamTracesResponse"
}

#StreamTracesMessage: {
	"@type": "type.googleapis.com/envoy.service.trace.v2.StreamTracesMessage"
	// Identifier data effectively is a structured metadata.
	// As a performance optimization this will only be sent in the first message
	// on the stream.
	identifier?: #StreamTracesMessage_Identifier
	// A list of Span entries
	spans?: [...v1.#Span]
}

#StreamTracesMessage_Identifier: {
	"@type": "type.googleapis.com/envoy.service.trace.v2.StreamTracesMessage_Identifier"
	// The node sending the access log messages over the stream.
	node?: core.#Node
}
