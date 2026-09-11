package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/type/v3"
)

#CELSamplerConfig: {
	"@type": "type.googleapis.com/envoy.extensions.tracers.opentelemetry.samplers.v3.CELSamplerConfig"
	// Expression that, when evaluated, will be used to make sample decision.
	expression?: v3.#CelExpression
}
