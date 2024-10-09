package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration for FixedServerPreferredAddressConfig.
#FixedServerPreferredAddressConfig: {
	"@type": "type.googleapis.com/envoy.extensions.quic.server_preferred_address.v3.FixedServerPreferredAddressConfig"
	// String representation of IPv4 address, i.e. "127.0.0.2".
	// If not specified, none will be configured.
	ipv4_address?: string
	// The IPv4 address to advertise to clients for Server Preferred Address.
	// This field takes precedence over
	// :ref:`ipv4_address <envoy_v3_api_field_extensions.quic.server_preferred_address.v3.FixedServerPreferredAddressConfig.ipv4_address>`.
	ipv4_config?: #FixedServerPreferredAddressConfig_AddressFamilyConfig
	// String representation of IPv6 address, i.e. "::1".
	// If not specified, none will be configured.
	ipv6_address?: string
	// The IPv6 address to advertise to clients for Server Preferred Address.
	// This field takes precedence over
	// :ref:`ipv6_address <envoy_v3_api_field_extensions.quic.server_preferred_address.v3.FixedServerPreferredAddressConfig.ipv6_address>`.
	ipv6_config?: #FixedServerPreferredAddressConfig_AddressFamilyConfig
}

// Addresses for server preferred address for a single address family (IPv4 or IPv6).
#FixedServerPreferredAddressConfig_AddressFamilyConfig: {
	"@type": "type.googleapis.com/envoy.extensions.quic.server_preferred_address.v3.FixedServerPreferredAddressConfig_AddressFamilyConfig"
	// The server preferred address sent to clients.
	//
	// Note: Envoy currently must receive all packets for a QUIC connection on the same port, so unless
	// :ref:`dnat_address <envoy_v3_api_field_extensions.quic.server_preferred_address.v3.FixedServerPreferredAddressConfig.AddressFamilyConfig.dnat_address>`
	// is configured, the port for this address must be zero, and the listener's
	// port will be used instead.
	address?: v3.#SocketAddress
	// If there is a DNAT between the client and Envoy, the address that Envoy will observe
	// server preferred address packets being sent to. If this is not specified, it is assumed
	// there is no DNAT and the server preferred address packets will be sent to the address advertised
	// to clients for server preferred address.
	//
	// Note: Envoy currently must receive all packets for a QUIC connection on the same port, so the
	// port for this address must be zero, and the listener's port will be used instead.
	dnat_address?: v3.#SocketAddress
}
