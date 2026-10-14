package v3alpha

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/load_balancing_policies/common/v3"
)

#PerWorkerSubset_PartitioningStrategy: "EQUAL_PARTITIONS" | "RANDOM_PARTITIONS"

PerWorkerSubset_PartitioningStrategy_EQUAL_PARTITIONS:  "EQUAL_PARTITIONS"
PerWorkerSubset_PartitioningStrategy_RANDOM_PARTITIONS: "RANDOM_PARTITIONS"

// Within-subset host selection. Applies on top of either partitioning
// strategy.
//
// This contributed implementation intentionally exposes a small set of
// validated strategies rather than accepting an arbitrary nested load
// balancing policy. The inner policy operates on a synthetic
// single-priority, single-locality “PrioritySet“, and not every Envoy
// load balancer is compatible with that constrained model.
// “SIMPLE_ROUND_ROBIN“ also provides a low-overhead option that avoids
// constructing an inner stock load balancer per worker. A nested policy
// can be reconsidered if this extension moves into the core
// load-balancer set.
#PerWorkerSubset_HostSelectionStrategy: "UNSPECIFIED" | "SIMPLE_ROUND_ROBIN" | "ENVOY_ROUND_ROBIN" | "ENVOY_P2C"

PerWorkerSubset_HostSelectionStrategy_UNSPECIFIED:        "UNSPECIFIED"
PerWorkerSubset_HostSelectionStrategy_SIMPLE_ROUND_ROBIN: "SIMPLE_ROUND_ROBIN"
PerWorkerSubset_HostSelectionStrategy_ENVOY_ROUND_ROBIN:  "ENVOY_ROUND_ROBIN"
PerWorkerSubset_HostSelectionStrategy_ENVOY_P2C:          "ENVOY_P2C"

// Per-worker subset load balancer.
//
// Each Envoy worker thread maintains its own subset of upstream hosts and
// load-balances requests across only that subset. The motivating use case is
// upstream clusters with hundreds to thousands of hosts behind a short
// server-side HTTP keepalive timeout: stock per-cluster load balancers will
// eventually open a connection from every worker to every host, producing
// tens of thousands of mostly-idle keepalive connections that the upstream
// reaps. This policy caps per-worker fanout to K hosts so each connection
// stays in active use inside the upstream's keepalive window.
//
// Fleet-wide upstream coverage is preserved: across W workers per Envoy and
// E Envoys, each upstream host receives roughly “(W*E)/N“ workers' worth
// of traffic.
//
// The policy is two-axis:
//
//  1. :ref:`partitioning_strategy
//     <envoy_v3_api_field_extensions.load_balancing_policies.per_worker_subset.v3alpha.PerWorkerSubset.partitioning_strategy>`
//     selects how each worker's subset is derived from the cluster's host
//     set.
//
//  2. :ref:`host_selection_strategy
//     <envoy_v3_api_field_extensions.load_balancing_policies.per_worker_subset.v3alpha.PerWorkerSubset.host_selection_strategy>`
//     selects how an individual host is picked on each “chooseHost“ call
//     within the worker's subset.
//
// Both axes are independent and can be combined freely.
//
// [#next-free-field: 6]
#PerWorkerSubset: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.per_worker_subset.v3alpha.PerWorkerSubset"
	// Interpretation depends on
	// :ref:`partitioning_strategy
	// <envoy_v3_api_field_extensions.load_balancing_policies.per_worker_subset.v3alpha.PerWorkerSubset.partitioning_strategy>`:
	//
	// ``EQUAL_PARTITIONS``: subset_size is a subsetting kill-switch. The
	// actual K (hosts per worker) is auto-computed as ``ceil(N/W)`` on every
	// membership update, where W is the resolved total worker count and N
	// is the cluster's host count. When ``subset_size >= N`` the policy
	// disables subsetting and each worker takes the entire cluster (the
	// within-subset selection runs over the full cluster). The default of
	// 0 means "always subset".
	//
	// ``RANDOM_PARTITIONS``: subset_size is K, the number of hosts each worker
	// samples. Must be ``> 0`` in this mode. Setting it ``>= N`` degenerates
	// to within-subset selection over the full set.
	subset_size?: uint32
	// Partition strategy. Defaults to ``EQUAL_PARTITIONS``.
	partitioning_strategy?: #PerWorkerSubset_PartitioningStrategy
	// Within-subset host selection. Required when the extension is
	// instantiated; leaving this at the proto default (``UNSPECIFIED``) is
	// rejected by the factory's ``loadConfig`` with ``InvalidArgumentError``.
	host_selection_strategy?: #PerWorkerSubset_HostSelectionStrategy
	// Per-worker fallback threshold (percent points, ``[0, 100]``).
	// When the healthy hosts in a worker's slice drop below this fraction of
	// K, degraded hosts are added before considering unhealthy hosts. The
	// worker uses the full slice (including unhealthy hosts) only when
	// healthy plus degraded capacity still does not meet the threshold.
	// Per-worker: workers fall back independently based on their own slice's
	// health.
	//
	// * Unset: defaults to 50.
	// * Set to 0: disables the percent check; healthy hosts are used when
	//   present, otherwise degraded hosts, then the full slice.
	// * Set to 100: degraded hosts are added as soon as healthy hosts alone
	//   cannot fill the slice; the full slice is used if healthy plus degraded
	//   still cannot fill it.
	// * Values ``> 100``: rejected by the factory.
	//
	// Independent of the cluster's
	// :ref:`common_lb_config.healthy_panic_threshold
	// <envoy_v3_api_field_config.cluster.v3.Cluster.CommonLbConfig.healthy_panic_threshold>`
	// -- this knob is scoped to the per-worker subset, not the whole
	// cluster. It is evaluated by this policy before publishing the worker's
	// synthetic host set; the inner stock load balancer does not apply a
	// second panic threshold.
	fallback_threshold?: uint32
	// Slow-start config forwarded to the inner stock LB when
	// ``host_selection_strategy`` is ``ENVOY_ROUND_ROBIN`` or ``ENVOY_P2C``.
	// ``SIMPLE_ROUND_ROBIN`` ignores it. Lives here, not at the cluster
	// level, because Envoy ignores the legacy
	// ``round_robin_lb_config.slow_start_config`` field when
	// ``load_balancing_policy`` is set to a typed extension.
	slow_start_config?: v3.#SlowStartConfig
}
