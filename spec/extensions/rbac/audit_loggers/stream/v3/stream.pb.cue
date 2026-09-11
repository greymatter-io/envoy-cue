package v3

// Custom configuration for the RBAC audit logger that writes log entries
// directly to the operating system's standard output.
// The logger outputs in JSON format and is currently not configurable.
#StdoutAuditLog: {
	"@type": "type.googleapis.com/envoy.extensions.rbac.audit_loggers.stream.v3.StdoutAuditLog"
}
