package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/cluster/v3"
)

// Configuration for the load_aware_locality LB policy which uses ORCA utilization data
// to route traffic between localities based on available headroom.
// [#next-free-field: 10]
#LoadAwareLocality: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.load_aware_locality.v3.LoadAwareLocality"
	// The child LB policy to create for endpoint-picking within each locality.
	endpoint_picking_policy?: v3.#LoadBalancingPolicy
	// How frequently ORCA weights and locality utilization are recomputed on the
	// main thread. Must be at least 100ms. Defaults to 1s.
	weight_update_period?: string
	// By default, endpoint utilization is computed based on the
	// :ref:`application_utilization <envoy_v3_api_field_.xds.data.orca.v3.OrcaLoadReport.application_utilization>`
	// field reported by the endpoint. If that field is not set, then utilization
	// will instead be computed by taking the max of the values of the metrics
	// specified here. For map fields in the ORCA proto, the string will be of
	// the form “<map_field_name>.<map_key>“. For example, the string
	// “named_metrics.foo“ will mean to look for the key “foo“ in the ORCA
	// :ref:`named_metrics <envoy_v3_api_field_.xds.data.orca.v3.OrcaLoadReport.named_metrics>`
	// field. If none of the specified metrics are present in the load report,
	// then :ref:`cpu_utilization <envoy_v3_api_field_.xds.data.orca.v3.OrcaLoadReport.cpu_utilization>`
	// is used instead.
	metric_names_for_computing_utilization?: [...string]
	// When the local locality's utilization is at most this threshold above the
	// remote average, route 100% of traffic to the local locality. This avoids
	// unnecessary cross-zone routing when utilization is roughly balanced.
	// One-sided: if the local zone is less loaded than remote, all-local routing
	// always applies. Must be in [0, 1]. Defaults to 0.1.
	utilization_variance_threshold?: float64
	// EWMA time constant for per-locality utilization smoothing. The per-tick
	// smoothing factor alpha is derived as “1 - exp(-weight_update_period /
	// smoothing_time_constant)“, so settling time is consistent regardless of
	// the configured tick rate. Larger values produce more stable weights;
	// smaller values react faster. Must be greater than 0s. Defaults to 5s
	// (~95% settling within ~15s).
	smoothing_time_constant?: string
	// Minimum fraction of traffic sent to non-local localities to keep ORCA
	// data fresh when the local-preference check would otherwise route 100% of
	// traffic to the local locality. The deficit is redistributed across remote
	// localities proportionally to their host count. Must be in [0, 1). Set to
	// 0 to disable (safe only when ORCA reports arrive out-of-band, or when
	// cross-zone traffic must be strictly avoided). Defaults to 0.03 (3%).
	//
	// Probe fraction is a global value split across all remote localities.
	// At very high remote-locality counts combined with low aggregate request
	// rates, per-host sample intervals can exceed “weight_expiration_period“.
	// See the architecture overview for the scaling matrix.
	remote_probe_fraction?: float64
	// Per-host ORCA sample validity window. Hosts that have not reported load
	// metrics within this duration are excluded from their locality's
	// utilization aggregation. The locality's EWMA state continues normally
	// over the remaining reporting hosts. If every host in a locality is
	// stale, the locality falls back to host-count-proportional weighting
	// (the same path used when all localities are overloaded). Set to 0s to
	// disable expiration. Defaults to 3 minutes.
	weight_expiration_period?: string
	// Whether to enable out-of-band utilization reporting collection from
	// the endpoints. By default, per-request utilization reporting is used.
	enable_oob_load_report?: bool
	// Load reporting interval to request from the server. Note that the
	// server may not provide reports as frequently as the client requests.
	// Used only when enable_oob_load_report is true. Default is 10 seconds.
	oob_reporting_period?: string
}
