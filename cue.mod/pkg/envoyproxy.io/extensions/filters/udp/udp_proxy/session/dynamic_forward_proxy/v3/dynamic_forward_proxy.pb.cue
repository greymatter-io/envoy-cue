package v3

import (
	v3 "envoyproxy.io/extensions/common/dynamic_forward_proxy/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// Configuration for the filter state based dynamic forward proxy filter. See the
// :ref:`architecture overview <arch_overview_http_dynamic_forward_proxy>` for
// more information. Note this filter must be used in conjunction to another filter that
// sets the 'envoy.upstream.dynamic_host' and the 'envoy.upstream.dynamic_port' filter
// state keys for the required upstream UDP session.
// [#extension: envoy.filters.udp.session.dynamic_forward_proxy]
#FilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.session.dynamic_forward_proxy.v3.FilterConfig"
	// The prefix to use when emitting :ref:`statistics <config_udp_session_filters_dynamic_forward_proxy_stats>`.
	stat_prefix?: string
	// The DNS cache configuration that the filter will attach to. Note this
	// configuration must match that of associated :ref:`dynamic forward proxy cluster configuration
	// <envoy_v3_api_field_extensions.clusters.dynamic_forward_proxy.v3.ClusterConfig.dns_cache_config>`.
	dns_cache_config?: v3.#DnsCacheConfig
	// If configured, the filter will buffer datagrams in case that it is waiting for a DNS response.
	// If this field is not configured, there will be no buffering and downstream datagrams that arrive
	// while the DNS resolution is in progress will be dropped. In case this field is set but the options
	// are not configured, the default values will be applied as described in the “BufferOptions“.
	buffer_options?: #FilterConfig_BufferOptions
}

// Configuration for UDP datagrams buffering.
#FilterConfig_BufferOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.udp_proxy.session.dynamic_forward_proxy.v3.FilterConfig_BufferOptions"
	// If set, the filter will only buffer datagrams up to the requested limit, and will drop
	// new UDP datagrams if the buffer contains the max_buffered_datagrams value at the time
	// of a new datagram arrival. If not set, the default value is 1024 datagrams.
	max_buffered_datagrams?: wrapperspb.#UInt32Value
	// If set, the filter will only buffer datagrams up to the requested total buffered bytes limit,
	// and will drop new UDP datagrams if the buffer contains the max_buffered_datagrams value
	// at the time of a new datagram arrival. If not set, the default value is 16,384 (16KB).
	max_buffered_bytes?: wrapperspb.#UInt64Value
}
