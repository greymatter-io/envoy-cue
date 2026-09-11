package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#StatefulSession: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.stateful_session.v3.StatefulSession"
	// Specifies the implementation of session state. This session state is used to store and retrieve the address of the
	// upstream host assigned to the session.
	//
	// [#extension-category: envoy.http.stateful_session]
	session_state?: v3.#TypedExtensionConfig
	// Determines whether the HTTP request must be strictly routed to the requested destination. When set to “true“,
	// if the requested destination is not found in the set of available endpoints, Envoy will return a status code
	// determined by “status_on_strict_destination_not_found“. If the destination exists but is unhealthy, Envoy will
	// always return “503“ regardless of “status_on_strict_destination_not_found“. The default value is “false“,
	// which allows Envoy to fall back to its load balancing mechanism and route the request according to the load
	// balancing algorithm.
	strict?: bool
	// Optional stat prefix. If specified, the filter will emit statistics in the
	// “http.<stat_prefix>.stateful_session.<stat_prefix>.“ namespace. If not specified, no statistics will be emitted.
	//
	// .. note::
	//
	//	Per-route configuration overrides do not support statistics and will not emit stats even if this field is set
	//	in the per-route config.
	stat_prefix?: string
	// The HTTP status code to return when “strict“ mode is enabled and the requested destination
	// is not found in the set of available endpoints. This does not apply when the destination exists
	// but is unhealthy. This field has no effect when “strict“ is set to “false“ and will be
	// ignored. Defaults to “503“ (Service Unavailable) if not specified or set to “0“.
	status_on_strict_destination_not_found?: uint32
}

#StatefulSessionPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.stateful_session.v3.StatefulSessionPerRoute"
	// Disable the stateful session filter for this particular vhost or route. If disabled is
	// specified in multiple per-filter-configs, the most specific one will be used.
	disabled?: bool
	// Per-route stateful session configuration that can be served by RDS or static route table.
	stateful_session?: #StatefulSession
}
