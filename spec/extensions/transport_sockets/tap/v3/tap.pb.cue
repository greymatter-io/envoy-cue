package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/common/tap/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for tap transport socket. This wraps another transport socket, providing the
// ability to interpose and record in plain text any traffic that is surfaced to Envoy.
#Tap: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tap.v3.Tap"
	// Common configuration for the tap transport socket.
	common_config?: v3.#CommonExtensionConfig
	// The underlying transport socket being wrapped.
	transport_socket?: v31.#TransportSocket
	// Additional configurations for the transport socket tap
	socket_tap_config?: #SocketTapConfig
}

// Additional configurations for the transport socket tap
#SocketTapConfig: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tap.v3.SocketTapConfig"
	// Indicates to whether output the connection information per event
	// This is only applicable if the streamed trace is enabled
	set_connection_per_event?: bool
	// The contents of the transport tap's statistics prefix.
	stats_prefix?: string
}
