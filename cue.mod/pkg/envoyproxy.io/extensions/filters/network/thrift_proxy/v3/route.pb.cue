package v3

import (
	v3 "envoyproxy.io/config/route/v3"
	v31 "envoyproxy.io/config/core/v3"
)

#RouteConfiguration: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.RouteConfiguration"
	// The name of the route configuration. This name is used in asynchronous route discovery.
	// For example, it might match
	// :ref:`route_config_name
	// <envoy_v3_api_field_extensions.filters.network.thrift_proxy.v3.Trds.route_config_name>` in
	// :ref:`envoy_v3_api_msg_extensions.filters.network.thrift_proxy.v3.Trds`.
	name?: string
	// The list of routes that will be matched, in order, against incoming requests. The first route
	// that matches will be used.
	routes?: [...#Route]
	// An optional boolean that specifies whether the clusters that the route
	// table refers to will be validated by the cluster manager. If set to true
	// and a route refers to a non-existent cluster, the route table will not
	// load. If set to false and a route refers to a non-existent cluster, the
	// route table will load and the router filter will return a INTERNAL_ERROR
	// if the route is selected at runtime. This setting defaults to true if the route table
	// is statically defined via the :ref:`route_config
	// <envoy_v3_api_field_extensions.filters.network.thrift_proxy.v3.ThriftProxy.route_config>`
	// option. This setting default to false if the route table is loaded dynamically via the
	// :ref:`trds
	// <envoy_v3_api_field_extensions.filters.network.thrift_proxy.v3.ThriftProxy.trds>`
	// option. Users may wish to override the default behavior in certain cases (for example when
	// using CDS with a static route table).
	validate_clusters?: bool
}

#Route: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.Route"
	// Route matching parameters.
	match?: #RouteMatch
	// Route request to some upstream cluster.
	route?: #RouteAction
}

#RouteMatch: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.RouteMatch"
	// If specified, the route must exactly match the request method name. As a special case, an
	// empty string matches any request method name.
	method_name?: string
	// If specified, the route must have the service name as the request method name prefix. As a
	// special case, an empty string matches any service name. Only relevant when service
	// multiplexing.
	service_name?: string
	// Inverts whatever matching is done in the :ref:`method_name
	// <envoy_v3_api_field_extensions.filters.network.thrift_proxy.v3.RouteMatch.method_name>` or
	// :ref:`service_name
	// <envoy_v3_api_field_extensions.filters.network.thrift_proxy.v3.RouteMatch.service_name>` fields.
	// Cannot be combined with wildcard matching as that would result in routes never being matched.
	//
	// .. note::
	//
	//   This does not invert matching done as part of the :ref:`headers field
	//   <envoy_v3_api_field_extensions.filters.network.thrift_proxy.v3.RouteMatch.headers>` field. To
	//   invert header matching, see :ref:`invert_match
	//   <envoy_v3_api_field_config.route.v3.HeaderMatcher.invert_match>`.
	invert?: bool
	// Specifies a set of headers that the route should match on. The router will check the request’s
	// headers against all the specified headers in the route config. A match will happen if all the
	// headers in the route are present in the request with the same values (or based on presence if
	// the value field is not in the config). Note that this only applies for Thrift transports and/or
	// protocols that support headers.
	headers?: [...v3.#HeaderMatcher]
}

// [#next-free-field: 8]
#RouteAction: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.RouteAction"
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
	// <envoy_v3_api_field_extensions.filters.network.thrift_proxy.v3.WeightedCluster.ClusterWeight.metadata_match>`,
	// with values there taking precedence. Keys and values should be provided under the "envoy.lb"
	// metadata key.
	metadata_match?: v31.#Metadata
	// Specifies a set of rate limit configurations that could be applied to the route.
	// N.B. Thrift service or method name matching can be achieved by specifying a RequestHeaders
	// action with the header name ":method-name".
	rate_limits?: [...v3.#RateLimit]
	// Strip the service prefix from the method name, if there's a prefix. For
	// example, the method call Service:method would end up being just method.
	strip_service_name?: bool
	// Indicates that the route has request mirroring policies.
	request_mirror_policies?: [...#RouteAction_RequestMirrorPolicy]
}

// Allows for specification of multiple upstream clusters along with weights that indicate the
// percentage of traffic to be forwarded to each cluster. The router selects an upstream cluster
// based on these weights.
#WeightedCluster: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.WeightedCluster"
	// Specifies one or more upstream clusters associated with the route.
	clusters?: [...#WeightedCluster_ClusterWeight]
}

// The router is capable of shadowing traffic from one cluster to another. The current
// implementation is "fire and forget," meaning Envoy will not wait for the shadow cluster to
// respond before returning the response from the primary cluster. All normal statistics are
// collected for the shadow cluster making this feature useful for testing.
//
// .. note::
//
//   Shadowing will not be triggered if the primary cluster does not exist.
#RouteAction_RequestMirrorPolicy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.RouteAction_RequestMirrorPolicy"
	// Specifies the cluster that requests will be mirrored to. The cluster must
	// exist in the cluster manager configuration when the route configuration is loaded.
	// If it disappears at runtime, the shadow request will silently be ignored.
	cluster?: string
	// If not specified, all requests to the target cluster will be mirrored.
	//
	// For some fraction N/D, a random number in the range [0,D) is selected. If the
	// number is <= the value of the numerator N, or if the key is not present, the default
	// value, the request will be mirrored.
	runtime_fraction?: v31.#RuntimeFractionalPercent
}

#WeightedCluster_ClusterWeight: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.WeightedCluster_ClusterWeight"
	// Name of the upstream cluster.
	name?: string
	// When a request matches the route, the choice of an upstream cluster is determined by its
	// weight. The sum of weights across all entries in the clusters array determines the total
	// weight.
	weight?: uint32
	// Optional endpoint metadata match criteria used by the subset load balancer. Only endpoints in
	// the upstream cluster with metadata matching what is set in this field, combined with what's
	// provided in :ref:`RouteAction's metadata_match
	// <envoy_v3_api_field_extensions.filters.network.thrift_proxy.v3.RouteAction.metadata_match>`,
	// will be considered. Values here will take precedence. Keys and values should be provided
	// under the "envoy.lb" metadata key.
	metadata_match?: v31.#Metadata
}
