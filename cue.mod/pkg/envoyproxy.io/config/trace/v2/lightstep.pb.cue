package v2

// Available propagation modes
#LightstepConfig_PropagationMode: "ENVOY" | "LIGHTSTEP" | "B3" | "TRACE_CONTEXT"

LightstepConfig_PropagationMode_ENVOY:         "ENVOY"
LightstepConfig_PropagationMode_LIGHTSTEP:     "LIGHTSTEP"
LightstepConfig_PropagationMode_B3:            "B3"
LightstepConfig_PropagationMode_TRACE_CONTEXT: "TRACE_CONTEXT"

// Configuration for the LightStep tracer.
// [#extension: envoy.tracers.lightstep]
#LightstepConfig: {
	"@type": "type.googleapis.com/envoy.config.trace.v2.LightstepConfig"
	// The cluster manager cluster that hosts the LightStep collectors.
	collector_cluster?: string
	// File containing the access token to the `LightStep
	// <https://lightstep.com/>`_ API.
	access_token_file?: string
	// Propagation modes to use by LightStep's tracer.
	propagation_modes?: [...#LightstepConfig_PropagationMode]
}
