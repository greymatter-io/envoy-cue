package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/filters/common/set_filter_state/v3"
)

#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.set_filter_state.v3.Config"
	// A sequence of the filter state values to apply in the specified order
	// when a new request is received.
	on_request_headers?: [...v3.#FilterStateValue]
	// Clear the route cache for the current client request. This is necessary
	// if the route configuration may depend on the filter state values set by
	// this filter.
	clear_route_cache?: bool
}
