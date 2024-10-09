package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
)

// Configuration defining a jittered exponential back off strategy.
#BackoffStrategy: {
	"@type": "type.googleapis.com/envoy.config.core.v3.BackoffStrategy"
	// The base interval to be used for the next back off computation. It should
	// be greater than zero and less than or equal to :ref:`max_interval
	// <envoy_v3_api_field_config.core.v3.BackoffStrategy.max_interval>`.
	base_interval?: durationpb.#Duration
	// Specifies the maximum interval between retries. This parameter is optional,
	// but must be greater than or equal to the :ref:`base_interval
	// <envoy_v3_api_field_config.core.v3.BackoffStrategy.base_interval>` if set. The default
	// is 10 times the :ref:`base_interval
	// <envoy_v3_api_field_config.core.v3.BackoffStrategy.base_interval>`.
	max_interval?: durationpb.#Duration
}
