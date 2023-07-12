package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/v3"
)

// This is configuration for matching upstream ip and port.
// Note that although both fields are optional, at least one of IP or port must be supplied. If only
// one is supplied the other is a wildcard match.
// This matcher requires a filter in the chain to have saved the upstream address in the
// filter state before the matcher is executed by RBAC filter. The state should be saved with key
// ``envoy.stream.upstream_address`` (See
// :repo:`upstream_address.h<source/common/stream_info/upstream_address.h>`).
// Also, See :repo:`proxy_filter.cc<source/extensions/filters/http/dynamic_forward_proxy/proxy_filter.cc>`
// for an example of a filter which populates the FilterState.
#UpstreamIpPortMatcher: {
	"@type": "type.googleapis.com/envoy.extensions.rbac.matchers.upstream_ip_port.v3.UpstreamIpPortMatcher"
	// A CIDR block that will be used to match the upstream IP.
	// Both Ipv4 and Ipv6 ranges can be matched.
	upstream_ip?: v3.#CidrRange
	// A port range that will be used to match the upstream port.
	upstream_port_range?: v31.#Int64Range
}
