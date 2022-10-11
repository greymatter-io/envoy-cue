package v3

import (
	v3 "envoyproxy.io/type/v3"
	v31 "envoyproxy.io/config/route/v3"
)

// [#next-free-field: 6]
#HealthCheck: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.health_check.v3.HealthCheck"
	// Specifies whether the filter operates in pass through mode or not.
	pass_through_mode?: bool
	// If operating in pass through mode, the amount of time in milliseconds
	// that the filter should cache the upstream response.
	cache_time?: string
	// If operating in non-pass-through mode, specifies a set of upstream cluster
	// names and the minimum percentage of servers in each of those clusters that
	// must be healthy or degraded in order for the filter to return a 200.
	//
	// .. note::
	//
	//    This value is interpreted as an integer by truncating, so 12.50% will be calculated
	//    as if it were 12%.
	cluster_min_healthy_percentages?: [string]: v3.#Percent
	// Specifies a set of health check request headers to match on. The health check filter will
	// check a request’s headers against all the specified headers. To specify the health check
	// endpoint, set the ``:path`` header to match on.
	headers?: [...v31.#HeaderMatcher]
}
