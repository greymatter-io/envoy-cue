package v3

// Configuration of DNS resolver option flags which control the behavior of the DNS resolver.
#DnsResolverOptions: {
	"@type": "type.googleapis.com/envoy.config.core.v3.DnsResolverOptions"
	// Use TCP for all DNS queries instead of the default protocol UDP.
	use_tcp_for_dns_lookups?: bool
	// Do not use the default search domains; only query hostnames as-is or as aliases.
	no_default_search_domain?: bool
}

// DNS resolution configuration which includes the underlying dns resolver addresses and options.
#DnsResolutionConfig: {
	"@type": "type.googleapis.com/envoy.config.core.v3.DnsResolutionConfig"
	// A list of dns resolver addresses. If specified, the DNS client library will perform resolution
	// via the underlying DNS resolvers. Otherwise, the default system resolvers
	// (e.g., /etc/resolv.conf) will be used.
	resolvers?: [...#Address]
	// Configuration of DNS resolver option flags which control the behavior of the DNS resolver.
	dns_resolver_options?: #DnsResolverOptions
}
