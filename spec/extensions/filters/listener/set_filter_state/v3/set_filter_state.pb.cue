package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/filters/common/set_filter_state/v3"
)

#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.listener.set_filter_state.v3.Config"
	// A sequence of the filter state values to apply in the specified order
	// when a new connection is accepted.
	on_accept?: [...v3.#FilterStateValue]
}
