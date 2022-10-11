package v2alpha

import (
	_type "envoyproxy.io/type"
	core "envoyproxy.io/api/v2/core"
)

// Configuration parameters for the gradient controller.
#GradientControllerConfig: {
	"@type": "type.googleapis.com/envoy.config.filter.http.adaptive_concurrency.v2alpha.GradientControllerConfig"
	// The percentile to use when summarizing aggregated samples. Defaults to p50.
	sample_aggregate_percentile?: _type.#Percent
	concurrency_limit_params?:    #GradientControllerConfig_ConcurrencyLimitCalculationParams
	min_rtt_calc_params?:         #GradientControllerConfig_MinimumRTTCalculationParams
}

#AdaptiveConcurrency: {
	"@type": "type.googleapis.com/envoy.config.filter.http.adaptive_concurrency.v2alpha.AdaptiveConcurrency"
	// Gradient concurrency control will be used.
	gradient_controller_config?: #GradientControllerConfig
	// If set to false, the adaptive concurrency filter will operate as a pass-through filter. If the
	// message is unspecified, the filter will be enabled.
	enabled?: core.#RuntimeFeatureFlag
}

// Parameters controlling the periodic recalculation of the concurrency limit from sampled request
// latencies.
#GradientControllerConfig_ConcurrencyLimitCalculationParams: {
	"@type": "type.googleapis.com/envoy.config.filter.http.adaptive_concurrency.v2alpha.GradientControllerConfig_ConcurrencyLimitCalculationParams"
	// The allowed upper-bound on the calculated concurrency limit. Defaults to 1000.
	max_concurrency_limit?: uint32
	// The period of time samples are taken to recalculate the concurrency limit.
	concurrency_update_interval?: string
}

// Parameters controlling the periodic minRTT recalculation.
// [#next-free-field: 6]
#GradientControllerConfig_MinimumRTTCalculationParams: {
	"@type": "type.googleapis.com/envoy.config.filter.http.adaptive_concurrency.v2alpha.GradientControllerConfig_MinimumRTTCalculationParams"
	// The time interval between recalculating the minimum request round-trip time.
	interval?: string
	// The number of requests to aggregate/sample during the minRTT recalculation window before
	// updating. Defaults to 50.
	request_count?: uint32
	// Randomized time delta that will be introduced to the start of the minRTT calculation window.
	// This is represented as a percentage of the interval duration. Defaults to 15%.
	//
	// Example: If the interval is 10s and the jitter is 15%, the next window will begin
	// somewhere in the range (10s - 11.5s).
	jitter?: _type.#Percent
	// The concurrency limit set while measuring the minRTT. Defaults to 3.
	min_concurrency?: uint32
	// Amount added to the measured minRTT to add stability to the concurrency limit during natural
	// variability in latency. This is expressed as a percentage of the measured value and can be
	// adjusted to allow more or less tolerance to the sampled latency values.
	//
	// Defaults to 25%.
	buffer?: _type.#Percent
}
