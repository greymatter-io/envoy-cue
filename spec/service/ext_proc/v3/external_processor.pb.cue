package v3

import (
	structpb "envoyproxy.io/envoy-cue/spec/deps/protobuf/types/known/structpb"
	v3 "envoyproxy.io/envoy-cue/spec/extensions/filters/http/ext_proc/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v32 "envoyproxy.io/envoy-cue/spec/type/v3"
)

// The status of the response.
#CommonResponse_ResponseStatus: "CONTINUE" | "CONTINUE_AND_REPLACE"

CommonResponse_ResponseStatus_CONTINUE:             "CONTINUE"
CommonResponse_ResponseStatus_CONTINUE_AND_REPLACE: "CONTINUE_AND_REPLACE"

// This message specifies the filter protocol configurations which will be sent to the ext_proc
// server in a :ref:`ProcessingRequest <envoy_v3_api_msg_service.ext_proc.v3.ProcessingRequest>`.
// If the server does not support these protocol configurations, it may choose to close the gRPC
// stream. If the server supports these protocol configurations, it should respond based on the
// API specifications.
#ProtocolConfiguration: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ProtocolConfiguration"
	// Specifies the filter configuration
	// :ref:`request_body_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ProcessingMode.request_body_mode>`.
	request_body_mode?: v3.#ProcessingMode_BodySendMode
	// Specifies the filter configuration
	// :ref:`response_body_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ProcessingMode.response_body_mode>`.
	response_body_mode?: v3.#ProcessingMode_BodySendMode
	// Specifies the filter configuration
	// :ref:`send_body_without_waiting_for_header_response <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.send_body_without_waiting_for_header_response>`.
	// If the client is waiting for a header response from the server, setting to “true“ means the
	// client will send the body to the server as it arrives. Setting to “false“ means the client
	// will buffer the arrived data and not send it to the server immediately.
	send_body_without_waiting_for_header_response?: bool
}

// This represents the different types of messages that the data plane can send
// to an external processing server.
// [#next-free-field: 12]
#ProcessingRequest: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ProcessingRequest"
	// Information about the HTTP request headers, as well as peer info and additional
	// properties. Unless “observability_mode“ is “true“, the server must send back a
	// “HeaderResponse“ message, an “ImmediateResponse“ message, or close the stream.
	request_headers?: #HttpHeaders
	// Information about the HTTP response headers, as well as peer info and additional
	// properties. Unless “observability_mode“ is “true“, the server must send back a
	// “HeaderResponse“ message or close the stream.
	response_headers?: #HttpHeaders
	// A chunk of the HTTP request body. Unless “observability_mode“ is “true“, the server must
	// send back a “BodyResponse“ message, an “ImmediateResponse“ message, or close the stream.
	request_body?: #HttpBody
	// A chunk of the HTTP response body. Unless “observability_mode“ is “true“, the server must
	// send back a “BodyResponse“ message or close the stream.
	response_body?: #HttpBody
	// The HTTP trailers for the request path. Unless “observability_mode“ is “true“, the server
	// must send back a “TrailerResponse“ message or close the stream.
	//
	// This message is only sent if the trailers processing mode is set to “SEND“ and
	// the original downstream request has trailers.
	request_trailers?: #HttpTrailers
	// The HTTP trailers for the response path. Unless “observability_mode“ is “true“, the server
	// must send back a “TrailerResponse“ message or close the stream.
	//
	// This message is only sent if the trailers processing mode is set to “SEND“ and
	// the original upstream response has trailers.
	response_trailers?: #HttpTrailers
	// Dynamic metadata associated with the request.
	metadata_context?: v31.#Metadata
	// The values of properties selected by the “request_attributes“
	// or “response_attributes“ list in the configuration. Each entry
	// in the list is populated from the standard
	// :ref:`attributes <arch_overview_attributes>` supported in the data plane.
	attributes?: [string]: structpb.#Struct
	// Specifies whether the filter that sent this request is running in
	// :ref:`observability_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.observability_mode>`.
	//
	//   - A value of “false“ indicates that the server must respond to this message by either
	//     sending back a matching “ProcessingResponse“ message, or by closing the stream.
	//   - A value of “true“ indicates that the server should not respond to this message, as any
	//     responses will be ignored. However, it may still close the stream to indicate that no more
	//     messages are needed.
	//
	// Defaults to “false“.
	observability_mode?: bool
	// Specify the filter protocol configurations to be sent to the server.
	// “protocol_config“ is only encoded in the first “ProcessingRequest“ message from the client to the server.
	protocol_config?: #ProtocolConfiguration
}

