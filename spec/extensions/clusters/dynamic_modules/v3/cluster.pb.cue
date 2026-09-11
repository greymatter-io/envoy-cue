package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// Configuration for the dynamic modules cluster.
//
// This cluster type delegates host discovery and load balancing to a dynamic module. The module
// manages hosts via callbacks such as “envoy_dynamic_module_callback_cluster_add_host“ and
// “envoy_dynamic_module_callback_cluster_remove_host“. The cluster must use
// “lb_policy: CLUSTER_PROVIDED“ since the module provides its own load balancer.
//
// [#extension: envoy.clusters.dynamic_modules]
#ClusterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.dynamic_modules.v3.ClusterConfig"
	// The dynamic module configuration for the cluster.
	dynamic_module_config?: v3.#DynamicModuleConfig
	// The name to identify the cluster implementation within the module.
	// This is passed to the module's “envoy_dynamic_module_on_cluster_config_new“ function.
	cluster_name?: string
	// The configuration for the module's cluster implementation.
	// This is passed to the module's “envoy_dynamic_module_on_cluster_config_new“ function.
	// The configuration can be any protobuf message. However, it is recommended to use
	// “google.protobuf.Struct“, “google.protobuf.StringValue“, or “google.protobuf.BytesValue“.
	// These types are passed directly as bytes to the module, so the module does not need to have
	// knowledge of protobuf encoding. Otherwise, the serialized bytes of the type are passed.
	// If not specified, an empty configuration is passed.
	cluster_config?: _
}
