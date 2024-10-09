package v3

import (
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
)

// DynamicOtConfig was used to dynamically load a tracer from a shared library
// that implements the `OpenTracing dynamic loading API
// <https://github.com/opentracing/opentracing-cpp>`_.
// [#not-implemented-hide:]
#DynamicOtConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v3.DynamicOtConfig"
	// Dynamic library implementing the `OpenTracing API
	// <https://github.com/opentracing/opentracing-cpp>`_.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/dynamic_ot.proto.
	library?: string
	// The configuration to use when creating a tracer from the given dynamic
	// library.
	//
	// Deprecated: Marked as deprecated in envoy/config/trace/v3/dynamic_ot.proto.
	config?: structpb.#Struct
}
