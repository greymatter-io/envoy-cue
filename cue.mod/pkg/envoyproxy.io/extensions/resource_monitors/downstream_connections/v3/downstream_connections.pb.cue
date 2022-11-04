package v3

// The downstream connections resource monitor tracks the global number of open downstream connections.
#DownstreamConnectionsConfig: {
	"@type": "type.googleapis.com/envoy.extensions.resource_monitors.downstream_connections.v3.DownstreamConnectionsConfig"
	// Maximum threshold for global open downstream connections, defaults to 0.
	// If monitor is enabled in Overload manager api, this field should be explicitly configured with value greater than 0.
	max_active_downstream_connections?: int64
}
