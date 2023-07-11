package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/v3"
)

// On which direction should the filter check for the ``kill_request_header``.
// Default to ``REQUEST`` if unspecified.
#KillRequest_Direction: "REQUEST" | "RESPONSE"

KillRequest_Direction_REQUEST:  "REQUEST"
KillRequest_Direction_RESPONSE: "RESPONSE"

// Configuration for KillRequest filter.
#KillRequest: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.kill_request.v3.KillRequest"
	// The probability that a Kill request will be triggered.
	probability?: v3.#FractionalPercent
	// The name of the kill request header. If this field is not empty, it will override the :ref:`default header <config_http_filters_kill_request_http_header>` name. Otherwise the default header name will be used.
	kill_request_header?: string
	direction?:           #KillRequest_Direction
}
