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
	// If the client is waiting for a header response from the server, setting to ``true`` means the
	// client will send the body to the server as it arrives. Setting to ``false`` means the client
	// will buffer the arrived data and not send it to the server immediately.
	send_body_without_waiting_for_header_response?: bool
}

// This represents the different types of messages that the data plane can send
// to an external processing server.
// [#next-free-field: 14]
#ProcessingRequest: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ProcessingRequest"
	// Information about the HTTP request headers, as well as peer info and additional
	// properties. Unless ``observability_mode`` is ``true``, the server must send back a
	// ``HeaderResponse`` message, an ``ImmediateResponse`` message, or close the stream.
	request_headers?: #HttpHeaders
	// Information about the HTTP response headers, as well as peer info and additional
	// properties. Unless ``observability_mode`` is ``true``, the server must send back a
	// ``HeaderResponse`` message or close the stream.
	response_headers?: #HttpHeaders
	// A chunk of the HTTP request body. Unless ``observability_mode`` is ``true``, the server must
	// send back a ``BodyResponse`` message, an ``ImmediateResponse`` message, or close the stream.
	request_body?: #HttpBody
	// A chunk of the HTTP response body. Unless ``observability_mode`` is ``true``, the server must
	// send back a ``BodyResponse`` message or close the stream.
	response_body?: #HttpBody
	// The HTTP trailers for the request path. Unless ``observability_mode`` is ``true``, the server
	// must send back a ``TrailerResponse`` message or close the stream.
	//
	// This message is only sent if the trailers processing mode is set to ``SEND`` and
	// the original downstream request has trailers.
	request_trailers?: #HttpTrailers
	// The HTTP trailers for the response path. Unless ``observability_mode`` is ``true``, the server
	// must send back a ``TrailerResponse`` message or close the stream.
	//
	// This message is only sent if the trailers processing mode is set to ``SEND`` and
	// the original upstream response has trailers.
	response_trailers?: #HttpTrailers
	// Dynamic metadata associated with the request.
	metadata_context?: v31.#Metadata
	// The values of properties selected by the ``request_attributes``
	// or ``response_attributes`` list in the configuration. Each entry
	// in the list is populated from the standard
	// :ref:`attributes <arch_overview_attributes>` supported in the data plane.
	attributes?: [string]: structpb.#Struct
	// Specifies whether the filter that sent this request is running in
	// :ref:`observability_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.observability_mode>`.
	//
	// * A value of ``false`` indicates that the server must respond to this message by either
	//   sending back a matching ``ProcessingResponse`` message, or by closing the stream.
	// * A value of ``true`` indicates that the server should not respond to this message, as any
	//   responses will be ignored. However, it may still close the stream to indicate that no more
	//   messages are needed.
	//
	// Defaults to ``false``.
	observability_mode?: bool
	// Specify the filter protocol configurations to be sent to the server.
	// ``protocol_config`` is only encoded in the first ``ProcessingRequest`` message from the client to the server.
	protocol_config?: #ProtocolConfiguration
	// Flow control initialization for ``FULL_DUPLEX_STREAMED`` and
	// ``GRPC`` body send modes.
	//
	// Must be set in the initial message on the stream. Not used in
	// subsequent messages.
	//
	// [#not-implemented-hide:]
	flow_control_init?: #ProcessingRequest_FlowControlInit
	// Flow control updates for ``FULL_DUPLEX_STREAMED`` and ``GRPC`` body
	// send modes.
	//
	// This message may be included in a request message that also
	// populates one of the fields in the ``request`` oneof above, or it
	// may be sent in a request message that does not set the
	// ``request`` oneof.
	//
	// In ``FULL_DUPLEX_STREAMED`` body send mode, for backward
	// compatibility with data planes that do not yet support flow control,
	// the data plane must not send a message containing only this field
	// (i.e., not setting the ``request`` oneof) unless the ext_proc server
	// has sent a window update, thus indicating that it supports flow control.
	//
	// [#not-implemented-hide:]
	client_window_update?: #ProcessingRequest_ClientWindowUpdate
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
// [#next-free-field: 17]
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
	// The server sends back this message to initiate or continue local response streaming.
	// The server must initiate local response streaming with the ``headers_response`` in response
	// to a ``ProcessingRequest`` with the ``request_headers`` only.
	// The server may follow up with multiple messages containing ``body_response``. The server must
	// indicate end of stream by setting ``end_of_stream`` to ``true`` in the ``headers_response``
	// or ``body_response`` message or by sending a ``trailers_response`` message.
	// The client may send a ``request_body`` or ``request_trailers`` to the server depending on
	// configuration.
	// The streaming local response can only be sent when the ``request_header_mode`` in the filter
	// :ref:`processing_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// is set to ``SEND``. The ext_proc server should not send ``StreamedImmediateResponse`` if it
	// did not observe request headers, as it will result in a race with the upstream server
	// response and reset of the client request.
	// Presently only the ``FULL_DUPLEX_STREAMED`` or ``NONE`` body modes are supported.
	streamed_immediate_response?: #StreamedImmediateResponse
	// Optional metadata that will be emitted as dynamic metadata to be consumed by
	// following filters. This metadata will be placed in the namespace(s) specified by the top-level
	// field name(s) of the struct.
	dynamic_metadata?: structpb.#Struct
	// Optional typed metadata that will be emitted as dynamic metadata to be consumed by
	// following filters. This metadata will be placed in the namespace(s) specified by the
	// keys of the map.
	//
	// Typed dynamic metadata should be preferred over untyped dynamic metadata (``dynamic_metadata``)
	// because it is more efficient and more type-safe.
	typed_dynamic_metadata?: [string]: _
	// Override how parts of the HTTP request and response are processed for the duration of this
	// particular request/response only. Servers may use this to intelligently control how requests
	// are processed based on the headers and other metadata that they see.
	//
	// If set in a response to body or trailer requests, it will be ignored by the data plane.
	// It is also ignored by the data plane when the ext_proc filter config
	// :ref:`allow_mode_override <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.allow_mode_override>`
	// is set to ``false``, or
	// :ref:`send_body_without_waiting_for_header_response <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.send_body_without_waiting_for_header_response>`
	// is set to ``true``.
	//
	// ``mode_override`` can be sent in the following scenarios:
	//
	// 1. Included in a header response:
	//    The server can set this field when responding to request or response headers, i.e.,
	//    alongside a ``request_headers`` or ``response_headers`` response.
	//
	// 2. Standalone ``mode_override`` response:
	//    After receiving a ``ProcessingRequest`` for request headers, the server can send a
	//    standalone ``mode_override`` response (i.e., a ``ProcessingResponse`` with only
	//    ``mode_override`` populated and no ``response`` case set) before sending the
	//    ``request_headers`` response. Subsequent messages will adhere to this new mode.
	//
	//    .. note::
	//      Processing mode changes in a standalone ``mode_override`` have the following constraints:
	//
	//      * For request path: Only supports transitioning the request body processing mode from
	//        ``NONE`` or ``STREAMED`` to ``FULL_DUPLEX_STREAMED``. Additionally, the request
	//        trailer mode must be set to ``SEND``, which is required by ``FULL_DUPLEX_STREAMED``
	//        mode. Responses that do not meet these constraints are treated as spurious and rejected.
	//      * For Response path: There are no restrictions on processing mode changes.
	//
	mode_override?: v3.#ProcessingMode
	// [#not-implemented-hide:]
	// Deprecated and not implemented. This field has been replaced with
	// the request_drain_requests and request_drain_responses fields.
	//
	// Deprecated: Marked as deprecated in envoy/service/ext_proc/v3/external_processor.proto.
	request_drain?: bool
	// [#not-implemented-hide:]
	// Initiates a drain of request body data. Used only in
	// ``FULL_DUPLEX_STREAMED`` and ``GRPC`` body send modes.
	//
	// The expected sequence for a drain is as follows:
	//
	// 1. The ext_proc server sends a message to the data plane with this
	//    field set to true.
	// 2. The data plane pauses reading from the downstream client, applying
	//    any necessary flow control push-back.
	// 3. The data plane sends a
	//    :ref:`request_body <envoy_v3_api_field_service.ext_proc.v3.ProcessingRequest.request_body>`
	//    with the
	//    :ref:`drain_complete <envoy_v3_api_field_service.ext_proc.v3.HttpBody.drain_complete>`
	//    field set to true.
	// 4. The ext_proc server continues processing all subsequent request body
	//    chunks until it sees the body chunk with the
	//    :ref:`drain_complete <envoy_v3_api_field_service.ext_proc.v3.HttpBody.drain_complete>`
	//    field set to true. When sending back its response to that last body
	//    chunk, the ext_proc server will set the
	//    :ref:`drain_complete <envoy_v3_api_field_service.ext_proc.v3.StreamedBodyResponse.drain_complete>`
	//    field to true to let the data plane know that it has finished draining.
	// 5. When the data plane sees the response with the
	//    :ref:`drain_complete <envoy_v3_api_field_service.ext_proc.v3.StreamedBodyResponse.drain_complete>`
	//    field set to true, it will resume reading from the downstream
	//    client, passing all data directly to the upstream server,
	//    without going through the ext_proc sidestream.
	//
	// This procedure provides a safe way for the ext_proc server to indicate
	// that it does not need to see the rest of the request body.
	//
	// Note that if the data plane is sending request body data and the
	// ext_proc server wants to terminate the stream with an OK status, it
	// must perform this drain before doing so.
	//
	// Note that the data plane may have either sent a body chunk with
	// :ref:`end_of_stream <envoy_v3_api_field_service.ext_proc.v3.StreamedBodyResponse.end_of_stream>`
	// set to true or may have sent trailers before it received the drain
	// request from the ext_proc server. In these cases, the data plane will
	// ignore the drain request, and the ext_proc will consider the drain
	// complete when it sees the end-of-stream or trailers.
	request_drain_requests?: bool
	// [#not-implemented-hide:]
	// Initiates a drain of response body data. Used only in
	// ``FULL_DUPLEX_STREAMED`` and ``GRPC`` body send modes.
	//
	// The expected sequence for a drain is as follows:
	//
	// 1. The ext_proc server sends a message to the data plane with this
	//    field set to true.
	// 2. The data plane pauses reading from the upstream server, applying
	//    any necessary flow control push-back.
	// 3. The data plane sends a
	//    :ref:`response_body <envoy_v3_api_field_service.ext_proc.v3.ProcessingRequest.response_body>`
	//    with the
	//    :ref:`drain_complete <envoy_v3_api_field_service.ext_proc.v3.HttpBody.drain_complete>`
	//    field set to true.
	// 4. The ext_proc server continues processing all subsequent response body
	//    chunks until it sees the body chunk with the
	//    :ref:`drain_complete <envoy_v3_api_field_service.ext_proc.v3.HttpBody.drain_complete>`
	//    field set to true. When sending back its response to that last body
	//    chunk, the ext_proc server will set the
	//    :ref:`drain_complete <envoy_v3_api_field_service.ext_proc.v3.StreamedBodyResponse.drain_complete>`
	//    field to true to let the data plane know that it has finished draining.
	// 5. When the data plane sees the response with the
	//    :ref:`drain_complete <envoy_v3_api_field_service.ext_proc.v3.StreamedBodyResponse.drain_complete>`
	//    field set to true, it will resume reading from the upstream
	//    server, passing all data directly to the downstream client,
	//    without going through the ext_proc sidestream.
	//
	// This procedure provides a safe way for the ext_proc server to indicate
	// that it does not need to see the rest of the response body.
	//
	// Note that if the data plane is sending response body data and the
	// ext_proc server wants to terminate the stream with an OK status, it
	// must perform this drain before doing so.
	//
	// Note that the data plane may have either sent a body chunk with
	// :ref:`end_of_stream <envoy_v3_api_field_service.ext_proc.v3.StreamedBodyResponse.end_of_stream>`
	// set to true or may have sent trailers before it received the drain
	// request from the ext_proc server. In these cases, the data plane will
	// ignore the drain request, and the ext_proc will consider the drain
	// complete when it sees the end-of-stream or trailers.
	request_drain_responses?: bool
	// When the ext_proc server receives a request message and needs more time to process it, it
	// sends back a ``ProcessingResponse`` message with a new timeout value. When the data plane
	// receives this response message, it ignores other fields in the response, stops the original
	// timer (which has the timeout value specified in
	// :ref:`message_timeout <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.message_timeout>`),
	// and starts a new timer with this ``override_message_timeout`` value while keeping the data
	// plane ext_proc filter state machine intact.
	//
	// The value must be >= 1ms and <=
	// :ref:`max_message_timeout <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.max_message_timeout>`.
	// Such a message can be sent at most once in a particular data plane ext_proc filter processing
	// state. To enable this API, ``max_message_timeout`` must be set to a value >= 1ms.
	override_message_timeout?: string
	// Flow control updates for ``FULL_DUPLEX_STREAMED`` and ``GRPC`` body
	// send modes.
	//
	// This message may be included in a response message that also
	// populates one of the fields in the ``response`` oneof above, or it
	// may be sent in a response message that does not set the
	// ``response`` oneof.
	//
	// In ``FULL_DUPLEX_STREAMED`` body send mode, for backward
	// compatibility with data planes that do not yet support flow control,
	// the ext_proc server must not set this field unless the data plane
	// sent initial window sizes in its initial message on the stream.
	// Conversely, if the data plane did send initial window sizes in its
	// initial message on the stream, the ext_proc server must send a
	// window update immediately to let the data plane know that it also
	// supports flow control. If the ext_proc server is sending a message
	// immediately anyway (e.g., for a header or body chunk), it can include
	// this field in that same message; otherwise, the ext_proc server must
	// send a message containing only this field.
	//
	// [#not-implemented-hide:]
	server_window_update?: #ProcessingResponse_ServerWindowUpdate
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
	// If ``true``, then there is no message body associated with this request or response.
	end_of_stream?: bool
}

