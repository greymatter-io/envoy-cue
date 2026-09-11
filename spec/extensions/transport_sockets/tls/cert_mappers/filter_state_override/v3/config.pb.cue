package v3

// Uses a filter state value for the key “envoy.tls.certificate_mappers.on_demand_secret“ as the
// secret resource name. This filter state is expected to be shared from the downstream connection.
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.cert_mappers.filter_state_override.v3.Config"
	// The value to use as the secret name when the filter state is absent.
	default_value?: string
}
