package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// Configuration for the client_side_weighted_round_robin LB policy.
//
// This policy differs from the built-in ROUND_ROBIN policy in terms of
// how the endpoint weights are determined. In the ROUND_ROBIN policy,
// the endpoint weights are sent by the control plane via EDS. However,
// in this policy, the endpoint weights are instead determined via qps (queries
// per second), eps (errors per second), and utilization metrics sent by the
// endpoint using the Open Request Cost Aggregation (ORCA) protocol. Utilization
// is determined by using the ORCA application_utilization field, if set, or
// else falling back to the cpu_utilization field. All queries count toward qps,
// regardless of result. Only failed queries count toward eps. A config
// parameter error_utilization_penalty controls the penalty to adjust endpoint
// weights using eps and qps. The weight of a given endpoint is computed as:
// “qps / (utilization + eps/qps * error_utilization_penalty)“.
//
// See the :ref:`load balancing architecture
// overview<arch_overview_load_balancing_types>` for more information.
//
// [#next-free-field: 8]
#ClientSideWeightedRoundRobin: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.client_side_weighted_round_robin.v3.ClientSideWeightedRoundRobin"
	// Whether to enable out-of-band utilization reporting collection from
	// the endpoints. By default, per-request utilization reporting is used.
	enable_oob_load_report?: wrapperspb.#BoolValue
	// Load reporting interval to request from the server. Note that the
	// server may not provide reports as frequently as the client requests.
	// Used only when enable_oob_load_report is true. Default is 10 seconds.
	oob_reporting_period?: durationpb.#Duration
	// A given endpoint must report load metrics continuously for at least
	// this long before the endpoint weight will be used. This avoids
	// churn when the set of endpoint addresses changes. Takes effect
	// both immediately after we establish a connection to an endpoint and
	// after weight_expiration_period has caused us to stop using the most
	// recent load metrics. Default is 10 seconds.
	blackout_period?: durationpb.#Duration
	// If a given endpoint has not reported load metrics in this long,
	// then we stop using the reported weight. This ensures that we do
	// not continue to use very stale weights. Once we stop using a stale
	// value, if we later start seeing fresh reports again, the
	// blackout_period applies. Defaults to 3 minutes.
	weight_expiration_period?: durationpb.#Duration
	// How often endpoint weights are recalculated. Values less than 100ms are
	// capped at 100ms. Default is 1 second.
	weight_update_period?: durationpb.#Duration
	// The multiplier used to adjust endpoint weights with the error rate
	// calculated as eps/qps. Configuration is rejected if this value is negative.
	// Default is 1.0.
	error_utilization_penalty?: wrapperspb.#FloatValue
	// By default, endpoint weight is computed based on the :ref:`application_utilization <envoy_v3_api_field_.xds.data.orca.v3.OrcaLoadReport.application_utilization>` field reported by the endpoint.
	// If that field is not set, then utilization will instead be computed by taking the max of the values of the metrics specified here.
	// For map fields in the ORCA proto, the string will be of the form “<map_field_name>.<map_key>“. For example, the string “named_metrics.foo“ will mean to look for the key “foo“ in the ORCA :ref:`named_metrics <envoy_v3_api_field_.xds.data.orca.v3.OrcaLoadReport.named_metrics>` field.
	// If none of the specified metrics are present in the load report, then :ref:`cpu_utilization <envoy_v3_api_field_.xds.data.orca.v3.OrcaLoadReport.cpu_utilization>` is used instead.
	metric_names_for_computing_utilization?: [...string]
}
