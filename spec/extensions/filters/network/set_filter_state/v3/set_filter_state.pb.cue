package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/filters/common/set_filter_state/v3"
)

#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.set_filter_state.v3.Config"
	// A sequence of the filter state values to apply in the specified order
	// when a new connection is received.
	on_new_connection?: [...v3.#FilterStateValue]
	// A sequence of the filter state values to apply in the specified order
	// when the downstream TLS handshake is complete.
	//
	// For non-TLS downstream connections (where there is no TLS handshake), this
	// list is applied when a new connection is received.
	on_downstream_tls_handshake?: [...v3.#FilterStateValue]
	// A sequence of the filter state values to apply in the specified order
	// when data is first received from the downstream connection.
	on_downstream_data?: [...v3.#FilterStateValue]
}
