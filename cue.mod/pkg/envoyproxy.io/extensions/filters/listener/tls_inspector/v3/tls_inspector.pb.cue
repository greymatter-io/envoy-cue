package v3

import (
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

#TlsInspector: {
	"@type": "type.googleapis.com/envoy.extensions.filters.listener.tls_inspector.v3.TlsInspector"
	// Populate “JA3“ fingerprint hash using data from the TLS Client Hello packet. Default is false.
	enable_ja3_fingerprinting?: wrapperspb.#BoolValue
	// The size in bytes of the initial buffer requested by the tls_inspector.
	// If the filter needs to read additional bytes from the socket, the
	// filter will double the buffer up to it's default maximum of 64KiB.
	// If this size is not defined, defaults to maximum 64KiB that the
	// tls inspector will consume.
	initial_read_buffer_size?: wrapperspb.#UInt32Value
}
