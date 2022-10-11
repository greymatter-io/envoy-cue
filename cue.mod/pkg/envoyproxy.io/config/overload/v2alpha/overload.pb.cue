package v2alpha

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
)

#ResourceMonitor: {
	"@type": "type.googleapis.com/envoy.config.overload.v2alpha.ResourceMonitor"
	// The name of the resource monitor to instantiate. Must match a registered
	// resource monitor type. The built-in resource monitors are:
	//
	// * :ref:`envoy.resource_monitors.fixed_heap
	//   <envoy_api_msg_config.resource_monitor.fixed_heap.v2alpha.FixedHeapConfig>`
	// * :ref:`envoy.resource_monitors.injected_resource
	//   <envoy_api_msg_config.resource_monitor.injected_resource.v2alpha.InjectedResourceConfig>`
	name?: string
	// Deprecated: Do not use.
	config?:       _struct.#Struct
	typed_config?: _
}

#ThresholdTrigger: {
	"@type": "type.googleapis.com/envoy.config.overload.v2alpha.ThresholdTrigger"
	// If the resource pressure is greater than or equal to this value, the trigger
	// will fire.
	value?: float64
}

#Trigger: {
	"@type": "type.googleapis.com/envoy.config.overload.v2alpha.Trigger"
	// The name of the resource this is a trigger for.
	name?:      string
	threshold?: #ThresholdTrigger
}

#OverloadAction: {
	"@type": "type.googleapis.com/envoy.config.overload.v2alpha.OverloadAction"
	// The name of the overload action. This is just a well-known string that listeners can
	// use for registering callbacks. Custom overload actions should be named using reverse
	// DNS to ensure uniqueness.
	name?: string
	// A set of triggers for this action. If any of these triggers fire the overload action
	// is activated. Listeners are notified when the overload action transitions from
	// inactivated to activated, or vice versa.
	triggers?: [...#Trigger]
}

#OverloadManager: {
	"@type": "type.googleapis.com/envoy.config.overload.v2alpha.OverloadManager"
	// The interval for refreshing resource usage.
	refresh_interval?: string
	// The set of resources to monitor.
	resource_monitors?: [...#ResourceMonitor]
	// The set of overload actions.
	actions?: [...#OverloadAction]
}
