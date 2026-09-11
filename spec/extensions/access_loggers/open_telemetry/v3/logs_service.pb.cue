package v3

import (
	v1 "envoyproxy.io/envoy-cue/spec/deps/proto/otlp/common/v1"
	v3 "envoyproxy.io/envoy-cue/spec/extensions/access_loggers/grpc/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v32 "envoyproxy.io/envoy-cue/spec/type/tracing/v3"
)

// Configuration for the built-in “envoy.access_loggers.open_telemetry“
// :ref:`AccessLog <envoy_v3_api_msg_config.accesslog.v3.AccessLog>`. This configuration will
// populate `opentelemetry.proto.collector.v1.logs.ExportLogsServiceRequest.resource_logs <https://github.com/open-telemetry/opentelemetry-proto/blob/main/opentelemetry/proto/collector/logs/v1/logs_service.proto>`_.
// In addition, the request start time is set in the dedicated field.
// [#extension: envoy.access_loggers.open_telemetry]
// [#next-free-field: 15]
#OpenTelemetryAccessLogConfig: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.open_telemetry.v3.OpenTelemetryAccessLogConfig"
	// [#comment:TODO(itamarkam): add 'filter_state_objects_to_log' to logs.]
	// Deprecated. Use “grpc_service“ or “http_service“ instead.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/access_loggers/open_telemetry/v3/logs_service.proto.
	common_config?: v3.#CommonGrpcAccessLogConfig
	// The upstream HTTP cluster that will receive OTLP logs via
	// `OTLP/HTTP <https://opentelemetry.io/docs/specs/otlp/#otlphttp>`_.
	// Note: Only one of “common_config“, “grpc_service“, or “http_service“ may be used.
	//
	// .. note::
	//
	//	The ``request_headers_to_add`` property in the OTLP HTTP exporter service supports
	//	substitution formatters. The formatters cannot access any HTTP or connection properties, but
	//	can load content such as environment variables or files or secrets.
	http_service?: v31.#HttpService
	// The upstream gRPC cluster that will receive OTLP logs.
	// Note: Only one of “common_config“, “grpc_service“, or “http_service“ may be used.
	// This field is preferred over “common_config.grpc_service“.
	grpc_service?: v31.#GrpcService
	// If specified, Envoy will not generate built-in resource labels
	// like “log_name“, “zone_name“, “cluster_name“, “node_name“.
	disable_builtin_labels?: bool
	// OpenTelemetry `Resource <https://github.com/open-telemetry/opentelemetry-proto/blob/main/opentelemetry/proto/logs/v1/logs.proto#L51>`_
	// attributes are filled with Envoy node info.
	// Example: “resource_attributes { values { key: "region" value { string_value: "cn-north-7" } } }“.
	resource_attributes?: v1.#KeyValueList
	// OpenTelemetry `LogResource <https://github.com/open-telemetry/opentelemetry-proto/blob/main/opentelemetry/proto/logs/v1/logs.proto>`_
	// fields, following `Envoy access logging formatting <https://www.envoyproxy.io/docs/envoy/latest/configuration/observability/access_log/usage>`_.
	//
	// See 'body' in the LogResource proto for more details.
	// Example: “body { string_value: "%PROTOCOL%" }“.
	body?: v1.#AnyValue
	// See 'attributes' in the LogResource proto for more details.
	// Example: “attributes { values { key: "user_agent" value { string_value: "%REQ(USER-AGENT)%" } } }“.
	attributes?: v1.#KeyValueList
	// Optional. Additional prefix to use on OpenTelemetry access logger stats. If empty, the stats will be rooted at
	// “access_logs.open_telemetry_access_log.“. If non-empty, stats will be rooted at
	// “access_logs.open_telemetry_access_log.<stat_prefix>.“.
	stat_prefix?: string
	// Specifies a collection of Formatter plugins that can be called from the access log configuration.
	// See the formatters extensions documentation for details.
	// [#extension-category: envoy.formatter]
	formatters?: [...v31.#TypedExtensionConfig]
	log_name?: string
	// The interval for flushing access logs to the transport. Default: 1 second.
	buffer_flush_interval?: string
	// Soft size limit in bytes for the access log buffer. When the buffer exceeds
	// this limit, logs will be flushed. Default: 16KB.
	buffer_size_bytes?: uint32
	// Additional filter state objects to log as attributes.
	filter_state_objects_to_log?: [...string]
	// Custom tags to include as log attributes.
	custom_tags?: [...v32.#CustomTag]
}
