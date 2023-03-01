package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration specific to the UDP QUIC listener.
// [#next-free-field: 10]
#QuicProtocolOptions: {
	"@type":                "type.googleapis.com/envoy.config.listener.v3.QuicProtocolOptions"
	quic_protocol_options?: v3.#QuicProtocolOptions
	// Maximum number of milliseconds that connection will be alive when there is
	// no network activity.
	//
	// If it is less than 1ms, Envoy will use 1ms. 300000ms if not specified.
	idle_timeout?: string
	// Connection timeout in milliseconds before the crypto handshake is finished.
	//
	// If it is less than 5000ms, Envoy will use 5000ms. 20000ms if not specified.
	crypto_handshake_timeout?: string
	// Runtime flag that controls whether the listener is enabled or not. If not specified, defaults
	// to enabled.
	enabled?: v3.#RuntimeFeatureFlag
	// A multiplier to number of connections which is used to determine how many packets to read per
	// event loop. A reasonable number should allow the listener to process enough payload but not
	// starve TCP and other UDP sockets and also prevent long event loop duration.
	// The default value is 32. This means if there are N QUIC connections, the total number of
	// packets to read in each read event will be 32 * N.
	// The actual number of packets to read in total by the UDP listener is also
	// bound by 6000, regardless of this field or how many connections there are.
	packets_to_read_to_connection_count_ratio?: uint32
	// Configure which implementation of ``quic::QuicCryptoClientStreamBase`` to be used for this listener.
	// If not specified the :ref:`QUICHE default one configured by <envoy_v3_api_msg_extensions.quic.crypto_stream.v3.CryptoServerStreamConfig>` will be used.
	// [#extension-category: envoy.quic.server.crypto_stream]
	crypto_stream_config?: v3.#TypedExtensionConfig
	// Configure which implementation of ``quic::ProofSource`` to be used for this listener.
	// If not specified the :ref:`default one configured by <envoy_v3_api_msg_extensions.quic.proof_source.v3.ProofSourceConfig>` will be used.
	// [#extension-category: envoy.quic.proof_source]
	proof_source_config?: v3.#TypedExtensionConfig
	// Config which implementation of ``quic::ConnectionIdGeneratorInterface`` to be used for this listener.
	// If not specified the :ref:`default one configured by <envoy_v3_api_msg_extensions.quic.connection_id_generator.v3.DeterministicConnectionIdGeneratorConfig>` will be used.
	// [#extension-category: envoy.quic.connection_id_generator]
	connection_id_generator_config?: v3.#TypedExtensionConfig
	// Configure the server's preferred address to advertise so that client can migrate to it. See :ref:`example <envoy_v3_api_msg_extensions.quic.server_preferred_address.v3.FixedServerPreferredAddressConfig>` which configures a pair of v4 and v6 preferred addresses.
	// The current QUICHE implementation will advertise only one of the preferred IPv4 and IPv6 addresses based on the address family the client initially connects with, and only if the client is also QUICHE-based.
	// If not specified, Envoy will not advertise any server's preferred address.
	// [#extension-category: envoy.quic.server_preferred_address]
	server_preferred_address_config?: v3.#TypedExtensionConfig
}
