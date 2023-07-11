package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Cors filter config.
#Cors: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.cors.v3.Cors"
}

// [#next-free-field: 10]
#CorsPolicy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.cors.v3.CorsPolicy"
	// Specifies string patterns that match allowed origins. An origin is allowed if any of the
	// string matchers match.
	allow_origin_string_match?: [...v3.#StringMatcher]
	// Specifies the content for the ``access-control-allow-methods`` header.
	allow_methods?: string
	// Specifies the content for the ``access-control-allow-headers`` header.
	allow_headers?: string
	// Specifies the content for the ``access-control-expose-headers`` header.
	expose_headers?: string
	// Specifies the content for the ``access-control-max-age`` header.
	max_age?: string
	// Specifies whether the resource allows credentials.
	allow_credentials?: bool
	// Specifies the % of requests for which the CORS filter is enabled.
	//
	// If neither ``filter_enabled``, nor ``shadow_enabled`` are specified, the CORS
	// filter will be enabled for 100% of the requests.
	//
	// If :ref:`runtime_key <envoy_v3_api_field_config.core.v3.RuntimeFractionalPercent.runtime_key>` is
	// specified, Envoy will lookup the runtime key to get the percentage of requests to filter.
	filter_enabled?: v31.#RuntimeFractionalPercent
	// Specifies the % of requests for which the CORS policies will be evaluated and tracked, but not
	// enforced.
	//
	// This field is intended to be used when ``filter_enabled`` is off. That field have to explicitly disable
	// the filter in order for this setting to take effect.
	//
	// If :ref:`runtime_key <envoy_v3_api_field_config.core.v3.RuntimeFractionalPercent.runtime_key>` is specified,
	// Envoy will lookup the runtime key to get the percentage of requests for which it will evaluate
	// and track the request's ``Origin`` to determine if it's valid but will not enforce any policies.
	shadow_enabled?: v31.#RuntimeFractionalPercent
	// Specify whether allow requests whose target server's IP address is more private than that from
	// which the request initiator was fetched.
	//
	// More details refer to https://developer.chrome.com/blog/private-network-access-preflight.
	allow_private_network_access?: bool
}
