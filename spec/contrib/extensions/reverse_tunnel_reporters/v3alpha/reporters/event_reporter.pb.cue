package reporters

#ReverseConnectionReporterClient: {
	"@type": "type.googleapis.com/envoy.extensions.reverse_tunnel_reporters.v3alpha.reporters.ReverseConnectionReporterClient"
	// Name to use to pick out the client should match the one reported by the factory.
	name?: string
	// Typed config for the client
	typed_config?: _
}

// Configuration for the connection event reporter.
#EventReporterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.reverse_tunnel_reporters.v3alpha.reporters.EventReporterConfig"
	// Stat prefix for this reporter's metrics.
	// Metrics will be emitted as “{stat_prefix}.events_pushed“, etc.
	stat_prefix?: string
	// List of clients to report to.
	clients?: [...#ReverseConnectionReporterClient]
}