// This message is sent to the external server when the HTTP request and response bodies are
// received.
// [#next-free-field: 6]
#HttpBody: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.HttpBody"
	// The contents of the body in the HTTP request/response. Note that in streaming mode multiple
	// ``HttpBody`` messages may be sent.
	//
	// In ``GRPC`` body send mode, a separate ``HttpBody`` message will be sent for each message in
	// the gRPC stream.
	body?: bytes
	// If ``true``, this will be the last ``HttpBody`` message that will be sent and no trailers
	// will be sent for the current request/response.
	end_of_stream?: bool
	// This field is used only in ``GRPC`` body send mode. It is not used in any other body send
	// mode.
	//
	// This field is used only when ``end_of_stream`` is true and ``body`` is empty.
	// Normally, in ``GRPC`` body send mode, an empty ``body`` field indicates an empty message on
	// the gRPC stream. However, it is possible that the gRPC client sends a half-close without
	// actually sending a message on the stream, so we need a way to differentiate between
	// an empty message being sent and no message being sent. If this field is true, then it
	// indicates that no message has been sent; if it is false, then it indicates that an empty
	// message has been sent.
	// [#not-implemented-hide:]
	end_of_stream_without_message?: bool
	// This field is used in ``GRPC`` body send mode to indicate whether the message is compressed.
	// This will never be set to ``true`` by gRPC but may be set to ``true`` by a proxy like Envoy.
	grpc_message_compressed?: bool
	// [#not-implemented-hide:]
	// In ``FULL_DUPLEX_STREAMED`` or ``GRPC`` body send modes, if the
	// data plane has seen the
	// :ref:`request_drain_requests <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.request_drain_requests>`
	// or :ref:`request_drain_responses <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.request_drain_responses>`
	// field, it will populate this field to indicate that it has finished
	// sending data to the ext_proc server.
	drain_complete?: bool
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
	// Response headers to be sent downstream. The ``:status`` header must be set.
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
	// ``HttpBody`` request, header mutations will only take effect if the current processing mode
	// for the body is ``BUFFERED``.
	header_mutation?: #HeaderMutation
	// Replace the body of the last message sent to the remote server on this stream. If responding
	// to an ``HttpBody`` request, simply replace or clear the body chunk that was sent with that
	// request. Body mutations may take effect in response either to ``header`` or ``body`` messages.
	// When it is in response to ``header`` messages, it only takes effect if the
	// :ref:`status <envoy_v3_api_field_service.ext_proc.v3.CommonResponse.status>`
	// is set to ``CONTINUE_AND_REPLACE``.
	body_mutation?: #BodyMutation
	// [#not-implemented-hide:]
	// Add new trailers to the message. This may be used when responding to either an
	// ``HttpHeaders`` or ``HttpBody`` message, but only if this message is returned
	// along with the ``CONTINUE_AND_REPLACE`` status.
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
	// Apply changes to the default headers, which will include ``content-type``.
	headers?: #HeaderMutation
	// The message body to return with the response which is sent using the
	// ``text/plain`` content type, or encoded in the ``grpc-message`` header.
	body?: bytes
	// If set, then include a gRPC status trailer.
	grpc_status?: #GrpcStatus
	// A string detailing why this local reply was sent, which may be included
	// in log and debug output (e.g., this populates the ``%RESPONSE_CODE_DETAILS%``
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
	// any ``x-envoy`` header, and attempts to set the ``:method``,
	// ``:authority``, ``:scheme``, or ``host`` headers will be ignored.
	// The header value is encoded in the
	// :ref:`raw_value <envoy_v3_api_field_config.core.v3.HeaderValue.raw_value>` field.
	// Note that the :ref:`append field in HeaderValueOption <envoy_v3_api_field_config.core.v3.HeaderValueOption.append>`
	// defaults to false when used in this message.
	// The :ref:`keep_empty_value field in HeaderValueOption <envoy_v3_api_field_config.core.v3.HeaderValueOption.keep_empty_value>`
	// is not supported.
	set_headers?: [...v31.#HeaderValueOption]
	// Remove these HTTP headers. Attempts to remove system headers --
	// any header starting with ``:``, plus ``host`` -- will be ignored.
	remove_headers?: [...string]
}

