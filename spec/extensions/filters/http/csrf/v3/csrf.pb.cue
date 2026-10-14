package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
)

// CSRF filter config.
#CsrfPolicy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.csrf.v3.CsrfPolicy"
	// Specifies the % of requests for which the CSRF filter is enabled.
	//
	// If :ref:`runtime_key <envoy_v3_api_field_config.core.v3.RuntimeFractionalPercent.runtime_key>` is specified,
	// Envoy will lookup the runtime key to get the percentage of requests to filter.
	//
	// .. note::
	//
	//   This field defaults to 100/:ref:`HUNDRED
	//   <envoy_v3_api_enum_type.v3.FractionalPercent.DenominatorType>`.
	filter_enabled?: v3.#RuntimeFractionalPercent
	// Specifies that CSRF policies will be evaluated and tracked, but not enforced.
	//
	// This is intended to be used when ``filter_enabled`` is off and will be ignored otherwise.
	//
	// If :ref:`runtime_key <envoy_v3_api_field_config.core.v3.RuntimeFractionalPercent.runtime_key>` is specified,
	// Envoy will lookup the runtime key to get the percentage of requests for which it will evaluate
	// and track the request's ``Origin`` and ``Destination`` to determine if it's valid, but will not
	// enforce any policies.
	shadow_enabled?: v3.#RuntimeFractionalPercent
	// Specifies additional source origins that will be allowed in addition to
	// the destination origin.
	//
	// More information on how this can be configured via runtime can be found
	// :ref:`here <csrf-configuration>`.
	additional_origins?: [...v31.#StringMatcher]
}
