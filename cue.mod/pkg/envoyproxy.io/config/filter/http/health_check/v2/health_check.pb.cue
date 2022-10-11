package v2

import (
	_type "envoyproxy.io/type"
	route "envoyproxy.io/api/v2/route"
)

// [#next-free-field: 6]
#HealthCheck: {
	"@type": "type.googleapis.com/envoy.config.filter.http.health_check.v2.HealthCheck"
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
	cluster_min_healthy_percentages?: [string]: _type.#Percent
	// Specifies a set of health check request headers to match on. The health check filter will
	// check a request’s headers against all the specified headers. To specify the health check
	// endpoint, set the ``:path`` header to match on.
	headers?: [...route.#HeaderMatcher]
}
