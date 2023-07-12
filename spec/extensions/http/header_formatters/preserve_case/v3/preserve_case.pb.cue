package v3

#PreserveCaseFormatterConfig_FormatterTypeOnEnvoyHeaders: "DEFAULT" | "PROPER_CASE"

PreserveCaseFormatterConfig_FormatterTypeOnEnvoyHeaders_DEFAULT:     "DEFAULT"
PreserveCaseFormatterConfig_FormatterTypeOnEnvoyHeaders_PROPER_CASE: "PROPER_CASE"

// Configuration for the preserve case header formatter.
// See the :ref:`header casing <config_http_conn_man_header_casing>` configuration guide for more
// information.
#PreserveCaseFormatterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.http.header_formatters.preserve_case.v3.PreserveCaseFormatterConfig"
	// Allows forwarding reason phrase text.
	// This is off by default, and a standard reason phrase is used for a corresponding HTTP response code.
	forward_reason_phrase?: bool
	// Type of formatter to use on headers which are added by Envoy (which are lower case by default).
	// The default type is DEFAULT, use LowerCase on Envoy headers.
	formatter_type_on_envoy_headers?: #PreserveCaseFormatterConfig_FormatterTypeOnEnvoyHeaders
}
