package v2alpha

import (
	v2alpha "envoyproxy.io/config/common/dynamic_forward_proxy/v2alpha"
)

// Configuration for the dynamic forward proxy cluster. See the :ref:`architecture overview
// <arch_overview_http_dynamic_forward_proxy>` for more information.
// [#extension: envoy.clusters.dynamic_forward_proxy]
#ClusterConfig: {
	"@type": "type.googleapis.com/envoy.config.cluster.dynamic_forward_proxy.v2alpha.ClusterConfig"
	// The DNS cache configuration that the cluster will attach to. Note this configuration must
	// match that of associated :ref:`dynamic forward proxy HTTP filter configuration
	// <envoy_api_field_config.filter.http.dynamic_forward_proxy.v2alpha.FilterConfig.dns_cache_config>`.
	dns_cache_config?: v2alpha.#DnsCacheConfig
}
