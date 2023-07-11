package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/data/dns/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for the DNS filter.
#DnsFilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.dns_filter.v3.DnsFilterConfig"
	// The stat prefix used when emitting DNS filter statistics
	stat_prefix?: string
	// Server context configuration contains the data that the filter uses to respond
	// to DNS requests.
	server_config?: #DnsFilterConfig_ServerContextConfig
	// Client context configuration controls Envoy's behavior when it must use external
	// resolvers to answer a query. This object is optional and if omitted instructs
	// the filter to resolve queries from the data in the server_config
	client_config?: #DnsFilterConfig_ClientContextConfig
}

// This message contains the configuration for the DNS Filter operating
// in a server context. This message will contain the virtual hosts and
// associated addresses with which Envoy will respond to queries
#DnsFilterConfig_ServerContextConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.dns_filter.v3.DnsFilterConfig_ServerContextConfig"
	// Load the configuration specified from the control plane
	inline_dns_table?: v3.#DnsTable
	// Seed the filter configuration from an external path. This source
	// is a yaml formatted file that contains the DnsTable driving Envoy's
	// responses to DNS queries
	external_dns_table?: v31.#DataSource
}

// This message contains the configuration for the DNS Filter operating
// in a client context. This message will contain the timeouts, retry,
// and forwarding configuration for Envoy to make DNS requests to other
// resolvers
//
// [#next-free-field: 6]
#DnsFilterConfig_ClientContextConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.dns_filter.v3.DnsFilterConfig_ClientContextConfig"
	// Sets the maximum time we will wait for the upstream query to complete
	// We allow 5s for the upstream resolution to complete, so the minimum
	// value here is 1. Note that the total latency for a failed query is the
	// number of retries multiplied by the resolver_timeout.
	resolver_timeout?: string
	// This field was used for `dns_resolution_config` in Envoy 1.19.0 and
	// 1.19.1.
	// Control planes that need to set this field for Envoy 1.19.0 and
	// 1.19.1 clients should fork the protobufs and change the field type
	// to `DnsResolutionConfig`.
	// Control planes that need to simultaneously support Envoy 1.18.x and
	// Envoy 1.19.x should avoid Envoy 1.19.0 and 1.19.1.
	//
	// [#not-implemented-hide:]
	//
	// Deprecated: Do not use.
	upstream_resolvers?: [...v31.#Address]
	// DNS resolution configuration which includes the underlying dns resolver addresses and options.
	// This field is deprecated in favor of
	// :ref:`typed_dns_resolver_config <envoy_v3_api_field_extensions.filters.udp.dns_filter.v3.DnsFilterConfig.ClientContextConfig.typed_dns_resolver_config>`.
	//
	// Deprecated: Do not use.
	dns_resolution_config?: v31.#DnsResolutionConfig
	// DNS resolver type configuration extension. This extension can be used to configure c-ares, apple,
	// or any other DNS resolver types and the related parameters.
	// For example, an object of
	// :ref:`CaresDnsResolverConfig <envoy_v3_api_msg_extensions.network.dns_resolver.cares.v3.CaresDnsResolverConfig>`
	// can be packed into this ``typed_dns_resolver_config``. This configuration replaces the
	// :ref:`dns_resolution_config <envoy_v3_api_field_extensions.filters.udp.dns_filter.v3.DnsFilterConfig.ClientContextConfig.dns_resolution_config>`
	// configuration.
	// During the transition period when both ``dns_resolution_config`` and ``typed_dns_resolver_config`` exists,
	// when ``typed_dns_resolver_config`` is in place, Envoy will use it and ignore ``dns_resolution_config``.
	// When ``typed_dns_resolver_config`` is missing, the default behavior is in place.
	// [#extension-category: envoy.network.dns_resolver]
	typed_dns_resolver_config?: v31.#TypedExtensionConfig
	// Controls how many outstanding external lookup contexts the filter tracks.
	// The context structure allows the filter to respond to every query even if the external
	// resolution times out or is otherwise unsuccessful
	max_pending_lookups?: uint64
}
