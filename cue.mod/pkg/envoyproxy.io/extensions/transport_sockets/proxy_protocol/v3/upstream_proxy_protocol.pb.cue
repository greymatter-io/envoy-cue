package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration for PROXY protocol socket
#ProxyProtocolUpstreamTransport: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.proxy_protocol.v3.ProxyProtocolUpstreamTransport"
	// The PROXY protocol settings
	config?: v3.#ProxyProtocolConfig
	// The underlying transport socket being wrapped.
	transport_socket?: v3.#TransportSocket
}
