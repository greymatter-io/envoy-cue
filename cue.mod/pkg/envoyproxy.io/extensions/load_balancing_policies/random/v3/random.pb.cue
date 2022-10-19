package v3

// This configuration allows the built-in Random LB policy to be configured via the LB policy
// extension point. See the :ref:`load balancing architecture overview
// <arch_overview_load_balancing_types>` for more information.
// [#extension: envoy.load_balancing_policies]
#Random: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.random.v3.Random"
}
