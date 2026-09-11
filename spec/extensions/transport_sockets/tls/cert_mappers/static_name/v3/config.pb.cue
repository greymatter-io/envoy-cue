package v3

// A mapping to a fixed secret name for all certificates.
#StaticName: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.cert_mappers.static_name.v3.StaticName"
	// The name for the secret to use for all connections.
	name?: string
}
