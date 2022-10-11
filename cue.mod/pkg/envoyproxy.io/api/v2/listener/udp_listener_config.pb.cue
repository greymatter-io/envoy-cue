package listener

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
)

#UdpListenerConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.UdpListenerConfig"
	// Used to look up UDP listener factory, matches "raw_udp_listener" or
	// "quic_listener" to create a specific udp listener.
	// If not specified, treat as "raw_udp_listener".
	udp_listener_name?: string
	// Deprecated: Do not use.
	config?:       _struct.#Struct
	typed_config?: _
}

#ActiveRawUdpListenerConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.ActiveRawUdpListenerConfig"
}
