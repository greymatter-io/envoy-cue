package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Connection properties.
#Connection: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.Connection"
	// Local address.
	local_address?: v3.#Address
	// Remote address.
	remote_address?: v3.#Address
}

// Event in a socket trace.
#SocketEvent: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.SocketEvent"
	// Timestamp for event.
	timestamp?: string
	read?:      #SocketEvent_Read
	write?:     #SocketEvent_Write
	closed?:    #SocketEvent_Closed
}

// Sequence of read/write events that constitute a buffered trace on a socket.
// [#next-free-field: 6]
#SocketBufferedTrace: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.SocketBufferedTrace"
	// Trace ID unique to the originating Envoy only. Trace IDs can repeat and should not be used
	// for long term stable uniqueness. Matches connection IDs used in Envoy logs.
	trace_id?: uint64
	// Connection properties.
	connection?: #Connection
	// Sequence of observed events.
	events?: [...#SocketEvent]
	// Set to true if read events were truncated due to the :ref:`max_buffered_rx_bytes
	// <envoy_v3_api_field_config.tap.v3.OutputConfig.max_buffered_rx_bytes>` setting.
	read_truncated?: bool
	// Set to true if write events were truncated due to the :ref:`max_buffered_tx_bytes
	// <envoy_v3_api_field_config.tap.v3.OutputConfig.max_buffered_tx_bytes>` setting.
	write_truncated?: bool
}

// A streamed socket trace segment. Multiple segments make up a full trace.
#SocketStreamedTraceSegment: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.SocketStreamedTraceSegment"
	// Trace ID unique to the originating Envoy only. Trace IDs can repeat and should not be used
	// for long term stable uniqueness. Matches connection IDs used in Envoy logs.
	trace_id?: uint64
	// Connection properties.
	connection?: #Connection
	// Socket event.
	event?: #SocketEvent
}

// Data read by Envoy from the transport socket.
#SocketEvent_Read: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.SocketEvent_Read"
	// Binary data read.
	data?: #Body
}

// Data written by Envoy to the transport socket.
#SocketEvent_Write: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.SocketEvent_Write"
	// Binary data written.
	data?: #Body
	// Stream was half closed after this write.
	end_stream?: bool
}

// The connection was closed.
#SocketEvent_Closed: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.SocketEvent_Closed"
}
