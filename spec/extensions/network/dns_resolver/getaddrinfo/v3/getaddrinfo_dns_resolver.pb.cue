package v3

// Configuration for getaddrinfo DNS resolver. This resolver will use the system's getaddrinfo()
// function to resolve hosts.
//
// .. attention::
//
//	Resolutions currently use a hard coded TTL of 60s because the getaddrinfo() API does not
//	provide the actual TTL. Configuration for this can be added in the future if needed.
#GetAddrInfoDnsResolverConfig: {
	"@type": "type.googleapis.com/envoy.extensions.network.dns_resolver.getaddrinfo.v3.GetAddrInfoDnsResolverConfig"
	// Specifies the number of retries before the resolver gives up. If not specified, the resolver will
	// retry indefinitely until it succeeds or the DNS query times out.
	num_retries?: uint32
	// Specifies the number of threads used to resolve pending DNS queries. If not specified, one thread is used.
	num_resolver_threads?: uint32
}
