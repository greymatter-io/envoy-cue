package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
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
	// .. note::
	//
	//	Envoy currently requires all packets for a QUIC connection to arrive on the same port. Therefore, unless a
	//	:ref:`dnat_address <envoy_v3_api_field_extensions.quic.server_preferred_address.v3.FixedServerPreferredAddressConfig.AddressFamilyConfig.dnat_address>`
	//	is explicitly configured, the port specified here must be set to zero. In such cases, Envoy will automatically
	//	use the listener's port.
	address?: v3.#SocketAddress
	// If a DNAT exists between the client and Envoy, this is the address where Envoy will observe incoming server
	// preferred address packets. If unspecified, Envoy assumes there is no DNAT, and packets will be sent directly
	// to the address advertised to clients as the server preferred address.
	//
	// .. note::
	//
	//	Envoy currently requires all packets for a QUIC connection to arrive on the same port. Consequently, the
	//	port for this address must be set to zero, with Envoy defaulting to the listener's port instead.
	dnat_address?: v3.#SocketAddress
}
