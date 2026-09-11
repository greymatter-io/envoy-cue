package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the Dynamic Modules network filter. This filter allows loading shared object
// files that can be loaded via “dlopen“ to extend the network filter chain.
//
// A module can be loaded by multiple network filters; the module is loaded only once and shared
// across multiple filters.
//
// Unlike HTTP filters which operate on structured headers, body, and trailers, network filters work
// with raw TCP byte streams. The filter can:
//
// * Inspect, modify, or inject data into the downstream connection.
// * Access connection-level information such as addresses and TLS status.
// * Control connection lifecycle (e.g., close the connection).
#DynamicModuleNetworkFilter: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dynamic_modules.v3.DynamicModuleNetworkFilter"
	// Specifies the shared-object level configuration.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name for this filter configuration.
	//
	// This can be used to distinguish between different filter implementations inside a dynamic
	// module. For example, a module can have completely different filter implementations. When Envoy
	// receives this configuration, it passes the “filter_name“ to the dynamic module's network
	// filter config init function together with the “filter_config“. That way a module can decide
	// which in-module filter implementation to use based on the name at load time.
	filter_name?: string
	// The configuration for the filter chosen by “filter_name“.
	//
	// This is passed to the module's network filter initialization function. Together with the
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
	// If “true“, the dynamic module is a terminal filter to use without an upstream connection.
	//
	// The dynamic module is responsible for creating and sending the response to downstream.
	//
	// Defaults to “false“.
	terminal_filter?: bool
}
