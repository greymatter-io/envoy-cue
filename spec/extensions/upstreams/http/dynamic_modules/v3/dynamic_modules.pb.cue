package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the dynamic modules upstream HTTP TCP bridge.
//
// This upstream type delegates HTTP-to-TCP protocol bridging to a dynamic module. The module
// transforms HTTP request headers and body into raw TCP data for the upstream connection, and
// converts raw TCP response data back into HTTP responses for the downstream client.
//
// [#extension: envoy.upstreams.http.dynamic_modules]
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.upstreams.http.dynamic_modules.v3.Config"
	// The dynamic module configuration.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name to identify the bridge implementation within the module.
	// This is passed to the module's “envoy_dynamic_module_on_upstream_http_tcp_bridge_config_new“
	// function.
	bridge_name?: string
	// The configuration for the module's bridge implementation.
	// This is passed to the module's “envoy_dynamic_module_on_upstream_http_tcp_bridge_config_new“
	// function. The configuration can be any protobuf message. However, it is recommended to use
	// “google.protobuf.Struct“, “google.protobuf.StringValue“, or “google.protobuf.BytesValue“.
	// These types are passed directly as bytes to the module, so the module does not need to have
	// knowledge of protobuf encoding. Otherwise, the serialized bytes of the type are passed.
	// If not specified, an empty configuration is passed.
	bridge_config?: _
}
