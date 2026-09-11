package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for c-ares DNS resolver.
// [#next-free-field: 13]
#CaresDnsResolverConfig: {
	"@type": "type.googleapis.com/envoy.extensions.network.dns_resolver.cares.v3.CaresDnsResolverConfig"
	// A list of DNS resolver addresses.
	// :ref:`use_resolvers_as_fallback <envoy_v3_api_field_extensions.network.dns_resolver.cares.v3.CaresDnsResolverConfig.use_resolvers_as_fallback>`
	// below dictates if the DNS client should override system defaults or only use the provided
	// resolvers if the system defaults are not available, i.e., as a fallback.
	resolvers?: [...v3.#Address]
	// If true use the resolvers listed in the
	// :ref:`resolvers <envoy_v3_api_field_extensions.network.dns_resolver.cares.v3.CaresDnsResolverConfig.resolvers>`
	// field only if c-ares is unable to obtain a
	// nameserver from the system (e.g., “/etc/resolv.conf“).
	// Otherwise, the resolvers listed in the resolvers list will override the default system
	// resolvers. Defaults to false.
	use_resolvers_as_fallback?: bool
	// The resolver will query available network interfaces and determine if there are no available
	// interfaces for a given IP family. It will then filter these addresses from the results it
	// presents. e.g., if there are no available IPv4 network interfaces, the resolver will not
	// provide IPv4 addresses.
	filter_unroutable_families?: bool
	// Configuration of DNS resolver option flags which control the behavior of the DNS resolver.
	dns_resolver_options?: v3.#DnsResolverOptions
	// This option allows the number of UDP based DNS queries to be capped.
	//
	// .. note::
	//
	//	This is only applicable to c-ares DNS resolver currently.
	udp_max_queries?: uint32
	// The number of seconds each name server is given to respond to a query on the first try of any given server.
	//
	// .. note::
	//
	//	While the c-ares library defaults to 2 seconds, Envoy's default (if this field is unset) is 5 seconds.
	//	This adjustment was made to maintain the previous behavior after users reported an increase in DNS resolution times.
	query_timeout_seconds?: uint64
	// The maximum number of query attempts the resolver will make before giving up.
	// Each attempt may use a different name server.
	//
	// .. note::
	//
	//	While the c-ares library defaults to 3 attempts, Envoy's default (if this field is unset) is 4 attempts.
	//	This adjustment was made to maintain the previous behavior after users reported an increase in DNS resolution times.
	query_tries?: uint32
	// Enable round-robin selection of name servers for DNS resolution. When enabled, the resolver will cycle through the
	// list of name servers for each resolution request. This can help distribute the query load across multiple name
	// servers. If disabled (default), the resolver will try name servers in the order they are configured.
	//
	// .. note::
	//
	//	This setting overrides any system configuration for name server rotation.
	rotate_nameservers?: bool
	// Maximum EDNS0 UDP payload size in bytes.
	// If set, c-ares will include EDNS0 in DNS queries and use this value as the maximum UDP response size.
	//
	// Recommended values:
	//
	// * **1232**: Safe default (avoids fragmentation).
	// * **4096**: Maximum allowed.
	//
	// If unset, c-ares uses its internal default (usually 1232).
	edns0_max_payload_size?: uint32
	// The maximum duration for which a UDP channel will be kept alive before being refreshed.
	//
	// If set, the DNS resolver will periodically reinitialize its c-ares channel after the
	// specified duration. This can help with avoiding stale socket states, and providing
	// better load distribution across UDP ports.
	//
	// If not specified, no periodic refresh will be performed.
	max_udp_channel_duration?: string
	// If true, reinitialize the c-ares channel when a DNS query fails with “ARES_ETIMEOUT“.
	//
	// This can help recover from rare cases where the UDP sockets held by the c-ares
	// channel become unusable after timeouts, causing subsequent queries to fail or
	// Envoy to keep serving stale DNS results. When enabled, a timeout-triggered
	// reinitialization attempts to restore healthy state quickly. In environments
	// where timeouts are caused by intermittent network issues, enabling this may
	// increase channel churn; consider using
	// :ref:`max_udp_channel_duration <envoy_v3_api_field_extensions.network.dns_resolver.cares.v3.CaresDnsResolverConfig.max_udp_channel_duration>`
	// for periodic refresh instead.
	//
	// Default is false.
	reinit_channel_on_timeout?: bool
	// The maximum duration (in seconds) for which DNS responses will be cached by c-ares.
	//
	// If set to a non-zero value, the query cache is enabled and will respect the
	// TTL provided in the DNS response, up to this maximum limit.
	//
	// .. note::
	//
	//	While the underlying c-ares library defaults to 1 hour, Envoy's default
	//	for this field is 0, which disables the query cache entirely.
	qcache_max_ttl?: uint32
}
