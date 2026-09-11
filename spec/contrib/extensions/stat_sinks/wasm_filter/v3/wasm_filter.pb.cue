package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/wasm/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/metrics/v3"
)

// A stats sink that runs a WASM plugin to filter, transform, and enrich metrics
// before delegating to an inner sink. The plugin can:
//
// - **Filter**: keep/drop counters, gauges, and histograms by index
// - **Enrich**: inject global tags (e.g. datacenter, pod) from node metadata
// - **Rename**: override metric names (e.g. prefix with “envoy.“)
// - **Inject**: add synthetic counters/gauges (e.g. version metrics)
//
// Available foreign functions:
//
//	``stats_filter_emit`` -- declare kept metric indices
//	``stats_filter_set_global_tags`` -- set tags applied to all metrics (once at startup)
//	``stats_filter_set_name_overrides`` -- rename specific metrics (per flush)
//	``stats_filter_inject_metrics`` -- inject synthetic counters/gauges (per flush)
//	``stats_filter_get_histograms`` -- get histogram names
//	``stats_filter_get_metric_tags`` -- get tags for a single metric
//	``stats_filter_get_all_metric_tags`` -- get tags for all metrics (bulk)
//
// Metrics that the plugin does not emit are dropped. Text readouts pass through
// to the inner sink unfiltered.
#WasmFilterStatsSinkConfig: {
	"@type": "type.googleapis.com/envoy.extensions.stat_sinks.wasm_filter.v3.WasmFilterStatsSinkConfig"
	// WASM plugin that implements the filter/transform/enrichment logic.
	wasm_config?: v3.#PluginConfig
	// The inner sink to delegate filtered metrics to.
	inner_sink?: v31.#StatsSink
}
