package v3

import (
	v3 "envoyproxy.io/extensions/common/dynamic_forward_proxy/v3"
)

// Configuration for the SNI-based dynamic forward proxy filter. See the
// :ref:`architecture overview <arch_overview_http_dynamic_forward_proxy>` for
// more information. Note this filter must be configured along with
// :ref:`TLS inspector listener filter <config_listener_filters_tls_inspector>`
// to work.
// [#extension: envoy.filters.network.sni_dynamic_forward_proxy]
#FilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sni_dynamic_forward_proxy.v3.FilterConfig"
	// The DNS cache configuration that the filter will attach to. Note this
	// configuration must match that of associated :ref:`dynamic forward proxy
	// cluster configuration
	// <envoy_v3_api_field_extensions.clusters.dynamic_forward_proxy.v3.ClusterConfig.dns_cache_config>`.
	dns_cache_config?: v3.#DnsCacheConfig
	// The port number to connect to the upstream.
	port_value?: uint32
}
