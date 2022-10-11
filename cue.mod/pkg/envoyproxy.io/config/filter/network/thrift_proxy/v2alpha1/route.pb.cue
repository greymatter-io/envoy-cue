package v2alpha1

import (
	core "envoyproxy.io/api/v2/core"
	route "envoyproxy.io/api/v2/route"
)

#RouteConfiguration: {
	"@type": "type.googleapis.com/envoy.config.filter.network.thrift_proxy.v2alpha1.RouteConfiguration"
	// The name of the route configuration. Reserved for future use in asynchronous route discovery.
	name?: string
	// The list of routes that will be matched, in order, against incoming requests. The first route
	// that matches will be used.
	routes?: [...#Route]
}

#Route: {
	"@type": "type.googleapis.com/envoy.config.filter.network.thrift_proxy.v2alpha1.Route"
	// Route matching parameters.
	match?: #RouteMatch
	// Route request to some upstream cluster.
	route?: #RouteAction
}

#RouteMatch: {
	"@type": "type.googleapis.com/envoy.config.filter.network.thrift_proxy.v2alpha1.RouteMatch"
	// If specified, the route must exactly match the request method name. As a special case, an
	// empty string matches any request method name.
	method_name?: string
	// If specified, the route must have the service name as the request method name prefix. As a
	// special case, an empty string matches any service name. Only relevant when service
	// multiplexing.
	service_name?: string
	// Inverts whatever matching is done in the :ref:`method_name
	// <envoy_api_field_config.filter.network.thrift_proxy.v2alpha1.RouteMatch.method_name>` or
	// :ref:`service_name
	// <envoy_api_field_config.filter.network.thrift_proxy.v2alpha1.RouteMatch.service_name>` fields.
	// Cannot be combined with wildcard matching as that would result in routes never being matched.
	//
	// .. note::
	//
	//   This does not invert matching done as part of the :ref:`headers field
	//   <envoy_api_field_config.filter.network.thrift_proxy.v2alpha1.RouteMatch.headers>` field. To
	//   invert header matching, see :ref:`invert_match
	//   <envoy_api_field_route.HeaderMatcher.invert_match>`.
	invert?: bool
	// Specifies a set of headers that the route should match on. The router will check the request’s
	// headers against all the specified headers in the route config. A match will happen if all the
	// headers in the route are present in the request with the same values (or based on presence if
	// the value field is not in the config). Note that this only applies for Thrift transports and/or
	// protocols that support headers.
	headers?: [...route.#HeaderMatcher]
}

// [#next-free-field: 7]
#RouteAction: {
	"@type": "type.googleapis.com/envoy.config.filter.network.thrift_proxy.v2alpha1.RouteAction"
	// Indicates a single upstream cluster to which the request should be routed
	// to.
	cluster?: string
	// Multiple upstream clusters can be specified for a given route. The
	// request is routed to one of the upstream clusters based on weights
	// assigned to each cluster.
	weighted_clusters?: #WeightedCluster
	// Envoy will determine the cluster to route to by reading the value of the
	// Thrift header named by cluster_header from the request headers. If the
	// header is not found or the referenced cluster does not exist Envoy will
	// respond with an unknown method exception or an internal error exception,
	// respectively.
	cluster_header?: string
	// Optional endpoint metadata match criteria used by the subset load balancer. Only endpoints in
	// the upstream cluster with metadata matching what is set in this field will be considered.
	// Note that this will be merged with what's provided in :ref:`WeightedCluster.metadata_match
	// <envoy_api_field_config.filter.network.thrift_proxy.v2alpha1.WeightedCluster.ClusterWeight.metadata_match>`,
	// with values there taking precedence. Keys and values should be provided under the "envoy.lb"
	// metadata key.
	metadata_match?: core.#Metadata
	// Specifies a set of rate limit configurations that could be applied to the route.
	// N.B. Thrift service or method name matching can be achieved by specifying a RequestHeaders
	// action with the header name ":method-name".
	rate_limits?: [...route.#RateLimit]
	// Strip the service prefix from the method name, if there's a prefix. For
	// example, the method call Service:method would end up being just method.
	strip_service_name?: bool
}

// Allows for specification of multiple upstream clusters along with weights that indicate the
// percentage of traffic to be forwarded to each cluster. The router selects an upstream cluster
// based on these weights.
#WeightedCluster: {
	"@type": "type.googleapis.com/envoy.config.filter.network.thrift_proxy.v2alpha1.WeightedCluster"
	// Specifies one or more upstream clusters associated with the route.
	clusters?: [...#WeightedCluster_ClusterWeight]
}

#WeightedCluster_ClusterWeight: {
	"@type": "type.googleapis.com/envoy.config.filter.network.thrift_proxy.v2alpha1.WeightedCluster_ClusterWeight"
	// Name of the upstream cluster.
	name?: string
	// When a request matches the route, the choice of an upstream cluster is determined by its
	// weight. The sum of weights across all entries in the clusters array determines the total
	// weight.
	weight?: uint32
	// Optional endpoint metadata match criteria used by the subset load balancer. Only endpoints in
	// the upstream cluster with metadata matching what is set in this field, combined with what's
	// provided in :ref:`RouteAction's metadata_match
	// <envoy_api_field_config.filter.network.thrift_proxy.v2alpha1.RouteAction.metadata_match>`,
	// will be considered. Values here will take precedence. Keys and values should be provided
	// under the "envoy.lb" metadata key.
	metadata_match?: core.#Metadata
}
