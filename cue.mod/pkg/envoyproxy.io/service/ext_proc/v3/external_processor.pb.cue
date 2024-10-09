package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
	v3 "envoyproxy.io/config/core/v3"
	v31 "envoyproxy.io/extensions/filters/http/ext_proc/v3"
	v32 "envoyproxy.io/type/v3"
)

#CommonResponse_ResponseStatus: "CONTINUE" | "CONTINUE_AND_REPLACE"

CommonResponse_ResponseStatus_CONTINUE:             "CONTINUE"
CommonResponse_ResponseStatus_CONTINUE_AND_REPLACE: "CONTINUE_AND_REPLACE"

// This represents the different types of messages that Envoy can send
// to an external processing server.
// [#next-free-field: 11]
#ProcessingRequest: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ProcessingRequest"
	// Information about the HTTP request headers, as well as peer info and additional
	// properties. Unless “observability_mode“ is “true“, the server must send back a
	// HeaderResponse message, an ImmediateResponse message, or close the stream.
	request_headers?: #HttpHeaders
	// Information about the HTTP response headers, as well as peer info and additional
	// properties. Unless “observability_mode“ is “true“, the server must send back a
	// HeaderResponse message or close the stream.
	response_headers?: #HttpHeaders
	// A chunk of the HTTP request body. Unless “observability_mode“ is true, the server must send back
	// a BodyResponse message, an ImmediateResponse message, or close the stream.
	request_body?: #HttpBody
	// A chunk of the HTTP response body. Unless “observability_mode“ is “true“, the server must send back
	// a BodyResponse message or close the stream.
	response_body?: #HttpBody
	// The HTTP trailers for the request path. Unless “observability_mode“ is “true“, the server
	// must send back a TrailerResponse message or close the stream.
	//
	// This message is only sent if the trailers processing mode is set to “SEND“ and
	// the original downstream request has trailers.
	request_trailers?: #HttpTrailers
	// The HTTP trailers for the response path. Unless “observability_mode“ is “true“, the server
	// must send back a TrailerResponse message or close the stream.
	//
	// This message is only sent if the trailers processing mode is set to “SEND“ and
	// the original upstream response has trailers.
	response_trailers?: #HttpTrailers
	// Dynamic metadata associated with the request.
	metadata_context?: v3.#Metadata
	// The values of properties selected by the “request_attributes“
	// or “response_attributes“ list in the configuration. Each entry
	// in the list is populated from the standard
	// :ref:`attributes <arch_overview_attributes>` supported across Envoy.
	attributes?: [string]: structpb.#Struct
	// Specify whether the filter that sent this request is running in :ref:`observability_mode
	// <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.observability_mode>`
	// and defaults to false.
	//
	//   - A value of “false“ indicates that the server must respond
	//     to this message by either sending back a matching ProcessingResponse message,
	//     or by closing the stream.
	//   - A value of “true“ indicates that the server should not respond to this message, as any
	//     responses will be ignored. However, it may still close the stream to indicate that no more messages
	//     are needed.
	observability_mode?: bool
}

// For every ProcessingRequest received by the server with the “observability_mode“ field
// set to false, the server must send back exactly one ProcessingResponse message.
// [#next-free-field: 11]
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
	// Optional metadata that will be emitted as dynamic metadata to be consumed by
	// following filters. This metadata will be placed in the namespace(s) specified by the top-level
	// field name(s) of the struct.
	dynamic_metadata?: structpb.#Struct
	// Override how parts of the HTTP request and response are processed
	// for the duration of this particular request/response only. Servers
	// may use this to intelligently control how requests are processed
	// based on the headers and other metadata that they see.
	// This field is only applicable when servers responding to the header requests.
	// If it is set in the response to the body or trailer requests, it will be ignored by Envoy.
	// It is also ignored by Envoy when the ext_proc filter config
	// :ref:`allow_mode_override
	// <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.allow_mode_override>`
	// is set to false, or
	// :ref:`send_body_without_waiting_for_header_response
	// <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.send_body_without_waiting_for_header_response>`
	// is set to true.
	mode_override?: v31.#ProcessingMode
	// When ext_proc server receives a request message, in case it needs more
	// time to process the message, it sends back a ProcessingResponse message
	// with a new timeout value. When Envoy receives this response message,
	// it ignores other fields in the response, just stop the original timer,
	// which has the timeout value specified in
	// :ref:`message_timeout
	// <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.message_timeout>`
	// and start a new timer with this “override_message_timeout“ value and keep the
	// Envoy ext_proc filter state machine intact.
	// Has to be >= 1ms and <=
	// :ref:`max_message_timeout <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.max_message_timeout>`
	// Such message can be sent at most once in a particular Envoy ext_proc filter processing state.
	// To enable this API, one has to set “max_message_timeout“ to a number >= 1ms.
	override_message_timeout?: durationpb.#Duration
}

