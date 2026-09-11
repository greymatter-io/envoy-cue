package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/v3"
)

#TraceIdRatioBasedSamplerConfig: {
	"@type": "type.googleapis.com/envoy.extensions.tracers.opentelemetry.samplers.v3.TraceIdRatioBasedSamplerConfig"
	// If the given trace_id falls into a given percentage of all possible
	// trace_id values, ShouldSample will return RECORD_AND_SAMPLE.
	// required
	// [#extension-category: envoy.tracers.opentelemetry.samplers]
	sampling_percentage?: v3.#FractionalPercent
}
