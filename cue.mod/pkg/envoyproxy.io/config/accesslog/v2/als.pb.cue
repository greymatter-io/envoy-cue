package v2

import (
	core "envoyproxy.io/api/v2/core"
)

// Configuration for the built-in *envoy.access_loggers.http_grpc*
// :ref:`AccessLog <envoy_api_msg_config.filter.accesslog.v2.AccessLog>`. This configuration will
// populate :ref:`StreamAccessLogsMessage.http_logs
// <envoy_api_field_service.accesslog.v2.StreamAccessLogsMessage.http_logs>`.
// [#extension: envoy.access_loggers.http_grpc]
#HttpGrpcAccessLogConfig: {
	"@type":        "type.googleapis.com/envoy.config.accesslog.v2.HttpGrpcAccessLogConfig"
	common_config?: #CommonGrpcAccessLogConfig
	// Additional request headers to log in :ref:`HTTPRequestProperties.request_headers
	// <envoy_api_field_data.accesslog.v2.HTTPRequestProperties.request_headers>`.
	additional_request_headers_to_log?: [...string]
	// Additional response headers to log in :ref:`HTTPResponseProperties.response_headers
	// <envoy_api_field_data.accesslog.v2.HTTPResponseProperties.response_headers>`.
	additional_response_headers_to_log?: [...string]
	// Additional response trailers to log in :ref:`HTTPResponseProperties.response_trailers
	// <envoy_api_field_data.accesslog.v2.HTTPResponseProperties.response_trailers>`.
	additional_response_trailers_to_log?: [...string]
}

// Configuration for the built-in *envoy.access_loggers.tcp_grpc* type. This configuration will
// populate *StreamAccessLogsMessage.tcp_logs*.
// [#extension: envoy.access_loggers.tcp_grpc]
#TcpGrpcAccessLogConfig: {
	"@type":        "type.googleapis.com/envoy.config.accesslog.v2.TcpGrpcAccessLogConfig"
	common_config?: #CommonGrpcAccessLogConfig
}

// Common configuration for gRPC access logs.
// [#next-free-field: 6]
#CommonGrpcAccessLogConfig: {
	"@type": "type.googleapis.com/envoy.config.accesslog.v2.CommonGrpcAccessLogConfig"
	// The friendly name of the access log to be returned in :ref:`StreamAccessLogsMessage.Identifier
	// <envoy_api_msg_service.accesslog.v2.StreamAccessLogsMessage.Identifier>`. This allows the
	// access log server to differentiate between different access logs coming from the same Envoy.
	log_name?: string
	// The gRPC service for the access log service.
	grpc_service?: core.#GrpcService
	// Interval for flushing access logs to the gRPC stream. Logger will flush requests every time
	// this interval is elapsed, or when batch size limit is hit, whichever comes first. Defaults to
	// 1 second.
	buffer_flush_interval?: string
	// Soft size limit in bytes for access log entries buffer. Logger will buffer requests until
	// this limit it hit, or every time flush interval is elapsed, whichever comes first. Setting it
	// to zero effectively disables the batching. Defaults to 16384.
	buffer_size_bytes?: uint32
	// Additional filter state objects to log in :ref:`filter_state_objects
	// <envoy_api_field_data.accesslog.v2.AccessLogCommon.filter_state_objects>`.
	// Logger will call `FilterState::Object::serializeAsProto` to serialize the filter state object.
	filter_state_objects_to_log?: [...string]
}