// This represents the different types of messages the server may send back to the data plane
// when the “observability_mode“ field in the received “ProcessingRequest“ is set to “false“.
//
//   - If the corresponding “BodySendMode“ in the
//     :ref:`processing_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
//     is not set to “FULL_DUPLEX_STREAMED“, then for every received “ProcessingRequest“,
//     the server must send back exactly one “ProcessingResponse“ message.
//   - If it is set to “FULL_DUPLEX_STREAMED“, the server must follow the API defined
//     for this mode to send the “ProcessingResponse“ messages.
//
// [#next-free-field: 13]
#ProcessingResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ProcessingResponse"
	// The server must send back this message in response to a message with the
	// “request_headers“ field set.
	request_headers?: #HeadersResponse
	// The server must send back this message in response to a message with the
	// “response_headers“ field set.
	response_headers?: #HeadersResponse
	// The server must send back this message in response to a message with
	// the “request_body“ field set.
	request_body?: #BodyResponse
	// The server must send back this message in response to a message with
	// the “response_body“ field set.
	response_body?: #BodyResponse
	// The server must send back this message in response to a message with
	// the “request_trailers“ field set.
	request_trailers?: #TrailersResponse
	// The server must send back this message in response to a message with
	// the “response_trailers“ field set.
	response_trailers?: #TrailersResponse
	// If specified, attempt to create a locally generated response, send it
	// downstream, and stop processing additional filters and ignore any
	// additional messages received from the remote server for this request or
	// response. If a response has already started -- for example, if this
	// message is sent response to a “response_body“ message -- then
	// this will either ship the reply directly to the downstream codec,
	// or reset the stream.
	immediate_response?: #ImmediateResponse
	// The server sends back this message to initiate or continue local response streaming.
	// The server must initiate local response streaming with the “headers_response“ in response
	// to a “ProcessingRequest“ with the “request_headers“ only.
	// The server may follow up with multiple messages containing “body_response“. The server must
	// indicate end of stream by setting “end_of_stream“ to “true“ in the “headers_response“
	// or “body_response“ message or by sending a “trailers_response“ message.
	// The client may send a “request_body“ or “request_trailers“ to the server depending on
	// configuration.
	// The streaming local response can only be sent when the “request_header_mode“ in the filter
	// :ref:`processing_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// is set to “SEND“. The ext_proc server should not send “StreamedImmediateResponse“ if it
	// did not observe request headers, as it will result in a race with the upstream server
	// response and reset of the client request.
	// Presently only the “FULL_DUPLEX_STREAMED“ or “NONE“ body modes are supported.
	streamed_immediate_response?: #StreamedImmediateResponse
	// Optional metadata that will be emitted as dynamic metadata to be consumed by
	// following filters. This metadata will be placed in the namespace(s) specified by the top-level
	// field name(s) of the struct.
	dynamic_metadata?: structpb.#Struct
	// Override how parts of the HTTP request and response are processed for the duration of this
	// particular request/response only. Servers may use this to intelligently control how requests
	// are processed based on the headers and other metadata that they see.
	//
	// This field is only applicable when servers are responding to the header requests. If it is set
	// in the response to the body or trailer requests, it will be ignored by the data plane.
	// It is also ignored by the data plane when the ext_proc filter config
	// :ref:`allow_mode_override <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.allow_mode_override>`
	// is set to “false“, or
	// :ref:`send_body_without_waiting_for_header_response <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.send_body_without_waiting_for_header_response>`
	// is set to “true“.
	mode_override?: v3.#ProcessingMode
	// [#not-implemented-hide:]
	// Used only in “FULL_DUPLEX_STREAMED“ and “GRPC“ body send modes.
	// Instructs the data plane to stop sending body data and to send a
	// half-close on the ext_proc stream. The ext_proc server should then echo
	// back all subsequent body contents as-is until it sees the client's
	// half-close, at which point the ext_proc server can terminate the stream
	// with an OK status. This provides a safe way for the ext_proc server
	// to indicate that it does not need to see the rest of the stream;
	// without this, the ext_proc server could not terminate the stream
	// early, because it would wind up dropping any body contents that the
	// client had already sent before it saw the ext_proc stream termination.
	request_drain?: bool
	// When the ext_proc server receives a request message and needs more time to process it, it
	// sends back a “ProcessingResponse“ message with a new timeout value. When the data plane
	// receives this response message, it ignores other fields in the response, stops the original
	// timer (which has the timeout value specified in
	// :ref:`message_timeout <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.message_timeout>`),
	// and starts a new timer with this “override_message_timeout“ value while keeping the data
	// plane ext_proc filter state machine intact.
	//
	// The value must be >= 1ms and <=
	// :ref:`max_message_timeout <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.max_message_timeout>`.
	// Such a message can be sent at most once in a particular data plane ext_proc filter processing
	// state. To enable this API, “max_message_timeout“ must be set to a value >= 1ms.
	override_message_timeout?: string
}

