package v3

// The hash function used to hash hosts onto the ketama ring.
#RingHash_HashFunction: "DEFAULT_HASH" | "XX_HASH" | "MURMUR_HASH_2"

RingHash_HashFunction_DEFAULT_HASH:  "DEFAULT_HASH"
RingHash_HashFunction_XX_HASH:       "XX_HASH"
RingHash_HashFunction_MURMUR_HASH_2: "MURMUR_HASH_2"

// This configuration allows the built-in RING_HASH LB policy to be configured via the LB policy
// extension point. See the :ref:`load balancing architecture overview
// <arch_overview_load_balancing_types>` for more information.
// [#extension: envoy.clusters.lb_policy]
// [#next-free-field: 6]
#RingHash: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.ring_hash.v3.RingHash"
	// The hash function used to hash hosts onto the ketama ring. The value defaults to
	// :ref:`XX_HASH<envoy_v3_api_enum_value_config.cluster.v3.Cluster.RingHashLbConfig.HashFunction.XX_HASH>`.
	hash_function?: #RingHash_HashFunction
	// Minimum hash ring size. The larger the ring is (that is, the more hashes there are for each
	// provided host) the better the request distribution will reflect the desired weights. Defaults
	// to 1024 entries, and limited to 8M entries. See also
	// :ref:`maximum_ring_size<envoy_v3_api_field_config.cluster.v3.Cluster.RingHashLbConfig.maximum_ring_size>`.
	minimum_ring_size?: uint64
	// Maximum hash ring size. Defaults to 8M entries, and limited to 8M entries, but can be lowered
	// to further constrain resource use. See also
	// :ref:`minimum_ring_size<envoy_v3_api_field_config.cluster.v3.Cluster.RingHashLbConfig.minimum_ring_size>`.
	maximum_ring_size?: uint64
	// If set to `true`, the cluster will use hostname instead of the resolved
	// address as the key to consistently hash to an upstream host. Only valid for StrictDNS clusters with hostnames which resolve to a single IP address.
	use_hostname_for_hashing?: bool
	// Configures percentage of average cluster load to bound per upstream host. For example, with a value of 150
	// no upstream host will get a load more than 1.5 times the average load of all the hosts in the cluster.
	// If not specified, the load is not bounded for any upstream host. Typical value for this parameter is between 120 and 200.
	// Minimum is 100.
	//
	// This is implemented based on the method described in the paper https://arxiv.org/abs/1608.01350. For the specified
	// `hash_balance_factor`, requests to any upstream host are capped at `hash_balance_factor/100` times the average number of requests
	// across the cluster. When a request arrives for an upstream host that is currently serving at its max capacity, linear probing
	// is used to identify an eligible host. Further, the linear probe is implemented using a random jump in hosts ring/table to identify
	// the eligible host (this technique is as described in the paper https://arxiv.org/abs/1908.08762 - the random jump avoids the
	// cascading overflow effect when choosing the next host in the ring/table).
	//
	// If weights are specified on the hosts, they are respected.
	//
	// This is an O(N) algorithm, unlike other load balancers. Using a lower `hash_balance_factor` results in more hosts
	// being probed, so use a higher value if you require better performance.
	hash_balance_factor?: uint32
}
