package v3alpha

#PostgresInspector: {
	"@type": "type.googleapis.com/envoy.extensions.filters.listener.postgres_inspector.v3alpha.PostgresInspector"
	// Enable extraction of connection metadata (user, database, application name) from
	// the startup message. This metadata is made available for access logging and stats.
	//
	// Defaults to “true“.
	enable_metadata_extraction?: bool
	// The maximum size of the startup message that the postgres inspector will accept.
	// Messages larger than this will be rejected. If not specified, defaults to 10KB.
	//
	// PostgreSQL defines MAX_STARTUP_PACKET_LENGTH as 10KB.
	// Valid range is 256 bytes to 10KB.
	max_startup_message_size?: uint32
	// Timeout for the inspector to receive and process the startup message.
	// The timeout starts when the connection is accepted by the listener.
	// If the timeout is reached before the startup message is fully received and processed,
	// the connection will be closed.
	//
	// If not specified, defaults to 10 seconds. Minimum is 1 second.
	startup_timeout?: string
}

// StartupMetadata stores connection attributes extracted from the PostgreSQL startup message.
// This is attached as typed dynamic metadata under the key “envoy.postgres_inspector“.
#StartupMetadata: {
	"@type": "type.googleapis.com/envoy.extensions.filters.listener.postgres_inspector.v3alpha.StartupMetadata"
	// The username supplied in the startup message.
	user?: string
	// The database name supplied in the startup message. If not provided, it may default to the user name.
	database?: string
	// The application name supplied in the startup message.
	application_name?: string
}
