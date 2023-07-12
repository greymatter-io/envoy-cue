package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/tracing/v3"
)

// Configuration for the built-in ``envoy.access_loggers.http_grpc``
// :ref:`AccessLog <envoy_v3_api_msg_config.accesslog.v3.AccessLog>`. This configuration will
// populate :ref:`StreamAccessLogsMessage.http_logs
// <envoy_v3_api_field_service.accesslog.v3.StreamAccessLogsMessage.http_logs>`.
// [#extension: envoy.access_loggers.http_grpc]
#HttpGrpcAccessLogConfig: {
	"@type":        "type.googleapis.com/envoy.extensions.access_loggers.grpc.v3.HttpGrpcAccessLogConfig"
	common_config?: #CommonGrpcAccessLogConfig
	// Additional request headers to log in :ref:`HTTPRequestProperties.request_headers
	// <envoy_v3_api_field_data.accesslog.v3.HTTPRequestProperties.request_headers>`.
	additional_request_headers_to_log?: [...string]
	// Additional response headers to log in :ref:`HTTPResponseProperties.response_headers
	// <envoy_v3_api_field_data.accesslog.v3.HTTPResponseProperties.response_headers>`.
	additional_response_headers_to_log?: [...string]
	// Additional response trailers to log in :ref:`HTTPResponseProperties.response_trailers
	// <envoy_v3_api_field_data.accesslog.v3.HTTPResponseProperties.response_trailers>`.
	additional_response_trailers_to_log?: [...string]
}

// Configuration for the built-in ``envoy.access_loggers.tcp_grpc`` type. This configuration will
// populate ``StreamAccessLogsMessage.tcp_logs``.
// [#extension: envoy.access_loggers.tcp_grpc]
#TcpGrpcAccessLogConfig: {
	"@type":        "type.googleapis.com/envoy.extensions.access_loggers.grpc.v3.TcpGrpcAccessLogConfig"
	common_config?: #CommonGrpcAccessLogConfig
}

// Common configuration for gRPC access logs.
// [#next-free-field: 9]
#CommonGrpcAccessLogConfig: {
	"@type": "type.googleapis.com/envoy.extensions.access_loggers.grpc.v3.CommonGrpcAccessLogConfig"
	// The friendly name of the access log to be returned in :ref:`StreamAccessLogsMessage.Identifier
	// <envoy_v3_api_msg_service.accesslog.v3.StreamAccessLogsMessage.Identifier>`. This allows the
	// access log server to differentiate between different access logs coming from the same Envoy.
	log_name?: string
	// The gRPC service for the access log service.
	grpc_service?: v3.#GrpcService
	// API version for access logs service transport protocol. This describes the access logs service
	// gRPC endpoint and version of messages used on the wire.
	transport_api_version?: v3.#ApiVersion
	// Interval for flushing access logs to the gRPC stream. Logger will flush requests every time
	// this interval is elapsed, or when batch size limit is hit, whichever comes first. Defaults to
	// 1 second.
	buffer_flush_interval?: string
	// Soft size limit in bytes for access log entries buffer. Logger will buffer requests until
	// this limit it hit, or every time flush interval is elapsed, whichever comes first. Setting it
	// to zero effectively disables the batching. Defaults to 16384.
	buffer_size_bytes?: uint32
	// Additional filter state objects to log in :ref:`filter_state_objects
	// <envoy_v3_api_field_data.accesslog.v3.AccessLogCommon.filter_state_objects>`.
	// Logger will call ``FilterState::Object::serializeAsProto`` to serialize the filter state object.
	filter_state_objects_to_log?: [...string]
	// Sets the retry policy when the establishment of a gRPC stream fails.
	// If the stream succeeds at least once in establishing itself,
	// no retry will be performed no matter what gRPC status is received.
	// Note that only :ref:`num_retries <envoy_v3_api_field_config.core.v3.RetryPolicy.num_retries>`
	// will be used in this configuration. This feature is used only when you are using
	// :ref:`Envoy gRPC client <envoy_v3_api_field_config.core.v3.GrpcService.envoy_grpc>`.
	grpc_stream_retry_policy?: v3.#RetryPolicy
	// A list of custom tags with unique tag name to create tags for the logs.
	custom_tags?: [...v31.#CustomTag]
}
