package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for a load balancing policy implemented via dynamic modules.
// This enables custom load balancing algorithms to be implemented in dynamic modules
// (shared libraries loaded at runtime).
//
// The dynamic module must implement the load balancer ABI functions defined in
// :repo:`abi.h <source/extensions/dynamic_modules/abi/abi.h>`.
// [#extension: envoy.load_balancing_policies.dynamic_modules]
#DynamicModulesLoadBalancerConfig: {
	"@type": "type.googleapis.com/envoy.extensions.load_balancing_policies.dynamic_modules.v3.DynamicModulesLoadBalancerConfig"
	// The dynamic module configuration.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name to identify the load balancer implementation within the module.
	// This is passed to the module's “envoy_dynamic_module_on_lb_config_new“
	// function.
	lb_policy_name?: string
	// The configuration for the module's load balancer implementation.
	// This is passed to the module's “envoy_dynamic_module_on_lb_config_new“
	// function. The configuration can be any protobuf message. However, it is recommended to use
	// “google.protobuf.Struct“, “google.protobuf.StringValue“, or “google.protobuf.BytesValue“.
	// These types are passed directly as bytes to the module, so the module does not need to have
	// knowledge of protobuf encoding. Otherwise, the serialized bytes of the type are passed.
	// If not specified, an empty configuration is passed.
	lb_policy_config?: _
}
