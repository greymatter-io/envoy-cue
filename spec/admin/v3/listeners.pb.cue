package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Admin endpoint uses this wrapper for ``/listeners`` to display listener status information.
// See :ref:`/listeners <operations_admin_interface_listeners>` for more information.
#Listeners: {
	"@type": "type.googleapis.com/envoy.admin.v3.Listeners"
	// List of listener statuses.
	listener_statuses?: [...#ListenerStatus]
}

// Details an individual listener's current status.
#ListenerStatus: {
	"@type": "type.googleapis.com/envoy.admin.v3.ListenerStatus"
	// Name of the listener
	name?: string
	// The actual local address that the listener is listening on. If a listener was configured
	// to listen on port 0, then this address has the port that was allocated by the OS.
	local_address?: v3.#Address
	// The additional addresses the listener is listening on as specified via the :ref:`additional_addresses <envoy_v3_api_field_config.listener.v3.Listener.additional_addresses>`
	// configuration.
	additional_local_addresses?: [...v3.#Address]
}
