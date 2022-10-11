package v2alpha

import (
	v2alpha "envoyproxy.io/config/common/dynamic_forward_proxy/v2alpha"
)

// Configuration for the dynamic forward proxy HTTP filter. See the :ref:`architecture overview
// <arch_overview_http_dynamic_forward_proxy>` for more information.
// [#extension: envoy.filters.http.dynamic_forward_proxy]
#FilterConfig: {
	"@type": "type.googleapis.com/envoy.config.filter.http.dynamic_forward_proxy.v2alpha.FilterConfig"
	// The DNS cache configuration that the filter will attach to. Note this configuration must
	// match that of associated :ref:`dynamic forward proxy cluster configuration
	// <envoy_api_field_config.cluster.dynamic_forward_proxy.v2alpha.ClusterConfig.dns_cache_config>`.
	dns_cache_config?: v2alpha.#DnsCacheConfig
}

// Per route Configuration for the dynamic forward proxy HTTP filter.
#PerRouteConfig: {
	"@type": "type.googleapis.com/envoy.config.filter.http.dynamic_forward_proxy.v2alpha.PerRouteConfig"
	// Indicates that before DNS lookup, the host header will be swapped with
	// this value. If not set or empty, the original host header value
	// will be used and no rewrite will happen.
	//
	// Note: this rewrite affects both DNS lookup and host header forwarding. However, this
	// option shouldn't be used with
	// :ref:`HCM host rewrite <envoy_api_field_route.RouteAction.host_rewrite>` given that the
	// value set here would be used for DNS lookups whereas the value set in the HCM would be used
	// for host header forwarding which is not the desired outcome.
	host_rewrite?: string
	// Indicates that before DNS lookup, the host header will be swapped with
	// the value of this header. If not set or empty, the original host header
	// value will be used and no rewrite will happen.
	//
	// Note: this rewrite affects both DNS lookup and host header forwarding. However, this
	// option shouldn't be used with
	// :ref:`HCM host rewrite header <envoy_api_field_route.RouteAction.auto_host_rewrite_header>`
	// given that the value set here would be used for DNS lookups whereas the value set in the HCM
	// would be used for host header forwarding which is not the desired outcome.
	//
	// .. note::
	//
	//   If the header appears multiple times only the first value is used.
	auto_host_rewrite_header?: string
}
