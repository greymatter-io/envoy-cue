package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration for the TCP Stats transport socket wrapper, which wraps another transport socket for
// all communication, but emits stats about the underlying TCP connection.
//
// The stats are documented :ref:`here <config_listener_stats_tcp>` for listeners and
// :ref:`here <config_cluster_manager_cluster_stats_tcp>` for clusters.
//
// This transport socket is currently only supported on Linux.
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tcp_stats.v3.Config"
	// The underlying transport socket being wrapped.
	transport_socket?: v3.#TransportSocket
	// Period to update stats while the connection is open. If unset, updates only happen when the
	// connection is closed. Stats are always updated one final time when the connection is closed.
	update_period?: string
}
