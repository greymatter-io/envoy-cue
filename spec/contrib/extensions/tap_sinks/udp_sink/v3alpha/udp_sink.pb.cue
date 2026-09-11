package v3alpha

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Udp sink configuration.
#UdpSink: {
	"@type": "type.googleapis.com/envoy.extensions.tap_sinks.udp_sink.v3alpha.UdpSink"
	// Configure UDP Address.
	udp_address?: v3.#SocketAddress
}
