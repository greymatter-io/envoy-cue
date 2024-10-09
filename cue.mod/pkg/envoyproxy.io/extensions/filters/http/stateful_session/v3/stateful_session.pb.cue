package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#StatefulSession: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.stateful_session.v3.StatefulSession"
	// Specific implementation of session state. This session state will be used to store and
	// get address of the upstream host to which the session is assigned.
	//
	// [#extension-category: envoy.http.stateful_session]
	session_state?: v3.#TypedExtensionConfig
	// If set to True, the HTTP request must be routed to the requested destination.
	// If the requested destination is not available, Envoy returns 503. Defaults to False.
	strict?: bool
}

#StatefulSessionPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.stateful_session.v3.StatefulSessionPerRoute"
	// Disable the stateful session filter for this particular vhost or route. If disabled is
	// specified in multiple per-filter-configs, the most specific one will be used.
	disabled?: bool
	// Per-route stateful session configuration that can be served by RDS or static route table.
	stateful_session?: #StatefulSession
}
