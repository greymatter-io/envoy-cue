package v3

// Health check event file sink.
// The health check event will be converted to JSON.
#HealthCheckEventFileSink: {
	"@type": "type.googleapis.com/envoy.extensions.health_check.event_sinks.file.v3.HealthCheckEventFileSink"
	// Specifies the path to the health check event log.
	event_log_path?: string
}
