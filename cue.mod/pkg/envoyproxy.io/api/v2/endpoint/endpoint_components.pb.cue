package endpoint

import (
	core "envoyproxy.io/api/v2/core"
)

// Upstream host identifier.
#Endpoint: {
	"@type": "type.googleapis.com/envoy.api.v2.endpoint.Endpoint"
	// The upstream host address.
	//
	// .. attention::
	//
	//   The form of host address depends on the given cluster type. For STATIC or EDS,
	//   it is expected to be a direct IP address (or something resolvable by the
	//   specified :ref:`resolver <envoy_api_field_core.SocketAddress.resolver_name>`
	//   in the Address). For LOGICAL or STRICT DNS, it is expected to be hostname,
	//   and will be resolved via DNS.
	address?: core.#Address
	// The optional health check configuration is used as configuration for the
	// health checker to contact the health checked host.
	//
	// .. attention::
	//
	//   This takes into effect only for upstream clusters with
	//   :ref:`active health checking <arch_overview_health_checking>` enabled.
	health_check_config?: #Endpoint_HealthCheckConfig
	// The hostname associated with this endpoint. This hostname is not used for routing or address
	// resolution. If provided, it will be associated with the endpoint, and can be used for features
	// that require a hostname, like
	// :ref:`auto_host_rewrite <envoy_api_field_route.RouteAction.auto_host_rewrite>`.
	hostname?: string
}

// An Endpoint that Envoy can route traffic to.
// [#next-free-field: 6]
#LbEndpoint: {
	"@type":   "type.googleapis.com/envoy.api.v2.endpoint.LbEndpoint"
	endpoint?: #Endpoint
	// [#not-implemented-hide:]
	endpoint_name?: string
	// Optional health status when known and supplied by EDS server.
	health_status?: core.#HealthStatus
	// The endpoint metadata specifies values that may be used by the load
	// balancer to select endpoints in a cluster for a given request. The filter
	// name should be specified as *envoy.lb*. An example boolean key-value pair
	// is *canary*, providing the optional canary status of the upstream host.
	// This may be matched against in a route's
	// :ref:`RouteAction <envoy_api_msg_route.RouteAction>` metadata_match field
	// to subset the endpoints considered in cluster load balancing.
	metadata?: core.#Metadata
	// The optional load balancing weight of the upstream host; at least 1.
	// Envoy uses the load balancing weight in some of the built in load
	// balancers. The load balancing weight for an endpoint is divided by the sum
	// of the weights of all endpoints in the endpoint's locality to produce a
	// percentage of traffic for the endpoint. This percentage is then further
	// weighted by the endpoint's locality's load balancing weight from
	// LocalityLbEndpoints. If unspecified, each host is presumed to have equal
	// weight in a locality. The sum of the weights of all endpoints in the
	// endpoint's locality must not exceed uint32_t maximal value (4294967295).
	load_balancing_weight?: uint32
}

// A group of endpoints belonging to a Locality.
// One can have multiple LocalityLbEndpoints for a locality, but this is
// generally only done if the different groups need to have different load
// balancing weights or different priorities.
// [#next-free-field: 7]
#LocalityLbEndpoints: {
	"@type": "type.googleapis.com/envoy.api.v2.endpoint.LocalityLbEndpoints"
	// Identifies location of where the upstream hosts run.
	locality?: core.#Locality
	// The group of endpoints belonging to the locality specified.
	lb_endpoints?: [...#LbEndpoint]
	// Optional: Per priority/region/zone/sub_zone weight; at least 1. The load
	// balancing weight for a locality is divided by the sum of the weights of all
	// localities  at the same priority level to produce the effective percentage
	// of traffic for the locality. The sum of the weights of all localities at
	// the same priority level must not exceed uint32_t maximal value (4294967295).
	//
	// Locality weights are only considered when :ref:`locality weighted load
	// balancing <arch_overview_load_balancing_locality_weighted_lb>` is
	// configured. These weights are ignored otherwise. If no weights are
	// specified when locality weighted load balancing is enabled, the locality is
	// assigned no load.
	load_balancing_weight?: uint32
	// Optional: the priority for this LocalityLbEndpoints. If unspecified this will
	// default to the highest priority (0).
	//
	// Under usual circumstances, Envoy will only select endpoints for the highest
	// priority (0). In the event all endpoints for a particular priority are
	// unavailable/unhealthy, Envoy will fail over to selecting endpoints for the
	// next highest priority group.
	//
	// Priorities should range from 0 (highest) to N (lowest) without skipping.
	priority?: uint32
	// Optional: Per locality proximity value which indicates how close this
	// locality is from the source locality. This value only provides ordering
	// information (lower the value, closer it is to the source locality).
	// This will be consumed by load balancing schemes that need proximity order
	// to determine where to route the requests.
	// [#not-implemented-hide:]
	proximity?: uint32
}

// The optional health check configuration.
#Endpoint_HealthCheckConfig: {
	"@type": "type.googleapis.com/envoy.api.v2.endpoint.Endpoint_HealthCheckConfig"
	// Optional alternative health check port value.
	//
	// By default the health check address port of an upstream host is the same
	// as the host's serving address port. This provides an alternative health
	// check port. Setting this with a non-zero value allows an upstream host
	// to have different health check address port.
	port_value?: uint32
	// By default, the host header for L7 health checks is controlled by cluster level configuration
	// (see: :ref:`host <envoy_api_field_core.HealthCheck.HttpHealthCheck.host>` and
	// :ref:`authority <envoy_api_field_core.HealthCheck.GrpcHealthCheck.authority>`). Setting this
	// to a non-empty value allows overriding the cluster level configuration for a specific
	// endpoint.
	hostname?: string
}
