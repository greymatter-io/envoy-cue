package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
	v3 "envoyproxy.io/config/core/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// Configuration for the *envoy.access_loggers.fluentd* :ref:`AccessLog <envoy_v3_api_msg_config.accesslog.v3.AccessLog>`.
// This access log extension will send the emitted access logs over a TCP connection to an upstream that is accepting
// the Fluentd Forward Protocol as described in: `Fluentd Forward Protocol Specification
// <https://github.com/fluent/fluentd/wiki/Forward-Protocol-Specification-v1>`_.
// [#extension: envoy.access_loggers.fluentd]
// [#next-free-field: 9]
#FluentdAccessLogConfig: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.fluentd.v3.FluentdAccessLogConfig"
	// The upstream cluster to connect to for streaming the Fluentd messages.
	cluster?: string
	// A tag is a string separated with '.' (e.g. log.type) to categorize events.
	// See: https://github.com/fluent/fluentd/wiki/Forward-Protocol-Specification-v1#message-modes
	tag?: string
	// The prefix to use when emitting :ref:`statistics <config_access_log_stats>`.
	stat_prefix?: string
	// Interval for flushing access logs to the TCP stream. Logger will flush requests every time
	// this interval is elapsed, or when batch size limit is hit, whichever comes first. Defaults to
	// 1 second.
	buffer_flush_interval?: durationpb.#Duration
	// Soft size limit in bytes for access log entries buffer. The logger will buffer requests until
	// this limit it hit, or every time flush interval is elapsed, whichever comes first. When the buffer
	// limit is hit, the logger will immediately flush the buffer contents. Setting it to zero effectively
	// disables the batching. Defaults to 16384.
	buffer_size_bytes?: wrapperspb.#UInt32Value
	// A struct that represents the record that is sent for each log entry.
	// https://github.com/fluent/fluentd/wiki/Forward-Protocol-Specification-v1#entry
	// Values are rendered as strings, numbers, or boolean values as appropriate.
	// Nested JSON objects may be produced by some command operators (e.g. FILTER_STATE or DYNAMIC_METADATA).
	// See :ref:`format string<config_access_log_format_strings>` documentation for a specific command operator details.
	//
	// .. validated-code-block:: yaml
	//
	//	:type-name: envoy.extensions.access_loggers.fluentd.v3.FluentdAccessLogConfig
	//
	//	record:
	//	  status: "%RESPONSE_CODE%"
	//	  message: "%LOCAL_REPLY_BODY%"
	//
	// The following msgpack record would be created:
	//
	// .. code-block:: json
	//
	//	{
	//	  "status": 500,
	//	  "message": "My error message"
	//	}
	record?: structpb.#Struct
	// Optional retry, in case upstream connection has failed. If this field is not set, the default values will be applied,
	// as specified in the :ref:`RetryOptions <envoy_v3_api_msg_extensions.access_loggers.fluentd.v3.FluentdAccessLogConfig.RetryOptions>`
	// configuration.
	retry_options?: #FluentdAccessLogConfig_RetryOptions
	// Specifies a collection of Formatter plugins that can be called from the access log configuration.
	// See the formatters extensions documentation for details.
	// [#extension-category: envoy.formatter]
	formatters?: [...v3.#TypedExtensionConfig]
}

#FluentdAccessLogConfig_RetryOptions: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.fluentd.v3.FluentdAccessLogConfig_RetryOptions"
	// The number of times the logger will attempt to connect to the upstream during reconnects.
	// By default, there is no limit. The logger will attempt to reconnect to the upstream each time
	// connecting to the upstream failed or the upstream connection had been closed for any reason.
	max_connect_attempts?: wrapperspb.#UInt32Value
	// Sets the backoff strategy. If this value is not set, the default base backoff interval is 500
	// milliseconds and the default max backoff interval is 5 seconds (10 times the base interval).
	backoff_options?: v3.#BackoffStrategy
}
