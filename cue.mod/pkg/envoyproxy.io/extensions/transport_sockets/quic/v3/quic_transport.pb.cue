package v3

import (
	v3 "envoyproxy.io/extensions/transport_sockets/tls/v3"
)

// Configuration for Downstream QUIC transport socket. This provides Google's implementation of Google QUIC and IETF QUIC to Envoy.
#QuicDownstreamTransport: {
	"@type":                 "type.googleapis.com/envoy.extensions.transport_sockets.quic.v3.QuicDownstreamTransport"
	downstream_tls_context?: v3.#DownstreamTlsContext
	// If false, QUIC will tell TLS to reject any early data and to stop issuing 0-RTT credentials with resumption session tickets. This will prevent clients from sending 0-RTT requests.
	// Default to true.
	enable_early_data?: bool
}

// Configuration for Upstream QUIC transport socket. This provides Google's implementation of Google QUIC and IETF QUIC to Envoy.
#QuicUpstreamTransport: {
	"@type":               "type.googleapis.com/envoy.extensions.transport_sockets.quic.v3.QuicUpstreamTransport"
	upstream_tls_context?: v3.#UpstreamTlsContext
}
