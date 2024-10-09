package v3

import (
	v3 "envoyproxy.io/extensions/load_balancing_policies/common/v3"
)

// This configuration allows the built-in Random LB policy to be configured via the LB policy
// extension point. See the :ref:`load balancing architecture overview
// <arch_overview_load_balancing_types>` for more information.
#Random: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.random.v3.Random"
	// Configuration for local zone aware load balancing or locality weighted load balancing.
	locality_lb_config?: v3.#LocalityLbConfig
}
