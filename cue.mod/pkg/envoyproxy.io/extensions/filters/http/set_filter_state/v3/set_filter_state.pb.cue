package v3

import (
	v3 "envoyproxy.io/extensions/filters/common/set_filter_state/v3"
)

#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.set_filter_state.v3.Config"
	// A sequence of the filter state values to apply in the specified order
	// when a new request is received.
	on_request_headers?: [...v3.#FilterStateValue]
}