// This message is sent to the external server when the HTTP request and response headers
// are first received.
#HttpHeaders: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.HttpHeaders"
	// The HTTP request headers. All header keys will be lower-cased, because HTTP header keys are
	// case-insensitive. The header value is encoded in the
	// :ref:`raw_value <envoy_v3_api_field_config.core.v3.HeaderValue.raw_value>` field.
	headers?: v31.#HeaderMap
	// [#not-implemented-hide:]
	// This field is deprecated and not implemented. Attributes will be sent in the top-level
	// :ref:`attributes <envoy_v3_api_field_service.ext_proc.v3.ProcessingRequest.attributes>` field.
	//
	// Deprecated: Marked as deprecated in envoy/service/ext_proc/v3/external_processor.proto.
	attributes?: [string]: structpb.#Struct
	// If “true“, then there is no message body associated with this request or response.
	end_of_stream?: bool
}

// This message is sent to the external server when the HTTP request and response bodies are
// received.
#HttpBody: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.HttpBody"
	// The contents of the body in the HTTP request/response. Note that in streaming mode multiple
	// “HttpBody“ messages may be sent.
	//
	// In “GRPC“ body send mode, a separate “HttpBody“ message will be sent for each message in
	// the gRPC stream.
	body?: bytes
	// If “true“, this will be the last “HttpBody“ message that will be sent and no trailers
	// will be sent for the current request/response.
	end_of_stream?: bool
	// This field is used in “GRPC“ body send mode when “end_of_stream“ is “true“ and “body“
	// is empty. Those values would normally indicate an empty message on the stream with the
	// end-of-stream bit set. However, if the half-close happens after the last message on the stream
	// was already sent, then this field will be “true“ to indicate an end-of-stream with *no*
	// message (as opposed to an empty message).
	end_of_stream_without_message?: bool
	// This field is used in “GRPC“ body send mode to indicate whether the message is compressed.
	// This will never be set to “true“ by gRPC but may be set to “true“ by a proxy like Envoy.
	grpc_message_compressed?: bool
}

// This message is sent to the external server when the HTTP request and
// response trailers are received.
#HttpTrailers: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.HttpTrailers"
	// The header value is encoded in the
	// :ref:`raw_value <envoy_v3_api_field_config.core.v3.HeaderValue.raw_value>` field.
	trailers?: v31.#HeaderMap
}

// This message is sent by the external server to the data plane after “HttpHeaders“ was
// sent to it.
#HeadersResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.HeadersResponse"
	// Details the modifications (if any) to be made by the data plane to the current
	// request/response.
	response?: #CommonResponse
}

// This message is sent by the external server to the data plane after “HttpBody“ was
// sent to it.
#BodyResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.BodyResponse"
	// Details the modifications (if any) to be made by the data plane to the current
	// request/response.
	response?: #CommonResponse
}

// This message is sent by the external server to the data plane after “HttpTrailers“ was
// sent to it.
#TrailersResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.TrailersResponse"
	// Details the modifications (if any) to be made by the data plane to the current
	// request/response trailers.
	header_mutation?: #HeaderMutation
}

// This message is sent by the external server to the data plane after “HttpHeaders“ to initiate
// local response streaming. The server may follow up with multiple messages containing
// “body_response“. The server must indicate end of stream by setting “end_of_stream“ to
// “true“ in the “headers_response“ or “body_response“ message or by sending a
// “trailers_response“ message.
#StreamedImmediateResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.StreamedImmediateResponse"
	// Response headers to be sent downstream. The “:status“ header must be set.
	headers_response?: #HttpHeaders
	// Response body to be sent downstream.
	body_response?: #StreamedBodyResponse
	// Response trailers to be sent downstream.
	trailers_response?: v31.#HeaderMap
}

// This message contains common fields between header and body responses.
// [#next-free-field: 6]
#CommonResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.CommonResponse"
	// If set, provide additional direction on how the data plane should
	// handle the rest of the HTTP filter chain.
	status?: #CommonResponse_ResponseStatus
	// Instructions on how to manipulate the headers. When responding to an
	// “HttpBody“ request, header mutations will only take effect if the current processing mode
	// for the body is “BUFFERED“.
	header_mutation?: #HeaderMutation
	// Replace the body of the last message sent to the remote server on this stream. If responding
	// to an “HttpBody“ request, simply replace or clear the body chunk that was sent with that
	// request. Body mutations may take effect in response either to “header“ or “body“ messages.
	// When it is in response to “header“ messages, it only takes effect if the
	// :ref:`status <envoy_v3_api_field_service.ext_proc.v3.CommonResponse.status>`
	// is set to “CONTINUE_AND_REPLACE“.
	body_mutation?: #BodyMutation
	// [#not-implemented-hide:]
	// Add new trailers to the message. This may be used when responding to either an
	// “HttpHeaders“ or “HttpBody“ message, but only if this message is returned
	// along with the “CONTINUE_AND_REPLACE“ status.
	// The header value is encoded in the
	// :ref:`raw_value <envoy_v3_api_field_config.core.v3.HeaderValue.raw_value>` field.
	trailers?: v31.#HeaderMap
	// Clear the route cache for the current client request. This is necessary
	// if the remote server modified headers that are used to calculate the route.
	// This field is ignored in the response direction. This field is also ignored
	// if the data plane ext_proc filter is in the upstream filter chain.
	clear_route_cache?: bool
}

