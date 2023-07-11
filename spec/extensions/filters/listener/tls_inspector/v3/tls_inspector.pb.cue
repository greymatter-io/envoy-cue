package v3

#TlsInspector: {
	"@type": "type.googleapis.com/envoy.extensions.filters.listener.tls_inspector.v3.TlsInspector"
	// Populate ``JA3`` fingerprint hash using data from the TLS Client Hello packet. Default is false.
	enable_ja3_fingerprinting?: bool
}
