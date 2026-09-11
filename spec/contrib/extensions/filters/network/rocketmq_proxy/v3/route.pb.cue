package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/route/v3"
	v32 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#RouteConfiguration: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.rocketmq_proxy.v3.RouteConfiguration"
	// The name of the route configuration.
	name?: string
	// The list of routes that will be matched, in order, against incoming requests. The first route
	// that matches will be used.
	routes?: [...#Route]
}

#Route: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.rocketmq_proxy.v3.Route"
	// Route matching parameters.
	match?: #RouteMatch
	// Route request to some upstream cluster.
	route?: #RouteAction
}

#RouteMatch: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.rocketmq_proxy.v3.RouteMatch"
	// The name of the topic.
	topic?: v3.#StringMatcher
	// Specifies a set of headers that the route should match on. The router will check the request’s
	// headers against all the specified headers in the route config. A match will happen if all the
	// headers in the route are present in the request with the same values (or based on presence if
	// the value field is not in the config).
	headers?: [...v31.#HeaderMatcher]
}

#RouteAction: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.rocketmq_proxy.v3.RouteAction"
	// Indicates the upstream cluster to which the request should be routed.
	cluster?: string
	// Optional endpoint metadata match criteria used by the subset load balancer.
	metadata_match?: v32.#Metadata
}
