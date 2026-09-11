package listener

import (
	structpb "envoyproxy.io/envoy-cue/spec/deps/protobuf/types/known/structpb"
)

#UdpListenerConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.UdpListenerConfig"
	// Used to look up UDP listener factory, matches "raw_udp_listener" or
	// "quic_listener" to create a specific udp listener.
	// If not specified, treat as "raw_udp_listener".
	udp_listener_name?: string
	// Deprecated: Marked as deprecated in envoy/api/v2/listener/udp_listener_config.proto.
	config?:       structpb.#Struct
	typed_config?: _
}

#ActiveRawUdpListenerConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.ActiveRawUdpListenerConfig"
}
