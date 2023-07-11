package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/accesslog/v3"
	v32 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/type/matcher/v3"
)

// Configuration for the UDP proxy filter.
// [#next-free-field: 10]
#UdpProxyConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.v3.UdpProxyConfig"
	// The stat prefix used when emitting UDP proxy filter stats.
	stat_prefix?: string
	// The upstream cluster to connect to.
	// This field is deprecated in favor of
	// :ref:`matcher <envoy_v3_api_field_extensions.filters.udp.udp_proxy.v3.UdpProxyConfig.matcher>`.
	//
	// Deprecated: Do not use.
	cluster?: string
	// The match tree to use when resolving route actions for incoming requests.
	// See :ref:`Routing <config_udp_listener_filters_udp_proxy_routing>` for more information.
	matcher?: v32.#Matcher
	// The idle timeout for sessions. Idle is defined as no datagrams between received or sent by
	// the session. The default if not specified is 1 minute.
	idle_timeout?: string
	// Use the remote downstream IP address as the sender IP address when sending packets to upstream hosts.
	// This option requires Envoy to be run with the ``CAP_NET_ADMIN`` capability on Linux.
	// And the IPv6 stack must be enabled on Linux kernel.
	// This option does not preserve the remote downstream port.
	// If this option is enabled, the IP address of sent datagrams will be changed to the remote downstream IP address.
	// This means that Envoy will not receive packets that are sent by upstream hosts because the upstream hosts
	// will send the packets with the remote downstream IP address as the destination. All packets will be routed
	// to the remote downstream directly if there are route rules on the upstream host side.
	// There are two options to return the packets back to the remote downstream.
	// The first one is to use DSR (Direct Server Return).
	// The other one is to configure routing rules on the upstream hosts to forward
	// all packets back to Envoy and configure iptables rules on the host running Envoy to
	// forward all packets from upstream hosts to the Envoy process so that Envoy can forward the packets to the downstream.
	// If the platform does not support this option, Envoy will raise a configuration error.
	use_original_src_ip?: bool
	// Optional configuration for UDP proxy hash policies. If hash_policies is not set, the hash-based
	// load balancing algorithms will select a host randomly. Currently the number of hash policies is
	// limited to 1.
	hash_policies?: [...#UdpProxyConfig_HashPolicy]
	// UDP socket configuration for upstream sockets. The default for
	// :ref:`prefer_gro <envoy_v3_api_field_config.core.v3.UdpSocketConfig.prefer_gro>` is true for upstream
	// sockets as the assumption is datagrams will be received from a single source.
	upstream_socket_config?: v3.#UdpSocketConfig
	// Perform per packet load balancing (upstream host selection) on each received data chunk.
	// The default if not specified is false, that means each data chunk is forwarded
	// to upstream host selected on first chunk receival for that "session" (identified by source IP/port and local IP/port).
	use_per_packet_load_balancing?: bool
	// Configuration for access logs emitted by the UDP proxy. Note that certain UDP specific data is emitted as :ref:`Dynamic Metadata <config_access_log_format_dynamic_metadata>`.
	access_log?: [...v31.#AccessLog]
}

// Specifies the UDP hash policy.
// The packets can be routed by hash policy.
#UdpProxyConfig_HashPolicy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.v3.UdpProxyConfig_HashPolicy"
	// The source IP will be used to compute the hash used by hash-based load balancing algorithms.
	source_ip?: bool
	// A given key will be used to compute the hash used by hash-based load balancing algorithms.
	// In certain cases there is a need to direct different UDP streams jointly towards the selected set of endpoints.
	// A possible use-case is VoIP telephony, where media (RTP) and its corresponding control (RTCP) belong to the same logical session,
	// although they travel in separate streams. To ensure that these pair of streams are load-balanced on session level
	// (instead of individual stream level), dynamically created listeners can use the same hash key for each stream in the session.
	key?: string
}