// The body response message corresponding to “FULL_DUPLEX_STREAMED“ or “GRPC“ body modes.
// [#next-free-field: 6]
#StreamedBodyResponse: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.StreamedBodyResponse"
	// In ``FULL_DUPLEX_STREAMED`` body send mode, contains the body response chunk that will be
	// passed to the upstream/downstream by the data plane. In ``GRPC`` body send mode, contains
	// a serialized gRPC message to be passed to the upstream/downstream by the data plane.
	body?: bytes
	// The server sets this flag to ``true`` if it has received a body request with
	// :ref:`end_of_stream <envoy_v3_api_field_service.ext_proc.v3.HttpBody.end_of_stream>` set to
	// ``true``, and this is the last chunk of body responses.
	//
	// Note that in ``GRPC`` body send mode, this allows the ext_proc server to tell the data plane
	// to send a half close after a client message, which will result in discarding any other
	// messages sent by the client application.
	end_of_stream?: bool
	// This field is used only in ``GRPC`` body send mode. It is not used in any other body send
	// mode.
	//
	// This field is used only when ``end_of_stream`` is true and ``body`` is empty.
	// Normally, in ``GRPC`` body send mode, an empty ``body`` field indicates an empty message on
	// the gRPC stream. However, it is possible that the gRPC client sends a half-close without
	// actually sending a message on the stream, so we need a way to differentiate between
	// an empty message being sent and no message being sent. If this field is true, then it
	// indicates that no message has been sent; if it is false, then it indicates that an empty
	// message has been sent.
	// [#not-implemented-hide:]
	end_of_stream_without_message?: bool
	// This field is used in ``GRPC`` body send mode to indicate whether the message is compressed.
	// This will never be set to ``true`` by gRPC but may be set to ``true`` by a proxy like Envoy.
	grpc_message_compressed?: bool
	// [#not-implemented-hide:]
	// In ``FULL_DUPLEX_STREAMED`` or ``GRPC`` body send modes, if the
	// ext_proc server has seen the
	// :ref:`drain_complete <envoy_v3_api_field_service.ext_proc.v3.HttpBody.drain_complete>`
	// field, it will populate this field to indicate that it has finished
	// sending data back to the data plane.
	//
	// If the data plane receives a message with this field set to true
	// before it has sent a drain-complete message to the ext_proc server,
	// the data plane will treat that as if the ext_proc stream has failed
	// with a non-OK status.
	drain_complete?: bool
}

