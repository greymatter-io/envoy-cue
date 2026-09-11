package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#ParentBasedSamplerConfig: {
	"@type": "type.googleapis.com/envoy.extensions.tracers.opentelemetry.samplers.v3.ParentBasedSamplerConfig"
	// Specifies the sampler to be used by this sampler.
	// The configured sampler will be used if the parent trace ID is not passed to Envoy
	//
	// required
	// [#extension-category: envoy.tracers.opentelemetry.samplers]
	wrapped_sampler?: v3.#TypedExtensionConfig
}
