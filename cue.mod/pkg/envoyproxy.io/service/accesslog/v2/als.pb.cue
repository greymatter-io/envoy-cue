package v2

import (
	core "envoyproxy.io/api/v2/core"
	v2 "envoyproxy.io/data/accesslog/v2"
)

// Empty response for the StreamAccessLogs API. Will never be sent. See below.
#StreamAccessLogsResponse: {
	"@type": "type.googleapis.com/envoy.service.accesslog.v2.StreamAccessLogsResponse"
}

// Stream message for the StreamAccessLogs API. Envoy will open a stream to the server and stream
// access logs without ever expecting a response.
#StreamAccessLogsMessage: {
	"@type": "type.googleapis.com/envoy.service.accesslog.v2.StreamAccessLogsMessage"
	// Identifier data that will only be sent in the first message on the stream. This is effectively
	// structured metadata and is a performance optimization.
	identifier?: #StreamAccessLogsMessage_Identifier
	http_logs?:  #StreamAccessLogsMessage_HTTPAccessLogEntries
	tcp_logs?:   #StreamAccessLogsMessage_TCPAccessLogEntries
}

#StreamAccessLogsMessage_Identifier: {
	"@type": "type.googleapis.com/envoy.service.accesslog.v2.StreamAccessLogsMessage_Identifier"
	// The node sending the access log messages over the stream.
	node?: core.#Node
	// The friendly name of the log configured in :ref:`CommonGrpcAccessLogConfig
	// <envoy_api_msg_config.accesslog.v2.CommonGrpcAccessLogConfig>`.
	log_name?: string
}

// Wrapper for batches of HTTP access log entries.
#StreamAccessLogsMessage_HTTPAccessLogEntries: {
	"@type": "type.googleapis.com/envoy.service.accesslog.v2.StreamAccessLogsMessage_HTTPAccessLogEntries"
	log_entry?: [...v2.#HTTPAccessLogEntry]
}

// Wrapper for batches of TCP access log entries.
#StreamAccessLogsMessage_TCPAccessLogEntries: {
	"@type": "type.googleapis.com/envoy.service.accesslog.v2.StreamAccessLogsMessage_TCPAccessLogEntries"
	log_entry?: [...v2.#TCPAccessLogEntry]
}

// AccessLogServiceClient is the client API for AccessLogService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#AccessLogServiceClient: _

#AccessLogService_StreamAccessLogsClient: _

// AccessLogServiceServer is the server API for AccessLogService service.
#AccessLogServiceServer: _

// UnimplementedAccessLogServiceServer can be embedded to have forward compatible implementations.
#UnimplementedAccessLogServiceServer: {
	"@type": "type.googleapis.com/envoy.service.accesslog.v2.UnimplementedAccessLogServiceServer"
}

#AccessLogService_StreamAccessLogsServer: _
