package v2alpha

import (
	core "envoyproxy.io/api/v2/core"
	v2alpha "envoyproxy.io/config/common/tap/v2alpha"
)

// Configuration for tap transport socket. This wraps another transport socket, providing the
// ability to interpose and record in plain text any traffic that is surfaced to Envoy.
#Tap: {
	"@type": "type.googleapis.com/envoy.config.transport_socket.tap.v2alpha.Tap"
	// Common configuration for the tap transport socket.
	common_config?: v2alpha.#CommonExtensionConfig
	// The underlying transport socket being wrapped.
	transport_socket?: core.#TransportSocket
}
