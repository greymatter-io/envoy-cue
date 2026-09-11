package v3

// Uses the SNI value from the TLS client hello as the secret resource name in the downstream selector.
#SNI: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.cert_mappers.sni.v3.SNI"
	// The value to use as the secret name when SNI is empty or absent.
	default_value?: string
}
