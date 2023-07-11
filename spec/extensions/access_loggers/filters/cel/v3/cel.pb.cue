package v3

// ExpressionFilter is an access logging filter that evaluates configured
// symbolic Common Expression Language expressions to inform the decision
// to generate an access log.
#ExpressionFilter: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.filters.cel.v3.ExpressionFilter"
	// Expression that, when evaluated, will be used to filter access logs.
	// Expressions are based on the set of Envoy :ref:`attributes <arch_overview_attributes>`.
	// The provided expression must evaluate to true for logging (expression errors are considered false).
	// Examples:
	// - ``response.code >= 400``
	// - ``(connection.mtls && request.headers['x-log-mtls'] == 'true') || request.url_path.contains('v1beta3')``
	expression?: string
}
