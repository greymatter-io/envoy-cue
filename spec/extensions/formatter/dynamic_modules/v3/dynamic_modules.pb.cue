package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the Dynamic Modules Formatter. This formatter allows loading shared object
// files via “dlopen“ to implement custom “%COMMAND%“ operators for access logs and header
// formatting.
//
// A module can be loaded by multiple formatters; the module is loaded only once and shared across
// multiple command parser instances. Each parsed command produces a provider that is invoked on the
// worker threads to compute the substitution value, with access to request and response headers,
// stream info attributes, dynamic metadata, and the local reply body.
#DynamicModuleFormatter: {
	"@type": "type.googleapis.com/envoy.extensions.formatter.dynamic_modules.v3.DynamicModuleFormatter"
	// Specifies the shared-object level configuration. This field is required.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name for this formatter configuration. If not specified, defaults to an empty string.
	//
	// This can be used to distinguish between different formatter implementations inside a dynamic
	// module. When Envoy receives this configuration, it passes the “formatter_name“ to the dynamic
	// module's formatter config init function together with the “formatter_config“. That way a
	// module can decide which in-module command parser implementation to use based on the name at
	// load time.
	formatter_name?: string
	// The configuration for the formatter chosen by “formatter_name“. If not specified, an empty
	// configuration is passed to the module.
	//
	// This is passed to the module's formatter initialization function. Together with the
	// “formatter_name“, the module can decide which in-module command parser implementation to use
	// and fine-tune which commands it recognizes.
	//
	// “google.protobuf.Struct“ is serialized as JSON before passing it to the module.
	// “google.protobuf.BytesValue“ and “google.protobuf.StringValue“ are passed directly
	// without the wrapper.
	//
	// .. code-block:: yaml
	//
	//	# Passing a JSON struct configuration
	//	formatter_config:
	//	  "@type": "type.googleapis.com/google.protobuf.Struct"
	//	  value:
	//	    redact_headers:
	//	    - authorization
	//	    - cookie
	//
	//	# Passing a simple string configuration
	//	formatter_config:
	//	  "@type": "type.googleapis.com/google.protobuf.StringValue"
	//	  value: "x-request-id"
	formatter_config?: _
}
