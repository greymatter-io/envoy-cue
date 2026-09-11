package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/cluster/v3"
)

// Configuration for the Random Subsetting Load Balancing Policy
//
// This policy selects a subset of endpoints and passes them to the child LB policy.
// It maintains 2 important properties:
// 1. The policy tries to distribute connections among servers as equally as possible. The higher
// “(N_clients*subset_size)/N_servers“ ratio is, the closer the resulting server connection
// distribution is to uniform.
// 2. The policy minimizes the amount of connection churn generated during server scale-ups by
// using rendezvous hashing
//
// See the :ref:`load balancing architecture
// overview<arch_overview_load_balancing_types>` for more information.
//
// [#not-implemented-hide:]
#RandomSubsetting: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.random_subsetting.v3.RandomSubsetting"
	// subset_size indicates how many backends every client will be connected to.
	// The value must be greater than 0.
	subset_size?: uint32
	// The config for the child policy.
	// The value is required.
	child_policy?: v3.#LoadBalancingPolicy
}
