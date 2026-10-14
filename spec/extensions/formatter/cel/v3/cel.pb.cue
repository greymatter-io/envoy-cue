package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for the CEL formatter.
//
// .. warning::
//
//	This extension is treated as a built-in extension and is enabled by default.
//	It is unnecessary to configure this extension unless overriding the CEL expression runtime
//	via ``cel_config``.
#Cel: {
	"@type": "type.googleapis.com/envoy.extensions.formatter.cel.v3.Cel"
	// Configuration for the CEL expression runtime used by this formatter.
	cel_config?: v3.#CelExpressionConfig
}
