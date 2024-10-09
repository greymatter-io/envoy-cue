package v3

import (
	v3 "envoyproxy.io/config/core/v3"
	v31 "envoyproxy.io/extensions/filters/network/http_connection_manager/v3"
	v32 "envoyproxy.io/config/accesslog/v3"
)

// [#next-free-field: 8]
#GenericProxy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.v3.GenericProxy"
	// The human readable prefix to use when emitting statistics.
	stat_prefix?: string
	// The codec which encodes and decodes the application protocol.
	// [#extension-category: envoy.generic_proxy.codecs]
	codec_config?: v3.#TypedExtensionConfig
	// The generic proxies route table will be dynamically loaded via the meta RDS API.
	generic_rds?: #GenericRds
	// The route table for the generic proxy is static and is specified in this property.
	route_config?: #RouteConfiguration
	// A list of individual Layer-7 filters that make up the filter chain for requests made to the
	// proxy. Order matters as the filters are processed sequentially as request events
	// happen.
	// [#extension-category: envoy.generic_proxy.filters]
	filters?: [...v3.#TypedExtensionConfig]
	// Tracing configuration for the generic proxy.
	tracing?: v31.#HttpConnectionManager_Tracing
	// Configuration for :ref:`access logs <arch_overview_access_logs>` emitted by generic proxy.
	access_log?: [...v32.#AccessLog]
}

#GenericRds: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.v3.GenericRds"
	// Configuration source specifier for RDS.
	config_source?: v3.#ConfigSource
	// The name of the route configuration. This name will be passed to the RDS API. This allows an
	// Envoy configuration with multiple generic proxies to use different route configurations.
	route_config_name?: string
}
