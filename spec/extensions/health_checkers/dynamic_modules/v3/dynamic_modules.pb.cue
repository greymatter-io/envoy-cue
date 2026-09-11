package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the Dynamic Modules Health Checker. This health checker allows loading shared
// object files via “dlopen“ to implement custom active health checking behavior.
//
// A module can be loaded by multiple health checkers; the module is loaded only once and shared
// across multiple health checker instances.
//
// Envoy drives the standard per-host interval and timeout timers and applies the common
// “interval“, “timeout“, “healthy_threshold“ and “unhealthy_threshold“ settings. On each
// interval the module is asked to check the host; it may perform the work on its own thread and
// reports the host's health status back to Envoy.
#DynamicModuleHealthCheck: {
	"@type": "type.googleapis.com/envoy.extensions.health_checkers.dynamic_modules.v3.DynamicModuleHealthCheck"
	// Specifies the shared-object level configuration. This field is required.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name for this health checker configuration.
	//
	// This can be used to distinguish between different health checker implementations inside a
	// dynamic module. For example, a module can have completely different health checker
	// implementations (e.g., a ping checker, an external-service checker). When Envoy receives this
	// configuration, it passes the “health_checker_name“ to the dynamic module's health checker
	// config init function together with the “health_checker_config“. That way a module can decide
	// which in-module health checker implementation to use based on the name at load time.
	health_checker_name?: string
	// The configuration for the health checker chosen by “health_checker_name“. If not specified,
	// an empty configuration is passed to the module.
	//
	// This is passed to the module's health checker initialization function. Together with the
	// “health_checker_name“, the module can decide which in-module health checker implementation to
	// use and fine-tune the behavior of the health checker.
	//
	// “google.protobuf.Struct“ is serialized as JSON before passing it to the module.
	// “google.protobuf.BytesValue“ and “google.protobuf.StringValue“ are passed directly
	// without the wrapper.
	//
	// .. code-block:: yaml
	//
	//	# Passing a JSON struct configuration
	//	health_checker_config:
	//	  "@type": "type.googleapis.com/google.protobuf.Struct"
	//	  value:
	//	    path: "/healthz"
	//	    degraded_on_slow_response: true
	//
	//	# Passing a simple string configuration
	//	health_checker_config:
	//	  "@type": "type.googleapis.com/google.protobuf.StringValue"
	//	  value: "/healthz"
	health_checker_config?: _
}
