package cluster

import (
	_type "envoyproxy.io/envoy-cue/spec/type"
	core "envoyproxy.io/envoy-cue/spec/api/v2/core"
)

// :ref:`Circuit breaking<arch_overview_circuit_break>` settings can be
// specified individually for each defined priority.
#CircuitBreakers: {
	"@type": "type.googleapis.com/envoy.api.v2.cluster.CircuitBreakers"
	// If multiple :ref:`Thresholds<envoy_api_msg_cluster.CircuitBreakers.Thresholds>`
	// are defined with the same :ref:`RoutingPriority<envoy_api_enum_core.RoutingPriority>`,
	// the first one in the list is used. If no Thresholds is defined for a given
	// :ref:`RoutingPriority<envoy_api_enum_core.RoutingPriority>`, the default values
	// are used.
	thresholds?: [...#CircuitBreakers_Thresholds]
}

// A Thresholds defines CircuitBreaker settings for a
// :ref:`RoutingPriority<envoy_api_enum_core.RoutingPriority>`.
// [#next-free-field: 9]
#CircuitBreakers_Thresholds: {
	"@type": "type.googleapis.com/envoy.api.v2.cluster.CircuitBreakers_Thresholds"
	// The :ref:`RoutingPriority<envoy_api_enum_core.RoutingPriority>`
	// the specified CircuitBreaker settings apply to.
	priority?: core.#RoutingPriority
	// The maximum number of connections that Envoy will make to the upstream
	// cluster. If not specified, the default is 1024.
	max_connections?: uint32
	// The maximum number of pending requests that Envoy will allow to the
	// upstream cluster. If not specified, the default is 1024.
	max_pending_requests?: uint32
	// The maximum number of parallel requests that Envoy will make to the
	// upstream cluster. If not specified, the default is 1024.
	max_requests?: uint32
	// The maximum number of parallel retries that Envoy will allow to the
	// upstream cluster. If not specified, the default is 3.
	max_retries?: uint32
	// Specifies a limit on concurrent retries in relation to the number of active requests. This
	// parameter is optional.
	//
	// .. note::
	//
	//    If this field is set, the retry budget will override any configured retry circuit
	//    breaker.
	retry_budget?: #CircuitBreakers_Thresholds_RetryBudget
	// If track_remaining is true, then stats will be published that expose
	// the number of resources remaining until the circuit breakers open. If
	// not specified, the default is false.
	//
	// .. note::
	//
	//    If a retry budget is used in lieu of the max_retries circuit breaker,
	//    the remaining retry resources remaining will not be tracked.
	track_remaining?: bool
	// The maximum number of connection pools per cluster that Envoy will concurrently support at
	// once. If not specified, the default is unlimited. Set this for clusters which create a
	// large number of connection pools. See
	// :ref:`Circuit Breaking <arch_overview_circuit_break_cluster_maximum_connection_pools>` for
	// more details.
	max_connection_pools?: uint32
}

#CircuitBreakers_Thresholds_RetryBudget: {
	"@type": "type.googleapis.com/envoy.api.v2.cluster.CircuitBreakers_Thresholds_RetryBudget"
	// Specifies the limit on concurrent retries as a percentage of the sum of active requests and
	// active pending requests. For example, if there are 100 active requests and the
	// budget_percent is set to 25, there may be 25 active retries.
	//
	// This parameter is optional. Defaults to 20%.
	budget_percent?: _type.#Percent
	// Specifies the minimum retry concurrency allowed for the retry budget. The limit on the
	// number of active retries may never go below this number.
	//
	// This parameter is optional. Defaults to 3.
	min_retry_concurrency?: uint32
}
