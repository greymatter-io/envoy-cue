package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/v3"
)

#ScaleTimersOverloadActionConfig_TimerType: "UNSPECIFIED" | "HTTP_DOWNSTREAM_CONNECTION_IDLE" | "HTTP_DOWNSTREAM_STREAM_IDLE" | "TRANSPORT_SOCKET_CONNECT"

ScaleTimersOverloadActionConfig_TimerType_UNSPECIFIED:                     "UNSPECIFIED"
ScaleTimersOverloadActionConfig_TimerType_HTTP_DOWNSTREAM_CONNECTION_IDLE: "HTTP_DOWNSTREAM_CONNECTION_IDLE"
ScaleTimersOverloadActionConfig_TimerType_HTTP_DOWNSTREAM_STREAM_IDLE:     "HTTP_DOWNSTREAM_STREAM_IDLE"
ScaleTimersOverloadActionConfig_TimerType_TRANSPORT_SOCKET_CONNECT:        "TRANSPORT_SOCKET_CONNECT"

#ResourceMonitor: {
	"@type": "type.googleapis.com/envoy.config.overload.v3.ResourceMonitor"
	// The name of the resource monitor to instantiate. Must match a registered
	// resource monitor type.
	// See the :ref:`extensions listed in typed_config below <extension_category_envoy.resource_monitors>` for the default list of available resource monitor.
	name?:         string
	typed_config?: _
}

#ThresholdTrigger: {
	"@type": "type.googleapis.com/envoy.config.overload.v3.ThresholdTrigger"
	// If the resource pressure is greater than or equal to this value, the trigger
	// will enter saturation.
	value?: float64
}

#ScaledTrigger: {
	"@type": "type.googleapis.com/envoy.config.overload.v3.ScaledTrigger"
	// If the resource pressure is greater than this value, the trigger will be in the
	// :ref:`scaling <arch_overview_overload_manager-triggers-state>` state with value
	// ``(pressure - scaling_threshold) / (saturation_threshold - scaling_threshold)``.
	scaling_threshold?: float64
	// If the resource pressure is greater than this value, the trigger will enter saturation.
	saturation_threshold?: float64
}

#Trigger: {
	"@type": "type.googleapis.com/envoy.config.overload.v3.Trigger"
	// The name of the resource this is a trigger for.
	name?:      string
	threshold?: #ThresholdTrigger
	scaled?:    #ScaledTrigger
}

// Typed configuration for the "envoy.overload_actions.reduce_timeouts" action. See
// :ref:`the docs <config_overload_manager_reducing_timeouts>` for an example of how to configure
// the action with different timeouts and minimum values.
#ScaleTimersOverloadActionConfig: {
	"@type": "type.googleapis.com/envoy.config.overload.v3.ScaleTimersOverloadActionConfig"
	// A set of timer scaling rules to be applied.
	timer_scale_factors?: [...#ScaleTimersOverloadActionConfig_ScaleTimer]
}

#OverloadAction: {
	"@type": "type.googleapis.com/envoy.config.overload.v3.OverloadAction"
	// The name of the overload action. This is just a well-known string that listeners can
	// use for registering callbacks. Custom overload actions should be named using reverse
	// DNS to ensure uniqueness.
	name?: string
	// A set of triggers for this action. The state of the action is the maximum
	// state of all triggers, which can be scaling between 0 and 1 or saturated. Listeners
	// are notified when the overload action changes state.
	triggers?: [...#Trigger]
	// Configuration for the action being instantiated.
	typed_config?: _
}

// Configuration for which accounts the WatermarkBuffer Factories should
// track.
#BufferFactoryConfig: {
	"@type": "type.googleapis.com/envoy.config.overload.v3.BufferFactoryConfig"
	// The minimum power of two at which Envoy starts tracking an account.
	//
	// Envoy has 8 power of two buckets starting with the provided exponent below.
	// Concretely the 1st bucket contains accounts for streams that use
	// [2^minimum_account_to_track_power_of_two,
	// 2^(minimum_account_to_track_power_of_two + 1)) bytes.
	// With the 8th bucket tracking accounts
	// >= 128 * 2^minimum_account_to_track_power_of_two.
	//
	// The maximum value is 56, since we're using uint64_t for bytes counting,
	// and that's the last value that would use the 8 buckets. In practice,
	// we don't expect the proxy to be holding 2^56 bytes.
	//
	// If omitted, Envoy should not do any tracking.
	minimum_account_to_track_power_of_two?: uint32
}

#OverloadManager: {
	"@type": "type.googleapis.com/envoy.config.overload.v3.OverloadManager"
	// The interval for refreshing resource usage.
	refresh_interval?: string
	// The set of resources to monitor.
	resource_monitors?: [...#ResourceMonitor]
	// The set of overload actions.
	actions?: [...#OverloadAction]
	// Configuration for buffer factory.
	buffer_factory_config?: #BufferFactoryConfig
}

#ScaleTimersOverloadActionConfig_ScaleTimer: {
	"@type": "type.googleapis.com/envoy.config.overload.v3.ScaleTimersOverloadActionConfig_ScaleTimer"
	// The type of timer this minimum applies to.
	timer?: #ScaleTimersOverloadActionConfig_TimerType
	// Sets the minimum duration as an absolute value.
	min_timeout?: string
	// Sets the minimum duration as a percentage of the maximum value.
	min_scale?: v3.#Percent
}
