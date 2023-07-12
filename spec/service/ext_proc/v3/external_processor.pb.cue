package v3

import (
	_struct "envoyproxy.io/envoy-cue/spec/deps/golang/protobuf/ptypes/struct"
	v3 "envoyproxy.io/envoy-cue/spec/extensions/filters/http/ext_proc/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v32 "envoyproxy.io/envoy-cue/spec/type/v3"
)

#CommonResponse_ResponseStatus: "CONTINUE" | "CONTINUE_AND_REPLACE"

CommonResponse_ResponseStatus_CONTINUE:             "CONTINUE"
CommonResponse_ResponseStatus_CONTINUE_AND_REPLACE: "CONTINUE_AND_REPLACE"

// This represents the different types of messages that Envoy can send
// to an external processing server.
// [#next-free-field: 8]
#ProcessingRequest: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ProcessingRequest"
	// Specify whether the filter that sent this request is running in synchronous
	// or asynchronous mode. The choice of synchronous or asynchronous mode
	// can be set in the filter configuration, and defaults to false.
	//
	// * A value of ``false`` indicates that the server must respond
	//   to this message by either sending back a matching ProcessingResponse message,
	//   or by closing the stream.
	// * A value of ``true`` indicates that the server must not respond to this
	//   message, although it may still close the stream to indicate that no more messages
	//   are needed.
	//
	async_mode?: bool
	// Information about the HTTP request headers, as well as peer info and additional
	// properties. Unless ``async_mode`` is ``true``, the server must send back a
	// HeaderResponse message, an ImmediateResponse message, or close the stream.
	request_headers?: #HttpHeaders
	// Information about the HTTP response headers, as well as peer info and additional
	// properties. Unless ``async_mode`` is ``true``, the server must send back a
	// HeaderResponse message or close the stream.
	response_headers?: #HttpHeaders
	// A chunk of the HTTP request body. Unless ``async_mode`` is true, the server must send back
	// a BodyResponse message, an ImmediateResponse message, or close the stream.
	request_body?: #HttpBody
	// A chunk of the HTTP request body. Unless ``async_mode`` is ``true``, the server must send back
	// a BodyResponse message or close the stream.
	response_body?: #HttpBody
	// The HTTP trailers for the request path. Unless ``async_mode`` is ``true``, the server
	// must send back a TrailerResponse message or close the stream.
	//
	// This message is only sent if the trailers processing mode is set to ``SEND``.
	// If there are no trailers on the original downstream request, then this message
	// will only be sent (with empty trailers waiting to be populated) if the
	// processing mode is set before the request headers are sent, such as
	// in the filter configuration.
	request_trailers?: #HttpTrailers
	// The HTTP trailers for the response path. Unless ``async_mode`` is ``true``, the server
	// must send back a TrailerResponse message or close the stream.
	//
	// This message is only sent if the trailers processing mode is set to ``SEND``.
	// If there are no trailers on the original downstream request, then this message
	// will only be sent (with empty trailers waiting to be populated) if the
	// processing mode is set before the request headers are sent, such as
	// in the filter configuration.
	response_trailers?: #HttpTrailers
}

// For every ProcessingRequest received by the server with the ``async_mode`` field
// set to false, the server must send back exactly one ProcessingResponse message.
// [#next-free-field: 10]
#ProcessingResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ProcessingResponse"
	// The server must send back this message in response to a message with the
	// ``request_headers`` field set.
	request_headers?: #HeadersResponse
	// The server must send back this message in response to a message with the
	// ``response_headers`` field set.
	response_headers?: #HeadersResponse
	// The server must send back this message in response to a message with
	// the ``request_body`` field set.
	request_body?: #BodyResponse
	// The server must send back this message in response to a message with
	// the ``response_body`` field set.
	response_body?: #BodyResponse
	// The server must send back this message in response to a message with
	// the ``request_trailers`` field set.
	request_trailers?: #TrailersResponse
	// The server must send back this message in response to a message with
	// the ``response_trailers`` field set.
	response_trailers?: #TrailersResponse
	// If specified, attempt to create a locally generated response, send it
	// downstream, and stop processing additional filters and ignore any
	// additional messages received from the remote server for this request or
	// response. If a response has already started -- for example, if this
	// message is sent response to a ``response_body`` message -- then
	// this will either ship the reply directly to the downstream codec,
	// or reset the stream.
	immediate_response?: #ImmediateResponse
	// [#not-implemented-hide:]
	// Optional metadata that will be emitted as dynamic metadata to be consumed by the next
	// filter. This metadata will be placed in the namespace ``envoy.filters.http.ext_proc``.
	dynamic_metadata?: _struct.#Struct
	// Override how parts of the HTTP request and response are processed
	// for the duration of this particular request/response only. Servers
	// may use this to intelligently control how requests are processed
	// based on the headers and other metadata that they see.
	mode_override?: v3.#ProcessingMode
}

// This message is sent to the external server when the HTTP request and responses
// are first received.
#HttpHeaders: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.HttpHeaders"
	// The HTTP request headers. All header keys will be
	// lower-cased, because HTTP header keys are case-insensitive.
	headers?: v31.#HeaderMap
	// [#not-implemented-hide:]
	// The values of properties selected by the ``request_attributes``
	// or ``response_attributes`` list in the configuration. Each entry
	// in the list is populated
	// from the standard :ref:`attributes <arch_overview_attributes>`
	// supported across Envoy.
	attributes?: [string]: _struct.#Struct
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
	"@type":   "type.googleapis.com/envoy.service.ext_proc.v3.HttpTrailers"
	trailers?: v31.#HeaderMap
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
	// the body chunk that was sent with that request. Body mutations only take
	// effect in response to ``body`` messages and are ignored otherwise.
	body_mutation?: #BodyMutation
	// [#not-implemented-hide:]
	// Add new trailers to the message. This may be used when responding to either a
	// HttpHeaders or HttpBody message, but only if this message is returned
	// along with the CONTINUE_AND_REPLACE status.
	trailers?: v31.#HeaderMap
	// Clear the route cache for the current request.
	// This is necessary if the remote server
	// modified headers that are used to calculate the route.
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
	body?: string
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
	// any ``x-envoy`` header, and attempts to set the ``:method``,
	// ``:authority``, ``:scheme``, or ``host`` headers will be ignored.
	set_headers?: [...v31.#HeaderValueOption]
	// Remove these HTTP headers. Attempts to remove system headers --
	// any header starting with ``:``, plus ``host`` -- will be ignored.
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

// ExternalProcessorClient is the client API for ExternalProcessor service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#ExternalProcessorClient: _

#ExternalProcessor_ProcessClient: _

// ExternalProcessorServer is the server API for ExternalProcessor service.
#ExternalProcessorServer: _

// UnimplementedExternalProcessorServer can be embedded to have forward compatible implementations.
#UnimplementedExternalProcessorServer: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.UnimplementedExternalProcessorServer"
}

#ExternalProcessor_ProcessServer: _
