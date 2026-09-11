package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the Dynamic Modules UDP listener filter. This filter allows loading shared object
// files that can be loaded via “dlopen“ to extend the UDP listener filter chain.
//
// A module can be loaded by multiple UDP listener filters; the module is loaded only once and shared
// across multiple filters.
#DynamicModuleUdpListenerFilter: {
	"@type": "type.googleapis.com/envoy.extensions.filters.udp.dynamic_modules.v3.DynamicModuleUdpListenerFilter"
	// Specifies the shared-object level configuration.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name for this filter configuration.
	//
	// This can be used to distinguish between different filter implementations inside a dynamic
	// module. For example, a module can have completely different filter implementations. When Envoy
	// receives this configuration, it passes the “filter_name“ to the dynamic module's UDP listener
	// filter config init function together with the “filter_config“. That way a module can decide
	// which in-module filter implementation to use based on the name at load time.
	filter_name?: string
	// The configuration for the filter chosen by “filter_name“.
	//
	// This is passed to the module's UDP listener filter initialization function. Together with the
	// “filter_name“, the module can decide which in-module filter implementation to use and
	// fine-tune the behavior of the filter.
	//
	// For example, if a module has two filter implementations, one for echo and one for rate
	// limiting, “filter_name“ is used to choose either echo or rate limiting. The
	// “filter_config“ can be used to configure the echo behavior or the rate limiting parameters.
	//
	// “google.protobuf.Struct“ is serialized as JSON before passing it to the module.
	// “google.protobuf.BytesValue“ and “google.protobuf.StringValue“ are passed directly
	// without the wrapper.
	//
	// .. code-block:: yaml
	//
	//	# Passing a string value
	//	filter_config:
	//	  "@type": "type.googleapis.com/google.protobuf.StringValue"
	//	  value: hello
	//
	//	# Passing raw bytes
	//	filter_config:
	//	  "@type": "type.googleapis.com/google.protobuf.BytesValue"
	//	  value: aGVsbG8=  # echo -n "hello" | base64
	filter_config?: _
}
