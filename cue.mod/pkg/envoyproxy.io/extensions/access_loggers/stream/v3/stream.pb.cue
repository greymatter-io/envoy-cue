package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Custom configuration for an :ref:`AccessLog <envoy_v3_api_msg_config.accesslog.v3.AccessLog>`
// that writes log entries directly to the operating system's standard output.
// [#extension: envoy.access_loggers.stdout]
#StdoutAccessLog: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.stream.v3.StdoutAccessLog"
	// Configuration to form access log data and format.
	// If not specified, use :ref:`default format <config_access_log_default_format>`.
	log_format?: v3.#SubstitutionFormatString
}

// Custom configuration for an :ref:`AccessLog <envoy_v3_api_msg_config.accesslog.v3.AccessLog>`
// that writes log entries directly to the operating system's standard error.
// [#extension: envoy.access_loggers.stderr]
#StderrAccessLog: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.stream.v3.StderrAccessLog"
	// Configuration to form access log data and format.
	// If not specified, use :ref:`default format <config_access_log_default_format>`.
	log_format?: v3.#SubstitutionFormatString
}
