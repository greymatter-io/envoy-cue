package v3

import (
	v1 "envoyproxy.io/deps/proto/otlp/common/v1"
	v3 "envoyproxy.io/extensions/access_loggers/grpc/v3"
	v31 "envoyproxy.io/config/core/v3"
)

// Configuration for the built-in “envoy.access_loggers.open_telemetry“
// :ref:`AccessLog <envoy_v3_api_msg_config.accesslog.v3.AccessLog>`. This configuration will
// populate `opentelemetry.proto.collector.v1.logs.ExportLogsServiceRequest.resource_logs <https://github.com/open-telemetry/opentelemetry-proto/blob/main/opentelemetry/proto/collector/logs/v1/logs_service.proto>`_.
// In addition, the request start time is set in the dedicated field.
// [#extension: envoy.access_loggers.open_telemetry]
// [#next-free-field: 8]
#OpenTelemetryAccessLogConfig: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.open_telemetry.v3.OpenTelemetryAccessLogConfig"
	// [#comment:TODO(itamarkam): add 'filter_state_objects_to_log' to logs.]
	common_config?: v3.#CommonGrpcAccessLogConfig
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
}
