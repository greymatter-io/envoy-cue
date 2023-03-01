package v3

// Configuration for FixedServerPreferredAddressConfig.
#FixedServerPreferredAddressConfig: {
	"@type": "type.googleapis.com/envoy.extensions.quic.server_preferred_address.v3.FixedServerPreferredAddressConfig"
	// String representation of IPv4 address, i.e. "127.0.0.2".
	// If not specified, none will be configured.
	ipv4_address?: string
	// String representation of IPv6 address, i.e. "::1".
	// If not specified, none will be configured.
	ipv6_address?: string
}
