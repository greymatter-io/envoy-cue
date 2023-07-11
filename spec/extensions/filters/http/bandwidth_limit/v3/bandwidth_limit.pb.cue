package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Defines the mode for the bandwidth limit filter.
// Values represent bitmask.
#BandwidthLimit_EnableMode: "DISABLED" | "REQUEST" | "RESPONSE" | "REQUEST_AND_RESPONSE"

BandwidthLimit_EnableMode_DISABLED:             "DISABLED"
BandwidthLimit_EnableMode_REQUEST:              "REQUEST"
BandwidthLimit_EnableMode_RESPONSE:             "RESPONSE"
BandwidthLimit_EnableMode_REQUEST_AND_RESPONSE: "REQUEST_AND_RESPONSE"

// [#next-free-field: 8]
#BandwidthLimit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.bandwidth_limit.v3.BandwidthLimit"
	// The human readable prefix to use when emitting stats.
	stat_prefix?: string
	// The enable mode for the bandwidth limit filter.
	// Default is Disabled.
	enable_mode?: #BandwidthLimit_EnableMode
	// The limit supplied in KiB/s.
	//
	// .. note::
	//   It's fine for the limit to be unset for the global configuration since the bandwidth limit
	//   can be applied at a the virtual host or route level. Thus, the limit must be set for the
	//   per route configuration otherwise the config will be rejected.
	//
	// .. note::
	//   When using per route configuration, the limit becomes unique to that route.
	//
	limit_kbps?: uint64
	// Optional Fill interval in milliseconds for the token refills. Defaults to 50ms.
	// It must be at least 20ms to avoid too aggressive refills.
	fill_interval?: string
	// Runtime flag that controls whether the filter is enabled or not. If not specified, defaults
	// to enabled.
	runtime_enabled?: v3.#RuntimeFeatureFlag
	// Enable response trailers.
	//
	// .. note::
	//
	//   * If set true, the response trailers ``bandwidth-request-delay-ms`` and ``bandwidth-response-delay-ms`` will be added, prefixed by ``response_trailer_prefix``.
	//   * bandwidth-request-delay-ms: delay time in milliseconds it took for the request stream transfer.
	//   * bandwidth-response-delay-ms: delay time in milliseconds it took for the response stream transfer.
	//   * If :ref:`enable_mode <envoy_v3_api_field_extensions.filters.http.bandwidth_limit.v3.BandwidthLimit.enable_mode>` is ``DISABLED`` or ``REQUEST``, the trailers will not be set.
	//   * If both the request and response delay time is 0, the trailers will not be set.
	//
	enable_response_trailers?: bool
	// Optional The prefix for the response trailers.
	response_trailer_prefix?: string
}
