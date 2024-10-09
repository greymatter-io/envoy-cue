package v3

import (
	anypb "envoyproxy.io/deps/protobuf/types/known/anypb"
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	v3 "envoyproxy.io/config/core/v3"
	v31 "envoyproxy.io/config/accesslog/v3"
	v32 "envoyproxy.io/deps/cncf/xds/go/xds/type/matcher/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// Configuration for the UDP proxy filter.
// [#next-free-field: 14]
#UdpProxyConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.v3.UdpProxyConfig"
	// The stat prefix used when emitting UDP proxy filter stats.
	stat_prefix?: string
	// The upstream cluster to connect to.
	// This field is deprecated in favor of
	// :ref:`matcher <envoy_v3_api_field_extensions.filters.udp.udp_proxy.v3.UdpProxyConfig.matcher>`.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/udp/udp_proxy/v3/udp_proxy.proto.
	cluster?: string
	// The match tree to use when resolving route actions for incoming requests.
	// See :ref:`Routing <config_udp_listener_filters_udp_proxy_routing>` for more information.
	matcher?: v32.#Matcher
	// The idle timeout for sessions. Idle is defined as no datagrams between received or sent by
	// the session. The default if not specified is 1 minute.
	idle_timeout?: durationpb.#Duration
	// Use the remote downstream IP address as the sender IP address when sending packets to upstream hosts.
	// This option requires Envoy to be run with the “CAP_NET_ADMIN“ capability on Linux.
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
	// Only one of use_per_packet_load_balancing or session_filters can be used.
	use_per_packet_load_balancing?: bool
	// Configuration for session access logs emitted by the UDP proxy. Note that certain UDP specific data is emitted as :ref:`Dynamic Metadata <config_access_log_format_dynamic_metadata>`.
	access_log?: [...v31.#AccessLog]
	// Configuration for proxy access logs emitted by the UDP proxy. Note that certain UDP specific data is emitted as :ref:`Dynamic Metadata <config_access_log_format_dynamic_metadata>`.
	proxy_access_log?: [...v31.#AccessLog]
	// Optional session filters that will run for each UDP session.
	// Only one of use_per_packet_load_balancing or session_filters can be used.
	// [#extension-category: envoy.filters.udp.session]
	session_filters?: [...#UdpProxyConfig_SessionFilter]
	// If set, this configures UDP tunneling. See `Proxying UDP in HTTP <https://www.rfc-editor.org/rfc/rfc9298.html>`_.
	// More information can be found in the UDP Proxy and HTTP upgrade documentation.
	tunneling_config?: #UdpProxyConfig_UdpTunnelingConfig
	// Additional access log options for UDP Proxy.
	access_log_options?: #UdpProxyConfig_UdpAccessLogOptions
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

// Configuration for UDP session filters.
#UdpProxyConfig_SessionFilter: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.v3.UdpProxyConfig_SessionFilter"
	// The name of the filter configuration.
	name?: string
	// Filter specific configuration which depends on the filter being
	// instantiated. See the supported filters for further documentation.
	typed_config?: anypb.#Any
	// Configuration source specifier for an extension configuration discovery
	// service. In case of a failure and without the default configuration, the
	// UDP session will be removed.
	config_discovery?: v3.#ExtensionConfigSource
}

// Configuration for tunneling UDP over other transports or application layers.
// Tunneling is currently supported over HTTP/2.
// [#next-free-field: 12]
#UdpProxyConfig_UdpTunnelingConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.v3.UdpProxyConfig_UdpTunnelingConfig"
	// The hostname to send in the synthesized CONNECT headers to the upstream proxy.
	// This field evaluates command operators if set, otherwise returns hostname as is.
	//
	// Example: dynamically set hostname using filter state
	//
	// .. code-block:: yaml
	//
	//	tunneling_config:
	//	  proxy_host: "%FILTER_STATE(proxy.host.key:PLAIN)%"
	proxy_host?: string
	// Optional port value to add to the HTTP request URI.
	// This value can be overridden per-session by setting the required port value for
	// the filter state key “udp.connect.proxy_port“.
	proxy_port?: wrapperspb.#UInt32Value
	// The target host to send in the synthesized CONNECT headers to the upstream proxy.
	// This field evaluates command operators if set, otherwise returns hostname as is.
	//
	// Example: dynamically set target host using filter state
	//
	// .. code-block:: yaml
	//
	//	tunneling_config:
	//	  target_host: "%FILTER_STATE(target.host.key:PLAIN)%"
	target_host?: string
	// The default target port to send in the CONNECT headers to the upstream proxy.
	// This value can be overridden per-session by setting the required port value for
	// the filter state key “udp.connect.target_port“.
	default_target_port?: uint32
	// Use POST method instead of CONNECT method to tunnel the UDP stream.
	//
	// .. note::
	//
	//	If use_post is set, the upstream stream does not comply with the connect-udp RFC, and
	//	instead it will be a POST request. the path used in the headers will be set from the
	//	post_path field, and the headers will not contain the target host and target port, as
	//	required by the connect-udp protocol. This flag should be used carefully.
	use_post?: bool
	// The path used with POST method. Default path is “/“. If post path is specified and
	// use_post field isn't true, it will be rejected.
	post_path?: string
	// Optional retry options, in case connecting to the upstream failed.
	retry_options?: #UdpProxyConfig_UdpTunnelingConfig_RetryOptions
	// Additional request headers to upstream proxy. Neither “:-prefixed“ pseudo-headers
	// nor the Host: header can be overridden. Values of the added headers evaluates command
	// operators if they are set in the value template.
	//
	// Example: dynamically set a header with the local port
	//
	// .. code-block:: yaml
	//
	//	headers_to_add:
	//	- header:
	//	    key: original_dst_port
	//	    value: "%DOWNSTREAM_LOCAL_PORT%"
	headers_to_add?: [...v3.#HeaderValueOption]
	// If configured, the filter will buffer datagrams in case that it is waiting for the upstream to be
	// ready, whether if it is during the connection process or due to upstream buffer watermarks.
	// If this field is not configured, there will be no buffering and downstream datagrams that arrive
	// while the upstream is not ready will be dropped. In case this field is set but the options
	// are not configured, the default values will be applied as described in the “BufferOptions“.
	buffer_options?: #UdpProxyConfig_UdpTunnelingConfig_BufferOptions
	// Save the response headers to the downstream info filter state for consumption
	// by the session filters. The filter state key is “envoy.udp_proxy.propagate_response_headers“.
	propagate_response_headers?: bool
	// Save the response trailers to the downstream info filter state for consumption
	// by the session filters. The filter state key is “envoy.udp_proxy.propagate_response_trailers“.
	propagate_response_trailers?: bool
}

#UdpProxyConfig_UdpAccessLogOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.v3.UdpProxyConfig_UdpAccessLogOptions"
	// The interval to flush access log. The UDP proxy will flush only one access log when the session
	// is ended by default. If this field is set, the UDP proxy will flush access log periodically with
	// the specified interval.
	// This field does not require on-tunnel-connected access logging enabled, and the other way around.
	// The interval must be at least 1ms.
	access_log_flush_interval?: durationpb.#Duration
	// If set to true and UDP tunneling is configured, access log will be flushed when the UDP proxy has successfully
	// established a connection tunnel with the upstream. If the connection failed, the access log will not be flushed.
	flush_access_log_on_tunnel_connected?: bool
}

// Configuration for UDP datagrams buffering.
#UdpProxyConfig_UdpTunnelingConfig_BufferOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.v3.UdpProxyConfig_UdpTunnelingConfig_BufferOptions"
	// If set, the filter will only buffer datagrams up to the requested limit, and will drop
	// new UDP datagrams if the buffer contains the max_buffered_datagrams value at the time
	// of a new datagram arrival. If not set, the default value is 1024 datagrams.
	max_buffered_datagrams?: wrapperspb.#UInt32Value
	// If set, the filter will only buffer datagrams up to the requested total buffered bytes limit,
	// and will drop new UDP datagrams if the buffer contains the max_buffered_datagrams value
	// at the time of a new datagram arrival. If not set, the default value is 16,384 (16KB).
	max_buffered_bytes?: wrapperspb.#UInt64Value
}

#UdpProxyConfig_UdpTunnelingConfig_RetryOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.v3.UdpProxyConfig_UdpTunnelingConfig_RetryOptions"
	// The maximum number of unsuccessful connection attempts that will be made before giving up.
	// If the parameter is not specified, 1 connection attempt will be made.
	max_connect_attempts?: wrapperspb.#UInt32Value
}
