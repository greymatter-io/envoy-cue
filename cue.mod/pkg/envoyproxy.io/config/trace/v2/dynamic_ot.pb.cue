package v2

import (
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
)

// DynamicOtConfig is used to dynamically load a tracer from a shared library
// that implements the `OpenTracing dynamic loading API
// <https://github.com/opentracing/opentracing-cpp>`_.
// [#extension: envoy.tracers.dynamic_ot]
#DynamicOtConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v2.DynamicOtConfig"
	// Dynamic library implementing the `OpenTracing API
	// <https://github.com/opentracing/opentracing-cpp>`_.
	library?: string
	// The configuration to use when creating a tracer from the given dynamic
	// library.
	config?: structpb.#Struct
}
