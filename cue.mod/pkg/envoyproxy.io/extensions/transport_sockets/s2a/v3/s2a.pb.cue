package v3

// [#not-implemented-hide:]
// Configuration for S2A transport socket. This allows Envoy clients to
// configure how to offload mTLS handshakes to the S2A service.
// https://github.com/google/s2a-core#readme
#S2AConfiguration: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.s2a.v3.S2AConfiguration"
	// The address of the S2A. This can be an IP address or a hostname,
	// followed by a port number.
	s2a_address?: string
}
