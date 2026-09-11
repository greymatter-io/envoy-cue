package v3

// Configuration for a QUIC debug visitor which emits stats from the underlying QUIC transport.
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.quic.connection_debug_visitor.quic_stats.v3.Config"
	// Period to update stats while the connection is open. If unset, updates only happen when the
	// connection is closed. Stats are always updated one final time when the connection is closed.
	update_period?: string
}
