package v2alpha

import (
	core "envoyproxy.io/api/v2/core"
)

// Admin endpoint uses this wrapper for `/listeners` to display listener status information.
// See :ref:`/listeners <operations_admin_interface_listeners>` for more information.
#Listeners: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.Listeners"
	// List of listener statuses.
	listener_statuses?: [...#ListenerStatus]
}

// Details an individual listener's current status.
#ListenerStatus: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ListenerStatus"
	// Name of the listener
	name?: string
	// The actual local address that the listener is listening on. If a listener was configured
	// to listen on port 0, then this address has the port that was allocated by the OS.
	local_address?: core.#Address
}
