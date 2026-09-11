package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the Dynamic Modules Tracer. This tracer allows loading shared object
// files via “dlopen“ to implement custom distributed tracing backends.
//
// A module can be loaded by multiple tracer configurations; the module is loaded only once
// and shared across multiple tracer instances.
//
// The tracer receives trace context from incoming requests and can inject trace context into
// outgoing requests for propagation. It supports the full span lifecycle: creation, tagging,
// logging, child spans, and reporting.
#DynamicModuleTracer: {
	"@type": "type.googleapis.com/envoy.extensions.tracers.dynamic_modules.v3.DynamicModuleTracer"
	// Specifies the shared-object level configuration. This field is required.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name for this tracer configuration. If not specified, defaults to an empty string.
	//
	// This can be used to distinguish between different tracer implementations inside a dynamic
	// module. For example, a module can have completely different tracer implementations (e.g.,
	// Zipkin-compatible, OpenTelemetry-compatible). When Envoy receives this configuration, it
	// passes the “tracer_name“ to the dynamic module's tracer config init function together with
	// the “tracer_config“. That way a module can decide which in-module tracer implementation to
	// use based on the name at load time.
	tracer_name?: string
	// The configuration for the tracer chosen by “tracer_name“. If not specified, an empty
	// configuration is passed to the module.
	//
	// This is passed to the module's tracer initialization function. Together with the
	// “tracer_name“, the module can decide which in-module tracer implementation to use and
	// fine-tune the behavior of the tracer.
	//
	// “google.protobuf.Struct“ is serialized as JSON before passing it to the module.
	// “google.protobuf.BytesValue“ and “google.protobuf.StringValue“ are passed directly
	// without the wrapper.
	//
	// .. code-block:: yaml
	//
	//	# Passing a JSON struct configuration
	//	tracer_config:
	//	  "@type": "type.googleapis.com/google.protobuf.Struct"
	//	  value:
	//	    endpoint: "http://tracing-backend:9411/api/v2/spans"
	//	    sample_rate: 0.1
	//
	//	# Passing a simple string configuration
	//	tracer_config:
	//	  "@type": "type.googleapis.com/google.protobuf.StringValue"
	//	  value: "http://tracing-backend:9411"
	tracer_config?: _
}
