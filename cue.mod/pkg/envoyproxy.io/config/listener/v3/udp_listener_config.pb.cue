package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// [#next-free-field: 9]
#UdpListenerConfig: {
	"@type": "type.googleapis.com/envoy.config.listener.v3.UdpListenerConfig"
	// UDP socket configuration for the listener. The default for
	// :ref:`prefer_gro <envoy_v3_api_field_config.core.v3.UdpSocketConfig.prefer_gro>` is false for
	// listener sockets. If receiving a large amount of datagrams from a small number of sources, it
	// may be worthwhile to enable this option after performance testing.
	downstream_socket_config?: v3.#UdpSocketConfig
	// Configuration for QUIC protocol. If empty, QUIC will not be enabled on this listener. Set
	// to the default object to enable QUIC without modifying any additional options.
	quic_options?: #QuicProtocolOptions
	// Configuration for the UDP packet writer. If empty, HTTP/3 will use GSO if available
	// (:ref:`UdpDefaultWriterFactory <envoy_v3_api_msg_extensions.udp_packet_writer.v3.UdpGsoBatchWriterFactory>`)
	// or the default kernel sendmsg if not,
	// (:ref:`UdpDefaultWriterFactory <envoy_v3_api_msg_extensions.udp_packet_writer.v3.UdpDefaultWriterFactory>`)
	// and raw UDP will use kernel sendmsg.
	// [#extension-category: envoy.udp_packet_writer]
	udp_packet_packet_writer_config?: v3.#TypedExtensionConfig
}

#ActiveRawUdpListenerConfig: {
	"@type": "type.googleapis.com/envoy.config.listener.v3.ActiveRawUdpListenerConfig"
}
