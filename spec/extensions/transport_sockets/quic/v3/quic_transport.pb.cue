package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
)

// Configuration for Downstream QUIC transport socket. This provides Google's implementation of Google QUIC and IETF QUIC to Envoy.
#QuicDownstreamTransport: {
	"@type":                 "type.googleapis.com/envoy.extensions.transport_sockets.quic.v3.QuicDownstreamTransport"
	downstream_tls_context?: v3.#DownstreamTlsContext
	// If false, QUIC will tell TLS to reject any early data and to stop issuing 0-RTT credentials
	// with resumption session tickets. This will prevent clients from sending 0-RTT requests.
	// Defaults to true, except when a client certificate validation context is configured, in which
	// case it defaults to false. Early data requires resumption, so it cannot be enabled unless
	// :ref:`enable_resumption
	// <envoy_v3_api_field_extensions.transport_sockets.quic.v3.QuicDownstreamTransport.enable_resumption>`
	// is also true.
	enable_early_data?: bool
	// If false, TLS session tickets are not issued and accepted by QUIC.
	// Defaults to true, except when a client certificate validation context is configured, in which
	// case it defaults to false. QUIC does not re-validate the client certificate when a session is
	// resumed. A resumed connection reuses the certificate verdict of the original handshake until the
	// ticket expires, so certificate revocation or expiry and validation context changes are not
	// rechecked. Setting this to true on a filter chain that validates a client certificate opts into
	// that trade-off in exchange for cheaper handshakes. Resumption also requires
	// :ref:`disable_stateless_session_resumption
	// <envoy_v3_api_field_extensions.transport_sockets.tls.v3.DownstreamTlsContext.disable_stateless_session_resumption>`
	// to be false, because that field controls the underlying TLS session tickets.
	enable_resumption?: bool
}

// Configuration for Upstream QUIC transport socket. This provides Google's implementation of Google QUIC and IETF QUIC to Envoy.
#QuicUpstreamTransport: {
	"@type":               "type.googleapis.com/envoy.extensions.transport_sockets.quic.v3.QuicUpstreamTransport"
	upstream_tls_context?: v3.#UpstreamTlsContext
}
