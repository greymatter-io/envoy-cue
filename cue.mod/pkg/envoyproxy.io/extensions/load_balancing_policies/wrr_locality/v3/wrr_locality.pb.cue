package v3

import (
	v3 "envoyproxy.io/config/cluster/v3"
)

// Configuration for the wrr_locality LB policy. See the :ref:`load balancing architecture overview
// <arch_overview_load_balancing_types>` for more information.
// [#extension: envoy.clusters.lb_policy]
#WrrLocality: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.wrr_locality.v3.WrrLocality"
	// The child LB policy to create for endpoint-picking within the chosen locality.
	endpoint_picking_policy?: v3.#LoadBalancingPolicy
}
