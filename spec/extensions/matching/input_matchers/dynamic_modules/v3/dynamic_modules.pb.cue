package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the Dynamic Modules Input Matcher. This matcher allows loading shared object
// files via “dlopen“ to implement custom matching logic in dynamic modules (e.g. Rust, Go).
//
// A module can implement arbitrary matching logic by examining request headers and other HTTP
// attributes during the match evaluation. This is useful for scenarios that require complex
// matching beyond what built-in matchers provide, such as JWT/OAuth token analysis, custom
// routing decisions, or integration with external data sources.
#DynamicModuleMatcher: {
	"@type": "type.googleapis.com/envoy.extensions.matching.input_matchers.dynamic_modules.v3.DynamicModuleMatcher"
	// Specifies the shared-object level configuration. This field is required.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name for this matcher configuration. If not specified, defaults to an empty string.
	//
	// This can be used to distinguish between different matcher implementations inside a dynamic
	// module. For example, a module can have completely different matcher implementations (e.g.,
	// OAuth token matcher, geo-IP matcher). When Envoy receives this configuration, it passes
	// the “matcher_name“ to the dynamic module's matcher config init function together with the
	// “matcher_config“. That way a module can decide which in-module matcher implementation to
	// use based on the name at load time.
	matcher_name?: string
	// The configuration for the matcher chosen by “matcher_name“. If not specified, an empty
	// configuration is passed to the module.
	//
	// This is passed to the module's matcher initialization function. Together with the
	// “matcher_name“, the module can decide which in-module matcher implementation to use and
	// fine-tune the behavior of the matcher.
	//
	// “google.protobuf.Struct“ is serialized as JSON before passing it to the module.
	// “google.protobuf.BytesValue“ and “google.protobuf.StringValue“ are passed directly
	// without the wrapper.
	matcher_config?: _
}
