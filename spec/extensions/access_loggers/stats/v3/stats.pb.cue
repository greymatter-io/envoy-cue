package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/v3"
	v31 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/type/matcher/v3"
	v32 "envoyproxy.io/envoy-cue/spec/data/accesslog/v3"
)

// The histogram units. The units are needed for some stat sinks.
#Config_Histogram_Unit: "Unspecified" | "Bytes" | "Microseconds" | "Milliseconds" | "Percent"

Config_Histogram_Unit_Unspecified:  "Unspecified"
Config_Histogram_Unit_Bytes:        "Bytes"
Config_Histogram_Unit_Microseconds: "Microseconds"
Config_Histogram_Unit_Milliseconds: "Milliseconds"
Config_Histogram_Unit_Percent:      "Percent"

// [#next-free-field: 7]
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.stats.v3.Config"
	// The stat prefix for the generated stats.
	// Deprecated: please use “stats_scope.prefix“ instead.
	// It will override “stats_scope.prefix“ if non-empty.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/access_loggers/stats/v3/stats.proto.
	stat_prefix?: string
	// Configuration for stats scope limits and sharing.
	stats_scope?: v3.#Scope
	// The histograms this logger will emit.
	histograms?: [...#Config_Histogram]
	// The counters this logger will emit.
	counters?: [...#Config_Counter]
	// The gauges this logger will emit.
	gauges?: [...#Config_Gauge]
}

// Defines a tag on a stat.
#Config_Tag: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.stats.v3.Config_Tag"
	// The name of the tag.
	name?: string
	// The value of the tag, using :ref:`command operators
	// <config_access_log_command_operators>`.
	value_format?: string
	// The custom rules to generate the stat tags. Currently, the only
	// supported input is
	// :ref:`Stat tag value input <envoy_v3_api_msg_extensions.matching.common_inputs.stats.v3.StatTagValueInput>`.
	// The supported actions are
	// - :ref:`Transform stat action <envoy_v3_api_msg_extensions.matching.actions.transform_stat.v3.TransformStat>`.
	rules?: v31.#Matcher
}

// Defines the name and tags of a stat.
#Config_Stat: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.stats.v3.Config_Stat"
	// The name of the stat.
	name?: string
	// The tags for the stat.
	tags?: [...#Config_Tag]
}

// Configuration for a histogram stat.
#Config_Histogram: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.stats.v3.Config_Histogram"
	// The name and tags of this histogram.
	stat?: #Config_Stat
	// The units for this histogram.
	unit?: #Config_Histogram_Unit
	// The format string for the value of this histogram, using :ref:`command operators <config_access_log_command_operators>`.
	// This must evaluate to a positive number.
	value_format?: string
}

// Configuration for a counter stat.
#Config_Counter: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.stats.v3.Config_Counter"
	// The name and tags of this counter.
	stat?: #Config_Stat
	// The format string for the value to add to this counter, using :ref:`command operators <config_access_log_command_operators>`.
	// One of “value_format“ or “value_fixed“ must be configured.
	value_format?: string
	// A fixed value to add to this counter.
	// One of “value_format“ or “value_fixed“ must be configured.
	value_fixed?: uint64
}

// Configuration for a gauge stat. Gauges can be used to add, subtract, or set
// values, and are useful for tracking concurrency or other mutable values
// over time.
// [#next-free-field: 6]
#Config_Gauge: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.stats.v3.Config_Gauge"
	// The name and tags of this gauge.
	stat?: #Config_Stat
	// The format string for the value of this gauge, using :ref:`command
	// operators <config_access_log_command_operators>`. This must evaluate to a
	// positive number.
	value_format?: string
	// A fixed value to add/subtract/set to this gauge.
	// One of “value_format“ or “value_fixed“ must be configured.
	value_fixed?: uint64
	// The PairedAddSubtract operation.
	// Only one of PairedAddSubtract and Set can be defined.
	add_subtract?: #Config_Gauge_PairedAddSubtract
	// The Set operation.
	// Only one of PairedAddSubtract and Set can be defined.
	set?: #Config_Gauge_Set
}

// The Set operation config.
#Config_Gauge_Set: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.stats.v3.Config_Gauge_Set"
	// The access log type to trigger the operation.
	log_type?: v32.#AccessLogType
}

// The PairedAddSubtract operation config.
// Usage restrictions:
//
//  1. We only support add first then subtract logic and we rely on the symmetrical log types
//     (e.g., DownstreamStart/DownstreamEnd) to increment and decrement the gauge.
//  2. During runtime, sub_log_type will execute if and only if add_log_type operation has
//     been done, tracked by inflight counter in filter state.
//  3. If the add_log_type operation was executed, the sub_log_type will happen when the
//     stream/connection is closed, even if the configured log type didn't happen.
#Config_Gauge_PairedAddSubtract: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.stats.v3.Config_Gauge_PairedAddSubtract"
	// The access log type to trigger the add operation.
	add_log_type?: v32.#AccessLogType
	// The access log type to trigger the subtract operation.
	sub_log_type?: v32.#AccessLogType
}
