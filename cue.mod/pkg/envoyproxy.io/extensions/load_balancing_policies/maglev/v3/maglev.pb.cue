package v3

import (
	v3 "envoyproxy.io/extensions/load_balancing_policies/common/v3"
)

// This configuration allows the built-in Maglev LB policy to be configured via the LB policy
// extension point. See the :ref:`load balancing architecture overview
// <arch_overview_load_balancing_types>` and :ref:`Maglev<arch_overview_load_balancing_types_maglev>` for more information.
#Maglev: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.maglev.v3.Maglev"
	// The table size for Maglev hashing. Maglev aims for "minimal disruption" rather than an absolute guarantee.
	// Minimal disruption means that when the set of upstream hosts change, a connection will likely be sent to the same
	// upstream as it was before. Increasing the table size reduces the amount of disruption.
	// The table size must be prime number limited to 5000011. If it is not specified, the default is 65537.
	table_size?: uint64
	// Common configuration for hashing-based load balancing policies.
	consistent_hashing_lb_config?: v3.#ConsistentHashingLbConfig
	// Enable locality weighted load balancing for maglev lb explicitly.
	locality_weighted_lb_config?: v3.#LocalityLbConfig_LocalityWeightedLbConfig
}
