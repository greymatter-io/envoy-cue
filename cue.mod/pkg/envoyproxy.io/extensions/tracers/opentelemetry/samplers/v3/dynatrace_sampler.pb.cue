package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration for the Dynatrace Sampler extension.
// [#extension: envoy.tracers.opentelemetry.samplers.dynatrace]
#DynatraceSamplerConfig: {
	"@type": "type.googleapis.com/envoy.extensions.tracers.opentelemetry.samplers.v3.DynatraceSamplerConfig"
	// The Dynatrace tenant.
	//
	// The value can be obtained from the Envoy deployment page in Dynatrace.
	tenant?: string
	// The id of the Dynatrace cluster id.
	//
	// The value can be obtained from the Envoy deployment page in Dynatrace.
	cluster_id?: int32
	// The HTTP service to fetch the sampler configuration from the Dynatrace API (root spans per minute). For example:
	//
	// .. code-block:: yaml
	//
	//	http_service:
	//	  http_uri:
	//	    cluster: dynatrace
	//	    uri: <tenant>.dev.dynatracelabs.com/api/v2/samplingConfiguration
	//	    timeout: 10s
	//	  request_headers_to_add:
	//	  - header:
	//	      key : "authorization"
	//	      value: "Api-Token dt..."
	http_service?: v3.#HttpService
	// Default number of root spans per minute, used when the value can't be obtained from the Dynatrace API.
	//
	// A default value of “1000“ is used when:
	//
	// - “root_spans_per_minute“ is unset
	// - “root_spans_per_minute“ is set to 0
	root_spans_per_minute?: uint32
}
