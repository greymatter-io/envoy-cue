package v3

import (
	v3 "envoyproxy.io/extensions/transport_sockets/raw_buffer/v3"
	v31 "envoyproxy.io/extensions/transport_sockets/tls/v3"
)

// Configuration for a downstream StartTls transport socket.
// StartTls transport socket wraps two sockets:
// * raw_buffer socket which is used at the beginning of the session
// * TLS socket used when a protocol negotiates a switch to encrypted traffic.
#StartTlsConfig: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.starttls.v3.StartTlsConfig"
	// (optional) Configuration for clear-text socket used at the beginning of the session.
	cleartext_socket_config?: v3.#RawBuffer
	// Configuration for a downstream TLS socket.
	tls_socket_config?: v31.#DownstreamTlsContext
}

// Configuration for an upstream StartTls transport socket.
// StartTls transport socket wraps two sockets:
// * raw_buffer socket which is used at the beginning of the session
// * TLS socket used when a protocol negotiates a switch to encrypted traffic.
#UpstreamStartTlsConfig: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.starttls.v3.UpstreamStartTlsConfig"
	// (optional) Configuration for clear-text socket used at the beginning of the session.
	cleartext_socket_config?: v3.#RawBuffer
	// Configuration for an upstream TLS socket.
	tls_socket_config?: v31.#UpstreamTlsContext
}