// This message causes the filter to attempt to create a locally generated response, send it
// downstream, stop processing additional filters, and ignore any additional messages received
// from the remote server for this request or response. If a response has already started, then
// this will either ship the reply directly to the downstream codec, or reset the stream.
// [#next-free-field: 6]
#ImmediateResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ImmediateResponse"
	// The response code to return.
	status?: v32.#HttpStatus
	// Apply changes to the default headers, which will include “content-type“.
	headers?: #HeaderMutation
	// The message body to return with the response which is sent using the
	// “text/plain“ content type, or encoded in the “grpc-message“ header.
	body?: bytes
	// If set, then include a gRPC status trailer.
	grpc_status?: #GrpcStatus
	// A string detailing why this local reply was sent, which may be included
	// in log and debug output (e.g., this populates the “%RESPONSE_CODE_DETAILS%“
	// command operator field for use in access logging).
	details?: string
}

// This message specifies a gRPC status for an “ImmediateResponse“ message.
#GrpcStatus: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.GrpcStatus"
	// The actual gRPC status.
	status?: uint32
}

// Change HTTP headers or trailers by appending, replacing, or removing
// headers.
#HeaderMutation: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.HeaderMutation"
	// Add or replace HTTP headers. Attempts to set the value of
	// any “x-envoy“ header, and attempts to set the “:method“,
	// “:authority“, “:scheme“, or “host“ headers will be ignored.
	// The header value is encoded in the
	// :ref:`raw_value <envoy_v3_api_field_config.core.v3.HeaderValue.raw_value>` field.
	set_headers?: [...v31.#HeaderValueOption]
	// Remove these HTTP headers. Attempts to remove system headers --
	// any header starting with “:“, plus “host“ -- will be ignored.
	remove_headers?: [...string]
}

// The body response message corresponding to “FULL_DUPLEX_STREAMED“ or “GRPC“ body modes.
#StreamedBodyResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.StreamedBodyResponse"
	// In “FULL_DUPLEX_STREAMED“ body send mode, contains the body response chunk that will be
	// passed to the upstream/downstream by the data plane. In “GRPC“ body send mode, contains
	// a serialized gRPC message to be passed to the upstream/downstream by the data plane.
	body?: bytes
	// The server sets this flag to “true“ if it has received a body request with
	// :ref:`end_of_stream <envoy_v3_api_field_service.ext_proc.v3.HttpBody.end_of_stream>` set to
	// “true“, and this is the last chunk of body responses.
	//
	// Note that in “GRPC“ body send mode, this allows the ext_proc server to tell the data plane
	// to send a half close after a client message, which will result in discarding any other
	// messages sent by the client application.
	end_of_stream?: bool
	// This field is used in “GRPC“ body send mode when “end_of_stream“ is “true“ and “body“
	// is empty. Those values would normally indicate an empty message on the stream with the
	// end-of-stream bit set. However, if the half-close happens after the last message on the stream
	// was already sent, then this field will be “true“ to indicate an end-of-stream with *no*
	// message (as opposed to an empty message).
	end_of_stream_without_message?: bool
	// This field is used in “GRPC“ body send mode to indicate whether the message is compressed.
	// This will never be set to “true“ by gRPC but may be set to “true“ by a proxy like Envoy.
	grpc_message_compressed?: bool
}

// This message specifies the body mutation the server sends to the data plane.
#BodyMutation: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.BodyMutation"
	// The entire body to replace.
	// Should only be used when the corresponding “BodySendMode“ in the
	// :ref:`processing_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// is not set to “FULL_DUPLEX_STREAMED“ or “GRPC“.
	body?: bytes
	// Clear the corresponding body chunk. Should only be used when the corresponding
	// “BodySendMode“ in the
	// :ref:`processing_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// is not set to “FULL_DUPLEX_STREAMED“ or “GRPC“.
	clear_body?: bool
	// Must be used when the corresponding “BodySendMode“ in the
	// :ref:`processing_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// is set to “FULL_DUPLEX_STREAMED“ or “GRPC“.
	streamed_response?: #StreamedBodyResponse
}
