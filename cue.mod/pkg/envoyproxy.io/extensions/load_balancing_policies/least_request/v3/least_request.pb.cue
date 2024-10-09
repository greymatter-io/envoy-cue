package v3

import (
	v3 "envoyproxy.io/config/core/v3"
	v31 "envoyproxy.io/extensions/load_balancing_policies/common/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// Available methods for selecting the host set from which to return the host with the
// fewest active requests.
#LeastRequest_SelectionMethod: "N_CHOICES" | "FULL_SCAN"

LeastRequest_SelectionMethod_N_CHOICES: "N_CHOICES"
LeastRequest_SelectionMethod_FULL_SCAN: "FULL_SCAN"

// This configuration allows the built-in LEAST_REQUEST LB policy to be configured via the LB policy
// extension point. See the :ref:`load balancing architecture overview
// <arch_overview_load_balancing_types>` for more information.
// [#next-free-field: 7]
#LeastRequest: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.least_request.v3.LeastRequest"
	// The number of random healthy hosts from which the host with the fewest active requests will
	// be chosen. Defaults to 2 so that we perform two-choice selection if the field is not set.
	// Only applies to the “N_CHOICES“ selection method.
	choice_count?: wrapperspb.#UInt32Value
	// The following formula is used to calculate the dynamic weights when hosts have different load
	// balancing weights:
	//
	// “weight = load_balancing_weight / (active_requests + 1)^active_request_bias“
	//
	// The larger the active request bias is, the more aggressively active requests will lower the
	// effective weight when all host weights are not equal.
	//
	// “active_request_bias“ must be greater than or equal to 0.0.
	//
	// When “active_request_bias == 0.0“ the Least Request Load Balancer doesn't consider the number
	// of active requests at the time it picks a host and behaves like the Round Robin Load
	// Balancer.
	//
	// When “active_request_bias > 0.0“ the Least Request Load Balancer scales the load balancing
	// weight by the number of active requests at the time it does a pick.
	//
	// The value is cached for performance reasons and refreshed whenever one of the Load Balancer's
	// host sets changes, e.g., whenever there is a host membership update or a host load balancing
	// weight change.
	//
	// .. note::
	//
	//	This setting only takes effect if all host weights are not equal.
	active_request_bias?: v3.#RuntimeDouble
	// Configuration for slow start mode.
	// If this configuration is not set, slow start will not be not enabled.
	slow_start_config?: v31.#SlowStartConfig
	// Configuration for local zone aware load balancing or locality weighted load balancing.
	locality_lb_config?: v31.#LocalityLbConfig
	// [#not-implemented-hide:]
	// Unused. Replaced by the `selection_method` enum for better extensibility.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/load_balancing_policies/least_request/v3/least_request.proto.
	enable_full_scan?: wrapperspb.#BoolValue
	// Method for selecting the host set from which to return the host with the fewest active requests.
	//
	// Defaults to “N_CHOICES“.
	selection_method?: #LeastRequest_SelectionMethod
}
