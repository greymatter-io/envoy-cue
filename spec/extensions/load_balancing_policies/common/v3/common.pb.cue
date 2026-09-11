package v3

import (
	structpb "envoyproxy.io/envoy-cue/spec/deps/protobuf/types/known/structpb"
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/v3"
	v32 "envoyproxy.io/envoy-cue/spec/config/route/v3"
)

// Basis for computing per-locality percentages in zone-aware routing.
#LocalityLbConfig_ZoneAwareLbConfig_LocalityBasis: "HEALTHY_HOSTS_NUM" | "HEALTHY_HOSTS_WEIGHT"

LocalityLbConfig_ZoneAwareLbConfig_LocalityBasis_HEALTHY_HOSTS_NUM:    "HEALTHY_HOSTS_NUM"
LocalityLbConfig_ZoneAwareLbConfig_LocalityBasis_HEALTHY_HOSTS_WEIGHT: "HEALTHY_HOSTS_WEIGHT"

#LocalityLbConfig: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.common.v3.LocalityLbConfig"
	// Configuration for local zone aware load balancing.
	zone_aware_lb_config?: #LocalityLbConfig_ZoneAwareLbConfig
	// Enable locality weighted load balancing.
	locality_weighted_lb_config?: #LocalityLbConfig_LocalityWeightedLbConfig
}

// Configuration for :ref:`slow start mode <arch_overview_load_balancing_slow_start>`.
#SlowStartConfig: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.common.v3.SlowStartConfig"
	// Represents the size of slow start window.
	// If set, the newly created host remains in slow start mode starting from its creation time
	// for the duration of slow start window.
	slow_start_window?: string
	// This parameter controls the speed of traffic increase over the slow start window. Defaults to 1.0,
	// so that endpoint would get linearly increasing amount of traffic.
	// When increasing the value for this parameter, the speed of traffic ramp-up increases non-linearly.
	// The value of aggression parameter should be greater than 0.0.
	// By tuning the parameter, is possible to achieve polynomial or exponential shape of ramp-up curve.
	//
	// During slow start window, effective weight of an endpoint would be scaled with time factor and aggression:
	// “new_weight = weight * max(min_weight_percent, time_factor ^ (1 / aggression))“,
	// where “time_factor=(time_since_start_seconds / slow_start_time_seconds)“.
	//
	// As time progresses, more and more traffic would be sent to endpoint, which is in slow start window.
	// Once host exits slow start, time_factor and aggression no longer affect its weight.
	aggression?: v3.#RuntimeDouble
	// Configures the minimum percentage of origin weight that avoids too small new weight,
	// which may cause endpoints in slow start mode receive no traffic in slow start window.
	// If not specified, the default is 10%.
	min_weight_percent?: v31.#Percent
}

// Common Configuration for all consistent hashing load balancers (MaglevLb, RingHashLb, etc.)
#ConsistentHashingLbConfig: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.common.v3.ConsistentHashingLbConfig"
	// If set to “true“, the cluster will use hostname instead of the resolved
	// address as the key to consistently hash to an upstream host. Only valid for StrictDNS clusters with hostnames which resolve to a single IP address.
	use_hostname_for_hashing?: bool
	// Configures percentage of average cluster load to bound per upstream host. For example, with a value of 150
	// no upstream host will get a load more than 1.5 times the average load of all the hosts in the cluster.
	// If not specified, the load is not bounded for any upstream host. Typical value for this parameter is between 120 and 200.
	// Minimum is 100.
	//
	// Applies to both Ring Hash and Maglev load balancers.
	//
	// This is implemented based on the method described in the paper https://arxiv.org/abs/1608.01350. For the specified
	// “hash_balance_factor“, requests to any upstream host are capped at “hash_balance_factor/100“ times the average number of requests
	// across the cluster. When a request arrives for an upstream host that is currently serving at its max capacity, linear probing
	// is used to identify an eligible host. Further, the linear probe is implemented using a random jump in hosts ring/table to identify
	// the eligible host (this technique is as described in the paper https://arxiv.org/abs/1908.08762 - the random jump avoids the
	// cascading overflow effect when choosing the next host in the ring/table).
	//
	// If weights are specified on the hosts, they are respected.
	//
	// This is an O(N) algorithm, unlike other load balancers. Using a lower “hash_balance_factor“ results in more hosts
	// being probed, so use a higher value if you require better performance.
	hash_balance_factor?: uint32
	//	Specifies a list of hash policies to use for ring hash load balancing. If ``hash_policy`` is
	//
	// set, then
	// :ref:`route level hash policy <envoy_v3_api_field_config.route.v3.RouteAction.hash_policy>`
	// will be ignored.
	hash_policy?: [...v32.#RouteAction_HashPolicy]
}

