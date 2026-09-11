package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for DNS-over-TLS (DoT) servers.
#DnsOverTlsConfig: {
	"@type": "type.googleapis.com/envoy.extensions.network.dns_resolver.hickory.v3.DnsOverTlsConfig"
	// The list of DNS-over-TLS server addresses. The port should typically be 853.
	servers?: [...v3.#Address]
	// The SNI hostname to use for TLS verification. Required when “servers“ are specified.
	tls_server_name?: string
}

// Configuration for DNS-over-HTTPS (DoH) servers.
#DnsOverHttpsConfig: {
	"@type": "type.googleapis.com/envoy.extensions.network.dns_resolver.hickory.v3.DnsOverHttpsConfig"
	// The list of DNS-over-HTTPS endpoint URLs (e.g., “https://dns.google/dns-query“).
	server_urls?: [...string]
}

// Configuration for the Hickory DNS resolver. This resolver uses the Hickory DNS library,
// a pure Rust DNS implementation, for DNS resolution. It supports standard DNS (UDP/TCP),
// DNS-over-TLS (DoT), DNS-over-HTTPS (DoH), and “DNSSEC“ validation.
//
// The resolver runs asynchronously on its own “Tokio“ runtime threads, separate from Envoy's
// event loop threads. Results are delivered back to the calling dispatcher thread.
// [#next-free-field: 10]
#HickoryDnsResolverConfig: {
	"@type": "type.googleapis.com/envoy.extensions.network.dns_resolver.hickory.v3.HickoryDnsResolverConfig"
	// A list of DNS resolver addresses for standard UDP/TCP resolution.
	// If not specified and “use_system_config“ is not explicitly set to “false“, the system
	// configuration (“/etc/resolv.conf“ on Unix) will be used.
	resolvers?: [...v3.#Address]
	// Configuration for DNS-over-TLS (DoT). When specified, queries will be sent over TLS
	// to the configured servers.
	dns_over_tls?: #DnsOverTlsConfig
	// Configuration for DNS-over-HTTPS (DoH). When specified, queries will be sent over
	// HTTPS to the configured endpoints.
	dns_over_https?: #DnsOverHttpsConfig
	// Enables “DNSSEC“ validation for DNS responses. When enabled, the resolver will validate
	// “DNSSEC“ signatures and reject responses that fail validation.
	//
	// Defaults to “false“.
	enable_dnssec?: bool
	// Maximum number of entries in the DNS response cache. The cache uses an LRU eviction
	// policy and supports negative caching (caching of “NXDOMAIN“/“NODATA“ responses).
	//
	// Defaults to “1024“.
	cache_size?: uint32
	// Number of threads in the “Tokio“ runtime used for asynchronous DNS resolution.
	// Each resolver instance runs its own “Tokio“ runtime.
	//
	// Defaults to “2“. Maximum is “16“.
	num_resolver_threads?: uint32
	// If “true“, read the system DNS configuration (“/etc/resolv.conf“ on Unix) for name server
	// addresses and search domains. When “resolvers“ are also specified, they take precedence
	// over the system configuration.
	//
	// If not specified, defaults to “true“ when no “resolvers“, “dns_over_tls“, or
	// “dns_over_https“ are configured.
	use_system_config?: bool
	// Timeout for each individual DNS query attempt.
	//
	// Defaults to “5“ seconds.
	query_timeout?: string
	// Maximum number of query attempts before the resolver gives up. Each attempt may use
	// a different name server.
	//
	// Defaults to “3“.
	query_tries?: uint32
}
