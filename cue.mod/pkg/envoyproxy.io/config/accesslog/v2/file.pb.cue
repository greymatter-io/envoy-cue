package v2

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
)

// Custom configuration for an :ref:`AccessLog <envoy_api_msg_config.filter.accesslog.v2.AccessLog>`
// that writes log entries directly to a file. Configures the built-in *envoy.access_loggers.file*
// AccessLog.
#FileAccessLog: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v2.FileAccessLog"
	// A path to a local file to which to write the access log entries.
	path?: string
	// Access log :ref:`format string<config_access_log_format_strings>`.
	// Envoy supports :ref:`custom access log formats <config_access_log_format>` as well as a
	// :ref:`default format <config_access_log_default_format>`.
	format?: string
	// Access log :ref:`format dictionary<config_access_log_format_dictionaries>`. All values
	// are rendered as strings.
	json_format?: _struct.#Struct
	// Access log :ref:`format dictionary<config_access_log_format_dictionaries>`. Values are
	// rendered as strings, numbers, or boolean values as appropriate. Nested JSON objects may
	// be produced by some command operators (e.g.FILTER_STATE or DYNAMIC_METADATA). See the
	// documentation for a specific command operator for details.
	typed_json_format?: _struct.#Struct
}
