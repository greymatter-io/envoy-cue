package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/common/dynamic_forward_proxy/v3"
)

// Configuration for the dynamic forward proxy HTTP filter. See the :ref:`architecture overview
// <arch_overview_http_dynamic_forward_proxy>` for more information.
// [#extension: envoy.filters.http.dynamic_forward_proxy]
#FilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.dynamic_forward_proxy.v3.FilterConfig"
	// The DNS cache configuration that the filter will attach to. Note this configuration must
	// match that of associated :ref:`dynamic forward proxy cluster configuration
	// <envoy_v3_api_field_extensions.clusters.dynamic_forward_proxy.v3.ClusterConfig.dns_cache_config>`.
	dns_cache_config?: v3.#DnsCacheConfig
	// The configuration that the filter will use, when the related dynamic forward proxy cluster enabled
	// sub clusters.
	sub_cluster_config?: #SubClusterConfig
	// When this flag is set, the filter will add the resolved upstream address in the filter
	// state. The state should be saved with key
	// “envoy.stream.upstream_address“ (See
	// :repo:`upstream_address.h<source/common/stream_info/upstream_address.h>`).
	save_upstream_address?: bool
	// When this flag is set, the filter will check for the “envoy.upstream.dynamic_host“
	// and/or “envoy.upstream.dynamic_port“ filter state values before using the HTTP
	// Host header for DNS resolution. This provides consistency with the
	// :ref:`SNI dynamic forward proxy <envoy_v3_api_msg_extensions.filters.network.sni_dynamic_forward_proxy.v3.FilterConfig>` and
	// :ref:`UDP dynamic forward proxy <envoy_v3_api_msg_extensions.filters.udp.udp_proxy.session.dynamic_forward_proxy.v3.FilterConfig>`
	// filters behavior when enabled.
	//
	// If the flag is not set (default), the filter will use the HTTP Host header
	// for DNS resolution, maintaining backward compatibility.
	allow_dynamic_host_from_filter_state?: bool
}

// Per route Configuration for the dynamic forward proxy HTTP filter.
#PerRouteConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.dynamic_forward_proxy.v3.PerRouteConfig"
	// Indicates that before DNS lookup, the host header will be swapped with
	// this value. If not set or empty, the original host header value
	// will be used and no rewrite will happen.
	//
	// .. note::
	//
	//	This rewrite affects both DNS lookup and host header forwarding. However, this option shouldn't be used with
	//	:ref:`HCM host rewrite header <envoy_v3_api_field_config.route.v3.RouteAction.auto_host_rewrite>` given that
	//	the value set here would be used for DNS lookups whereas the value set in the HCM would be used for host
	//	header forwarding which might not be the desired outcome.
	host_rewrite_literal?: string
	// Indicates that before DNS lookup, the host header will be swapped with
	// the value of this header. If not set or empty, the original host header
	// value will be used and no rewrite will happen.
	//
	// .. note::
	//
	//	This rewrite affects both DNS lookup and host header forwarding. However, this option shouldn't be used with
	//	:ref:`HCM host rewrite header <envoy_v3_api_field_config.route.v3.RouteAction.auto_host_rewrite>` given that
	//	the value set here would be used for DNS lookups whereas the value set in the HCM would be used for host
	//	header forwarding which might not be the desired outcome.
	//
	// .. note::
	//
	//	If the header appears multiple times only the first value is used.
	host_rewrite_header?: string
}

#SubClusterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.dynamic_forward_proxy.v3.SubClusterConfig"
	// The timeout used for sub cluster initialization. Defaults to **5s** if not set.
	cluster_init_timeout?: string
}
