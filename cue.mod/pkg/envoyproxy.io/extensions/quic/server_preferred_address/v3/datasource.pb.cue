package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration for DataSourceServerPreferredAddressConfig.
#DataSourceServerPreferredAddressConfig: {
	"@type": "type.googleapis.com/envoy.extensions.quic.server_preferred_address.v3.DataSourceServerPreferredAddressConfig"
	// The IPv4 address to advertise to clients for Server Preferred Address.
	ipv4_config?: #DataSourceServerPreferredAddressConfig_AddressFamilyConfig
	// The IPv6 address to advertise to clients for Server Preferred Address.
	ipv6_config?: #DataSourceServerPreferredAddressConfig_AddressFamilyConfig
}

// Addresses for server preferred address for a single address family (IPv4 or IPv6).
#DataSourceServerPreferredAddressConfig_AddressFamilyConfig: {
	"@type": "type.googleapis.com/envoy.extensions.quic.server_preferred_address.v3.DataSourceServerPreferredAddressConfig_AddressFamilyConfig"
	// The server preferred address sent to clients. The data must contain an IP address string.
	address?: v3.#DataSource
	// The server preferred address port sent to clients. The data must contain a integer port value.
	//
	// If this is not specified, the listener's port is used.
	//
	// Note: Envoy currently must receive all packets for a QUIC connection on the same port, so unless
	// :ref:`dnat_address <envoy_v3_api_field_extensions.quic.server_preferred_address.v3.DataSourceServerPreferredAddressConfig.AddressFamilyConfig.dnat_address>`
	// is configured, this must be left unset.
	port?: v3.#DataSource
	// If there is a DNAT between the client and Envoy, the address that Envoy will observe
	// server preferred address packets being sent to. If this is not specified, it is assumed
	// there is no DNAT and the server preferred address packets will be sent to the address advertised
	// to clients for server preferred address.
	dnat_address?: v3.#DataSource
}
