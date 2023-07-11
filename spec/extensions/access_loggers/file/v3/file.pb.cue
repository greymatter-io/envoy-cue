package v3

import (
	_struct "envoyproxy.io/envoy-cue/spec/deps/golang/protobuf/ptypes/struct"
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Custom configuration for an :ref:`AccessLog <envoy_v3_api_msg_config.accesslog.v3.AccessLog>`
// that writes log entries directly to a file. Configures the built-in ``envoy.access_loggers.file``
// AccessLog.
// [#next-free-field: 6]
#FileAccessLog: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.file.v3.FileAccessLog"
	// A path to a local file to which to write the access log entries.
	path?: string
	// Access log :ref:`format string<config_access_log_format_strings>`.
	// Envoy supports :ref:`custom access log formats <config_access_log_format>` as well as a
	// :ref:`default format <config_access_log_default_format>`.
	// This field is deprecated.
	// Please use :ref:`log_format <envoy_v3_api_field_extensions.access_loggers.file.v3.FileAccessLog.log_format>`.
	//
	// Deprecated: Do not use.
	format?: string
	// Access log :ref:`format dictionary<config_access_log_format_dictionaries>`. All values
	// are rendered as strings.
	// This field is deprecated.
	// Please use :ref:`log_format <envoy_v3_api_field_extensions.access_loggers.file.v3.FileAccessLog.log_format>`.
	//
	// Deprecated: Do not use.
	json_format?: _struct.#Struct
	// Access log :ref:`format dictionary<config_access_log_format_dictionaries>`. Values are
	// rendered as strings, numbers, or boolean values as appropriate. Nested JSON objects may
	// be produced by some command operators (e.g.FILTER_STATE or DYNAMIC_METADATA). See the
	// documentation for a specific command operator for details.
	// This field is deprecated.
	// Please use :ref:`log_format <envoy_v3_api_field_extensions.access_loggers.file.v3.FileAccessLog.log_format>`.
	//
	// Deprecated: Do not use.
	typed_json_format?: _struct.#Struct
	// Configuration to form access log data and format.
	// If not specified, use :ref:`default format <config_access_log_default_format>`.
	log_format?: v3.#SubstitutionFormatString
}