// This message is sent to the external server when the HTTP request and responses
// are first received.
#HttpHeaders: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.HttpHeaders"
	// The HTTP request headers. All header keys will be
	// lower-cased, because HTTP header keys are case-insensitive.
	// The header value is encoded in the
	// :ref:`raw_value <envoy_v3_api_field_config.core.v3.HeaderValue.raw_value>` field.
	headers?: v3.#HeaderMap
	// [#not-implemented-hide:]
	// This field is deprecated and not implemented. Attributes will be sent in
	// the  top-level :ref:`attributes <envoy_v3_api_field_service.ext_proc.v3.ProcessingRequest.attributes`
	// field.
	//
	// Deprecated: Marked as deprecated in envoy/service/ext_proc/v3/external_processor.proto.
	attributes?: [string]: structpb.#Struct
	// If true, then there is no message body associated with this
	// request or response.
	end_of_stream?: bool
}

// This message contains the message body that Envoy sends to the external server.
#HttpBody: {
	"@type":        "type.googleapis.com/envoy.service.ext_proc.v3.HttpBody"
	body?:          bytes
	end_of_stream?: bool
}

// This message contains the trailers.
#HttpTrailers: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.HttpTrailers"
	// The header value is encoded in the
	// :ref:`raw_value <envoy_v3_api_field_config.core.v3.HeaderValue.raw_value>` field.
	trailers?: v3.#HeaderMap
}

// This message must be sent in response to an HttpHeaders message.
#HeadersResponse: {
	"@type":   "type.googleapis.com/envoy.service.ext_proc.v3.HeadersResponse"
	response?: #CommonResponse
}

// This message must be sent in response to an HttpTrailers message.
#TrailersResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.TrailersResponse"
	// Instructions on how to manipulate the trailers
	header_mutation?: #HeaderMutation
}

// This message must be sent in response to an HttpBody message.
#BodyResponse: {
	"@type":   "type.googleapis.com/envoy.service.ext_proc.v3.BodyResponse"
	response?: #CommonResponse
}

// This message contains common fields between header and body responses.
// [#next-free-field: 6]
#CommonResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.CommonResponse"
	// If set, provide additional direction on how the Envoy proxy should
	// handle the rest of the HTTP filter chain.
	status?: #CommonResponse_ResponseStatus
	// Instructions on how to manipulate the headers. When responding to an
	// HttpBody request, header mutations will only take effect if
	// the current processing mode for the body is BUFFERED.
	header_mutation?: #HeaderMutation
	// Replace the body of the last message sent to the remote server on this
	// stream. If responding to an HttpBody request, simply replace or clear
	// the body chunk that was sent with that request. Body mutations may take
	// effect in response either to “header“ or “body“ messages. When it is
	// in response to “header“ messages, it only take effect if the
	// :ref:`status <envoy_v3_api_field_service.ext_proc.v3.CommonResponse.status>`
	// is set to CONTINUE_AND_REPLACE.
	body_mutation?: #BodyMutation
	// [#not-implemented-hide:]
	// Add new trailers to the message. This may be used when responding to either a
	// HttpHeaders or HttpBody message, but only if this message is returned
	// along with the CONTINUE_AND_REPLACE status.
	// The header value is encoded in the
	// :ref:`raw_value <envoy_v3_api_field_config.core.v3.HeaderValue.raw_value>` field.
	trailers?: v3.#HeaderMap
	// Clear the route cache for the current client request. This is necessary
	// if the remote server modified headers that are used to calculate the route.
	// This field is ignored in the response direction. This field is also ignored
	// if the Envoy ext_proc filter is in the upstream filter chain.
	clear_route_cache?: bool
}

// This message causes the filter to attempt to create a locally
// generated response, send it  downstream, stop processing
// additional filters, and ignore any additional messages received
// from the remote server for this request or response. If a response
// has already started, then  this will either ship the reply directly
// to the downstream codec, or reset the stream.
// [#next-free-field: 6]
#ImmediateResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ImmediateResponse"
	// The response code to return
	status?: v32.#HttpStatus
	// Apply changes to the default headers, which will include content-type.
	headers?: #HeaderMutation
	// The message body to return with the response which is sent using the
	// text/plain content type, or encoded in the grpc-message header.
	body?: bytes
	// If set, then include a gRPC status trailer.
	grpc_status?: #GrpcStatus
	// A string detailing why this local reply was sent, which may be included
	// in log and debug output (e.g. this populates the %RESPONSE_CODE_DETAILS%
	// command operator field for use in access logging).
	details?: string
}

// This message specifies a gRPC status for an ImmediateResponse message.
#GrpcStatus: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.GrpcStatus"
	// The actual gRPC status
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
	set_headers?: [...v3.#HeaderValueOption]
	// Remove these HTTP headers. Attempts to remove system headers --
	// any header starting with “:“, plus “host“ -- will be ignored.
	remove_headers?: [...string]
}

// Replace the entire message body chunk received in the corresponding
// HttpBody message with this new body, or clear the body.
#BodyMutation: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.BodyMutation"
	// The entire body to replace
	body?: bytes
	// Clear the corresponding body chunk
	clear_body?: bool
}
