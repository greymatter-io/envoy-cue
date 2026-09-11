package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/filters/network/http_connection_manager/v3"
)

// Configuration for the drain-aware HTTP Connection Manager.
// All HCM fields are forwarded verbatim; the only difference is that this
// filter registers a listener-drain callback and emits a GOAWAY before the
// connection is closed.
#DrainAwareHttpConnectionManager: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.reverse_tunnel.v3.DrainAwareHttpConnectionManager"
	// The underlying HCM configuration to apply.
	hcm_config?: v3.#HttpConnectionManager
	// When true, a peer-initiated GOAWAY on a reverse tunnel makes the initiator drop the draining
	// tunnel and dial a replacement, so capacity is restored before the old tunnel closes while its
	// in-flight streams finish. Default false, so the behavior is opt-in and unconfigured listeners
	// are unaffected.
	enable_drain_with_goaway?: bool
}
