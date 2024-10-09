package v3

import (
	v3 "envoyproxy.io/extensions/filters/common/set_filter_state/v3"
)

#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.set_filter_state.v3.Config"
	// A sequence of the filter state values to apply in the specified order
	// when a new connection is received.
	on_new_connection?: [...v3.#FilterStateValue]
}
