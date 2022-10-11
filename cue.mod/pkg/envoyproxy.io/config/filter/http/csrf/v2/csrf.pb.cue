package v2

import (
	core "envoyproxy.io/api/v2/core"
	matcher "envoyproxy.io/type/matcher"
)

// CSRF filter config.
#CsrfPolicy: {
	"@type": "type.googleapis.com/envoy.config.filter.http.csrf.v2.CsrfPolicy"
	// Specifies the % of requests for which the CSRF filter is enabled.
	//
	// If :ref:`runtime_key <envoy_api_field_core.RuntimeFractionalPercent.runtime_key>` is specified,
	// Envoy will lookup the runtime key to get the percentage of requests to filter.
	//
	// .. note::
	//
	//   This field defaults to 100/:ref:`HUNDRED
	//   <envoy_api_enum_type.FractionalPercent.DenominatorType>`.
	filter_enabled?: core.#RuntimeFractionalPercent
	// Specifies that CSRF policies will be evaluated and tracked, but not enforced.
	//
	// This is intended to be used when ``filter_enabled`` is off and will be ignored otherwise.
	//
	// If :ref:`runtime_key <envoy_api_field_core.RuntimeFractionalPercent.runtime_key>` is specified,
	// Envoy will lookup the runtime key to get the percentage of requests for which it will evaluate
	// and track the request's *Origin* and *Destination* to determine if it's valid, but will not
	// enforce any policies.
	shadow_enabled?: core.#RuntimeFractionalPercent
	// Specifies additional source origins that will be allowed in addition to
	// the destination origin.
	//
	// More information on how this can be configured via runtime can be found
	// :ref:`here <csrf-configuration>`.
	additional_origins?: [...matcher.#StringMatcher]
}
