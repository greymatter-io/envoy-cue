package v3

// Configuration for getaddrinfo DNS resolver. This resolver will use the system's getaddrinfo()
// function to resolve hosts.
//
// .. attention::
//
//   This resolver uses a single background thread to do resolutions. As such, it is not currently
//   advised for use in situations requiring a high resolution rate. A thread pool can be added
//   in the future if needed.
//
// .. attention::
//
//   Resolutions currently use a hard coded TTL of 60s because the getaddrinfo() API does not
//   provide the actual TTL. Configuration for this can be added in the future if needed.
#GetAddrInfoDnsResolverConfig: {
	"@type": "type.googleapis.com/envoy.extensions.network.dns_resolver.getaddrinfo.v3.GetAddrInfoDnsResolverConfig"
}
