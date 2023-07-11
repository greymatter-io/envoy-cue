package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/route/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v32 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
	v33 "envoyproxy.io/envoy-cue/spec/type/v3"
)

// [#next-free-field: 6]
#RouteConfiguration: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dubbo_proxy.v3.RouteConfiguration"
	// The name of the route configuration. Reserved for future use in asynchronous route discovery.
	name?: string
	// The interface name of the service. Wildcard interface are supported in the suffix or prefix form.
	// e.g. ``*.methods.add`` will match ``com.dev.methods.add``, ``com.prod.methods.add``, etc.
	// ``com.dev.methods.*`` will match ``com.dev.methods.add``, ``com.dev.methods.update``, etc.
	// Special wildcard ``*`` matching any interface.
	//
	// .. note::
	//
	//  The wildcard will not match the empty string.
	//  e.g. ``*.methods.add`` will match ``com.dev.methods.add`` but not ``.methods.add``.
	interface?: string
	// Which group does the interface belong to.
	group?: string
	// The version number of the interface.
	version?: string
	// The list of routes that will be matched, in order, against incoming requests. The first route
	// that matches will be used.
	routes?: [...#Route]
}

#Route: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dubbo_proxy.v3.Route"
	// Route matching parameters.
	match?: #RouteMatch
	// Route request to some upstream cluster.
	route?: #RouteAction
}

#RouteMatch: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dubbo_proxy.v3.RouteMatch"
	// Method level routing matching.
	method?: #MethodMatch
	// Specifies a set of headers that the route should match on. The router will check the request’s
	// headers against all the specified headers in the route config. A match will happen if all the
	// headers in the route are present in the request with the same values (or based on presence if
	// the value field is not in the config).
	headers?: [...v3.#HeaderMatcher]
}

#RouteAction: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dubbo_proxy.v3.RouteAction"
	// Indicates the upstream cluster to which the request should be routed.
	cluster?: string
	// Multiple upstream clusters can be specified for a given route. The
	// request is routed to one of the upstream clusters based on weights
	// assigned to each cluster.
	// Currently ClusterWeight only supports the name and weight fields.
	weighted_clusters?: v3.#WeightedCluster
	// Optional endpoint metadata match criteria used by the subset load balancer. Only endpoints in
	// the upstream cluster with metadata matching what is set in this field will be considered for
	// load balancing. The filter name should be specified as ``envoy.lb``.
	metadata_match?: v31.#Metadata
}

#MethodMatch: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dubbo_proxy.v3.MethodMatch"
	// The name of the method.
	name?: v32.#StringMatcher
	// Method parameter definition.
	// The key is the parameter index, starting from 0.
	// The value is the parameter matching type.
	params_match?: [uint32]: #MethodMatch_ParameterMatchSpecifier
}

#MultipleRouteConfiguration: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dubbo_proxy.v3.MultipleRouteConfiguration"
	// The name of the named route configurations. This name is used in asynchronous route discovery.
	name?: string
	// The route table of the dubbo connection manager.
	route_config?: [...#RouteConfiguration]
}

// The parameter matching type.
#MethodMatch_ParameterMatchSpecifier: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dubbo_proxy.v3.MethodMatch_ParameterMatchSpecifier"
	// If specified, header match will be performed based on the value of the header.
	exact_match?: string
	// If specified, header match will be performed based on range.
	// The rule will match if the request header value is within this range.
	// The entire request header value must represent an integer in base 10 notation: consisting
	// of an optional plus or minus sign followed by a sequence of digits. The rule will not match
	// if the header value does not represent an integer. Match will fail for empty values,
	// floating point numbers or if only a subsequence of the header value is an integer.
	//
	// Examples:
	//
	// * For range [-10,0), route will match for header value -1, but not for 0,
	//   "somestring", 10.9, "-1somestring"
	range_match?: v33.#Int64Range
}
