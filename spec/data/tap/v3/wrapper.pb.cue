package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/v3"
)

// Wrapper for all fully buffered and streamed tap traces that Envoy emits. This is required for
// sending traces over gRPC APIs or more easily persisting binary messages to files.
// [#next-free-field: 6]
#TraceWrapper: {
	"@type": "type.googleapis.com/envoy.data.tap.v3.TraceWrapper"
	// An HTTP buffered tap trace.
	http_buffered_trace?: #HttpBufferedTrace
	// An HTTP streamed tap trace segment.
	http_streamed_trace_segment?: #HttpStreamedTraceSegment
	// A socket buffered tap trace.
	socket_buffered_trace?: #SocketBufferedTrace
	// A socket streamed tap trace segment.
	socket_streamed_trace_segment?: #SocketStreamedTraceSegment
	// The configured sample rate at the time this trace was admitted, sourced from the
	// :ref:`default_value
	// <envoy_v3_api_field_config.core.v3.RuntimeFractionalPercent.default_value>` of
	// :ref:`tap_enabled <envoy_v3_api_field_config.tap.v3.TapConfig.tap_enabled>`. For
	// buffered output (where each “TraceWrapper“ carries a complete trace) the rate is
	// always present when sampling is configured. For streamed output (where a trace is
	// split across multiple “TraceWrapper“ segments) the rate is set on the first
	// emitted segment only; subsequent segments belonging to the same trace can be
	// joined to it via the “trace_id“ carried on each inner segment message. Absent
	// when sampling is unconfigured.
	//
	// .. note::
	//
	//	When :ref:`runtime_key
	//	<envoy_v3_api_field_config.core.v3.RuntimeFractionalPercent.runtime_key>` is
	//	configured and an active runtime override is in effect, the effective sampling
	//	rate that admitted the trace may differ from the recorded configured value.
	configured_sample_rate?: v3.#FractionalPercent
}