// Connection overrides for the ORCA out-of-band (OOB) reporting stream, used by
// load balancing policies that consume ORCA load reports (e.g.
// :ref:`client_side_weighted_round_robin
// <envoy_v3_api_msg_extensions.load_balancing_policies.client_side_weighted_round_robin.v3.ClientSideWeightedRoundRobin>`).
// Whether and when OOB reporting runs is controlled by the embedding policy.
#OrcaOobReportingConfig: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.common.v3.OrcaOobReportingConfig"
	// Optional alternative port for the OOB reporting connection, for example an
	// ORCA reporting sidecar listening on a dedicated port. If 0 or unset, the
	// port of the host's ORCA reporting address is used. Ignored for non-IP
	// (pipe/UDS) host addresses.
	port_value?: uint32
	// Value of the “:authority“ header on the OOB gRPC stream. If empty, the
	// endpoint hostname is used, then the dialed address, then the cluster name.
	authority?: string
	// Optional key/value pairs used to select a transport socket from the
	// cluster's :ref:`transport_socket_matches
	// <envoy_v3_api_field_config.cluster.v3.Cluster.transport_socket_matches>`
	// for the OOB connection. If unset, or if no match is found, the cluster's
	// default transport socket is used. ALPN “h2“ is always forced on the OOB
	// connection regardless of this setting.
	transport_socket_match_criteria?: structpb.#Struct
}

// Configuration for :ref:`zone aware routing
// <arch_overview_load_balancing_zone_aware_routing>`.
// [#next-free-field: 7]
#LocalityLbConfig_ZoneAwareLbConfig: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.common.v3.LocalityLbConfig_ZoneAwareLbConfig"
	// Configures percentage of requests that will be considered for zone aware routing
	// if zone aware routing is configured. If not specified, the default is 100%.
	// * :ref:`runtime values <config_cluster_manager_cluster_runtime_zone_routing>`.
	// * :ref:`Zone aware routing support <arch_overview_load_balancing_zone_aware_routing>`.
	routing_enabled?: v31.#Percent
	// Configures minimum upstream cluster size required for zone aware routing
	// If upstream cluster size is less than specified, zone aware routing is not performed
	// even if zone aware routing is configured. If not specified, the default is 6.
	// * :ref:`runtime values <config_cluster_manager_cluster_runtime_zone_routing>`.
	// * :ref:`Zone aware routing support <arch_overview_load_balancing_zone_aware_routing>`.
	min_cluster_size?: uint64
	// If set to true, Envoy will not consider any hosts when the cluster is in :ref:`panic
	// mode<arch_overview_load_balancing_panic_threshold>`. Instead, the cluster will fail all
	// requests as if all hosts are unhealthy. This can help avoid potentially overwhelming a
	// failing service.
	fail_traffic_on_panic?: bool
	// If set to true, Envoy will force LocalityDirect routing if a local locality exists.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/load_balancing_policies/common/v3/common.proto.
	force_locality_direct_routing?: bool
	force_local_zone?:              #LocalityLbConfig_ZoneAwareLbConfig_ForceLocalZone
	// Determines how locality percentages are computed:
	// - HEALTHY_HOSTS_NUM: proportional to the count of healthy hosts.
	// - HEALTHY_HOSTS_WEIGHT: proportional to the weights of healthy hosts.
	// Default value is HEALTHY_HOSTS_NUM if unset.
	locality_basis?: #LocalityLbConfig_ZoneAwareLbConfig_LocalityBasis
}

// Configuration for :ref:`locality weighted load balancing
// <arch_overview_load_balancing_locality_weighted_lb>`
#LocalityLbConfig_LocalityWeightedLbConfig: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.common.v3.LocalityLbConfig_LocalityWeightedLbConfig"
}

// Configures Envoy to always route requests to the local zone regardless of the
// upstream zone structure. In Envoy's default configuration, traffic is distributed proportionally
// across all upstream hosts while trying to maximize local routing when possible. The approach
// with force_local_zone aims to be more predictable and if there are upstream hosts in the local
// zone, they will receive all traffic.
// * :ref:`runtime values <config_cluster_manager_cluster_runtime_zone_routing>`.
// * :ref:`Zone aware routing support <arch_overview_load_balancing_zone_aware_routing>`.
#LocalityLbConfig_ZoneAwareLbConfig_ForceLocalZone: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.common.v3.LocalityLbConfig_ZoneAwareLbConfig_ForceLocalZone"
	// Configures the minimum number of upstream hosts in the local zone required when force_local_zone
	// is enabled. If the number of upstream hosts in the local zone is less than the specified value,
	// Envoy will fall back to the default proportional-based distribution across localities.
	// If not specified, the default is 1.
	// * :ref:`runtime values <config_cluster_manager_cluster_runtime_zone_routing>`.
	// * :ref:`Zone aware routing support <arch_overview_load_balancing_zone_aware_routing>`.
	min_size?: uint32
}