// This message specifies the body mutation the server sends to the data plane.
#BodyMutation: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.BodyMutation"
	// The entire body to replace.
	// Should only be used when the corresponding ``BodySendMode`` in the
	// :ref:`processing_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// is not set to ``FULL_DUPLEX_STREAMED`` or ``GRPC``.
	body?: bytes
	// Clear the corresponding body chunk. Should only be used when the corresponding
	// ``BodySendMode`` in the
	// :ref:`processing_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// is not set to ``FULL_DUPLEX_STREAMED`` or ``GRPC``.
	clear_body?: bool
	// Must be used when the corresponding ``BodySendMode`` in the
	// :ref:`processing_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// is set to ``FULL_DUPLEX_STREAMED`` or ``GRPC``.
	streamed_response?: #StreamedBodyResponse
}

// Initial flow control window sizes for “FULL_DUPLEX_STREAMED“ and
// “GRPC“ body send modes.
//
// A sender starts with this amount of flow control window. Whenever
// it sends body data, it must decrement its flow control window by
// the number of bytes that it has sent. When its flow control
// window is less than or equal to the amount of body data it wishes
// to send, it may not send until it receives a window update causing
// its flow control window to be large enough.
//
// However, note that in “GRPC“ body send mode, whenever the flow
// control window is greater than zero, a sender may send a single
// message, even if the size of that message exceeds the available flow
// control window. At that point, the flow control window will be negative
// and the sender must not send the next message until it becomes positive.
//
// Note that the initial size for the to-sidestream windows are set by
// the sender, not the receiver. This is because each sidestream may be
// routed to a different ext_proc server instance, but there is no
// connection-level handshake to set a default for that server
// instance, so the only alternative here would be to have the
// ext_proc server instance set this on a per-stream basis, which
// would require an additional round-trip and therefore hurt latency.
// This unfortunately means that the ext_proc server instance has a
// bit less control: as soon as it receives these initial values, it can
// immediately send a window update that reduces the window, but it
// must be prepared to handle any data that the sender has already sent.
// The initial sizes for the to-sidestream windows are generally
// expected to be in the range of 32K to 64K.
//
// [#not-implemented-hide:]
#ProcessingRequest_FlowControlInit: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ProcessingRequest_FlowControlInit"
	// Downstream-to-sidestream initial window size.
	initial_window_downstream_to_sidestream?: int64
	// Sidestream-to-upstream initial window size.
	initial_window_sidestream_to_upstream?: int64
	// Upstream-to-sidestream initial window size.
	initial_window_upstream_to_sidestream?: int64
	// Sidestream-to-downstream initial window size.
	initial_window_sidestream_to_downstream?: int64
}

// Flow control window update. Values may be positive or negative. The
// sender must immediately add these values to its flow control window,
// which governs how much data can be sent.
//
// [#not-implemented-hide:]
#ProcessingRequest_ClientWindowUpdate: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ProcessingRequest_ClientWindowUpdate"
	// Window update for sidestream-to-upstream.
	window_increment_sidestream_to_upstream?: int64
	// Window update for sidestream-to-downstream.
	window_increment_sidestream_to_downstream?: int64
}

// Flow control window update. Values may be positive or negative. The
// sender must immediately add these values to its flow control window,
// which governs how much data can be sent.
//
// [#not-implemented-hide:]
#ProcessingResponse_ServerWindowUpdate: {
	"@type": "type.googleapis.com/envoy.service.ext_proc.v3.ProcessingResponse_ServerWindowUpdate"
	// Window update for downstream-to-sidestream.
	window_increment_downstream_to_sidestream?: int64
	// Window update for upstream-to-sidestream.
	window_increment_upstream_to_sidestream?: int64
}
