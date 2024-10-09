package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
	v3 "envoyproxy.io/config/core/v3"
	v31 "envoyproxy.io/config/common/mutation_rules/v3"
	v32 "envoyproxy.io/type/matcher/v3"
)

// Describes the route cache action to be taken when an external processor response
// is received in response to request headers.
#ExternalProcessor_RouteCacheAction: "DEFAULT" | "CLEAR" | "RETAIN"

ExternalProcessor_RouteCacheAction_DEFAULT: "DEFAULT"
ExternalProcessor_RouteCacheAction_CLEAR:   "CLEAR"
ExternalProcessor_RouteCacheAction_RETAIN:  "RETAIN"

// The filter communicates with an external gRPC service called an "external processor"
// that can do a variety of things with the request and response:
//
// * Access and modify the HTTP headers on the request, response, or both
// * Access and modify the HTTP request and response bodies
// * Access and modify the dynamic stream metadata
// * Immediately send an HTTP response downstream and terminate other processing
//
// The filter communicates with the server using a gRPC bidirectional stream. After the initial
// request, the external server is in control over what additional data is sent to it
// and how it should be processed.
//
// By implementing the protocol specified by the stream, the external server can choose:
//
//   - Whether it receives the response message at all
//   - Whether it receives the message body at all, in separate chunks, or as a single buffer
//   - Whether subsequent HTTP requests are transmitted synchronously or whether they are
//     sent asynchronously.
//   - To modify request or response trailers if they already exist
//
// The filter supports up to six different processing steps. Each is represented by
// a gRPC stream message that is sent to the external processor. For each message, the
// processor must send a matching response.
//
//   - Request headers: Contains the headers from the original HTTP request.
//   - Request body: Delivered if they are present and sent in a single message if
//     the BUFFERED or BUFFERED_PARTIAL mode is chosen, in multiple messages if the
//     STREAMED mode is chosen, and not at all otherwise.
//   - Request trailers: Delivered if they are present and if the trailer mode is set
//     to SEND.
//   - Response headers: Contains the headers from the HTTP response. Keep in mind
//     that if the upstream system sends them before processing the request body that
//     this message may arrive before the complete body.
//   - Response body: Sent according to the processing mode like the request body.
//   - Response trailers: Delivered according to the processing mode like the
//     request trailers.
//
// By default, the processor sends only the request and response headers messages.
// This may be changed to include any of the six steps by changing the processing_mode
// setting of the filter configuration, or by setting the mode_override of any response
// from the external processor. The latter is only enabled if allow_mode_override is
// set to true. This way, a processor may, for example, use information
// in the request header to determine whether the message body must be examined, or whether
// the proxy should simply stream it straight through.
//
// All of this together allows a server to process the filter traffic in fairly
// sophisticated ways. For example:
//
//   - A server may choose to examine all or part of the HTTP message bodies depending
//     on the content of the headers.
//   - A server may choose to immediately reject some messages based on their HTTP
//     headers (or other dynamic metadata) and more carefully examine others.
//   - A server may asynchronously monitor traffic coming through the filter by inspecting
//     headers, bodies, or both, and then decide to switch to a synchronous processing
//     mode, either permanently or temporarily.
//
// The protocol itself is based on a bidirectional gRPC stream. Envoy will send the
// server
// :ref:`ProcessingRequest <envoy_v3_api_msg_service.ext_proc.v3.ProcessingRequest>`
// messages, and the server must reply with
// :ref:`ProcessingResponse <envoy_v3_api_msg_service.ext_proc.v3.ProcessingResponse>`.
//
// Stats about each gRPC call are recorded in a :ref:`dynamic filter state
// <arch_overview_advanced_filter_state_sharing>` object in a namespace matching the filter
// name.
//
// [#next-free-field: 23]
#ExternalProcessor: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.ExternalProcessor"
	// Configuration for the gRPC service that the filter will communicate with.
	// The filter supports both the "Envoy" and "Google" gRPC clients.
	// Only one of “grpc_service“ or “http_service“ can be set.
	// It is required that one of them must be set.
	grpc_service?: v3.#GrpcService
	// [#not-implemented-hide:]
	// Configuration for the HTTP service that the filter will communicate with.
	// Only one of “http_service“ or
	// :ref:`grpc_service <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.grpc_service>`.
	// can be set. It is required that one of them must be set.
	//
	// If “http_service“ is set, the
	// :ref:`processing_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// can not be configured to send any body or trailers. i.e, http_service only supports
	// sending request or response headers to the side stream server.
	//
	// With this configuration, Envoy behavior:
	//
	// 1. The headers are first put in a proto message
	// :ref:`ProcessingRequest <envoy_v3_api_msg_service.ext_proc.v3.ProcessingRequest>`.
	//
	// 2. This proto message is then transcoded into a JSON text.
	//
	// 3. Envoy then sends a HTTP POST message with content-type as "application/json",
	// and this JSON text as body to the side stream server.
	//
	// After the side-stream receives this HTTP request message, it is expected to do as follows:
	//
	// 1. It converts the body, which is a JSON string, into a “ProcessingRequest“
	// proto message to examine and mutate the headers.
	//
	// 2. It then sets the mutated headers into a new proto message
	// :ref:`ProcessingResponse <envoy_v3_api_msg_service.ext_proc.v3.ProcessingResponse>`.
	//
	// 3. It converts “ProcessingResponse“ proto message into a JSON text.
	//
	// 4. It then sends a HTTP response back to Envoy with status code as "200",
	// content-type as "application/json" and sets the JSON text as the body.
	http_service?: #ExtProcHttpService
	// By default, if the gRPC stream cannot be established, or if it is closed
	// prematurely with an error, the filter will fail. Specifically, if the
	// response headers have not yet been delivered, then it will return a 500
	// error downstream. If they have been delivered, then instead the HTTP stream to the
	// downstream client will be reset.
	// With this parameter set to true, however, then if the gRPC stream is prematurely closed
	// or could not be opened, processing continues without error.
	failure_mode_allow?: bool
	// Specifies default options for how HTTP headers, trailers, and bodies are
	// sent. See ProcessingMode for details.
	processing_mode?: #ProcessingMode
	// Envoy provides a number of :ref:`attributes <arch_overview_attributes>`
	// for expressive policies. Each attribute name provided in this field will be
	// matched against that list and populated in the request_headers message.
	// See the :ref:`attribute documentation <arch_overview_request_attributes>`
	// for the list of supported attributes and their types.
	request_attributes?: [...string]
	// Envoy provides a number of :ref:`attributes <arch_overview_attributes>`
	// for expressive policies. Each attribute name provided in this field will be
	// matched against that list and populated in the response_headers message.
	// See the :ref:`attribute documentation <arch_overview_attributes>`
	// for the list of supported attributes and their types.
	response_attributes?: [...string]
	// Specifies the timeout for each individual message sent on the stream and
	// when the filter is running in synchronous mode. Whenever the proxy sends
	// a message on the stream that requires a response, it will reset this timer,
	// and will stop processing and return an error (subject to the processing mode)
	// if the timer expires before a matching response is received. There is no
	// timeout when the filter is running in asynchronous mode. Zero is a valid
	// config which means the timer will be triggered immediately. If not
	// configured, default is 200 milliseconds.
	message_timeout?: durationpb.#Duration
	// Optional additional prefix to use when emitting statistics. This allows to distinguish
	// emitted statistics between configured *ext_proc* filters in an HTTP filter chain.
	stat_prefix?: string
	// Rules that determine what modifications an external processing server may
	// make to message headers. If not set, all headers may be modified except
	// for "host", ":authority", ":scheme", ":method", and headers that start
	// with the header prefix set via
	// :ref:`header_prefix <envoy_v3_api_field_config.bootstrap.v3.Bootstrap.header_prefix>`
	// (which is usually "x-envoy").
	// Note that changing headers such as "host" or ":authority" may not in itself
	// change Envoy's routing decision, as routes can be cached. To also force the
	// route to be recomputed, set the
	// :ref:`clear_route_cache <envoy_v3_api_field_service.ext_proc.v3.CommonResponse.clear_route_cache>`
	// field to true in the same response.
	mutation_rules?: v31.#HeaderMutationRules
	// Specify the upper bound of
	// :ref:`override_message_timeout <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.override_message_timeout>`
	// If not specified, by default it is 0, which will effectively disable the “override_message_timeout“ API.
	max_message_timeout?: durationpb.#Duration
	// Allow headers matching the “forward_rules“ to be forwarded to the external processing server.
	// If not set, all headers are forwarded to the external processing server.
	forward_rules?: #HeaderForwardingRules
	// Additional metadata to be added to the filter state for logging purposes. The metadata
	// will be added to StreamInfo's filter state under the namespace corresponding to the
	// ext_proc filter name.
	filter_metadata?: structpb.#Struct
	// If “allow_mode_override“ is set to true, the filter config :ref:`processing_mode
	// <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// can be overridden by the response message from the external processing server
	// :ref:`mode_override <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.mode_override>`.
	// If not set, “mode_override“ API in the response message will be ignored.
	allow_mode_override?: bool
	// If set to true, ignore the
	// :ref:`immediate_response <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.immediate_response>`
	// message in an external processor response. In such case, no local reply will be sent.
	// Instead, the stream to the external processor will be closed. There will be no
	// more external processing for this stream from now on.
	disable_immediate_response?: bool
	// Options related to the sending and receiving of dynamic metadata.
	metadata_options?: #MetadataOptions
	// If true, send each part of the HTTP request or response specified by ProcessingMode
	// without pausing on filter chain iteration. It is "Send and Go" mode that can be used
	// by external processor to observe Envoy data and status. In this mode:
	//
	// 1. Only STREAMED body processing mode is supported and any other body processing modes will be
	// ignored. NONE mode(i.e., skip body processing) will still work as expected.
	//
	// 2. External processor should not send back processing response, as any responses will be ignored.
	// This also means that
	// :ref:`message_timeout <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.message_timeout>`
	// restriction doesn't apply to this mode.
	//
	// 3. External processor may still close the stream to indicate that no more messages are needed.
	//
	// .. warning::
	//
	//	Flow control is necessary mechanism to prevent the fast sender (either downstream client or upstream server)
	//	from overwhelming the external processor when its processing speed is slower.
	//	This protective measure is being explored and developed but has not been ready yet, so please use your own
	//	discretion when enabling this feature.
	//	This work is currently tracked under https://github.com/envoyproxy/envoy/issues/33319.
	observability_mode?: bool
	// Prevents clearing the route-cache when the
	// :ref:`clear_route_cache <envoy_v3_api_field_service.ext_proc.v3.CommonResponse.clear_route_cache>`
	// field is set in an external processor response.
	// Only one of “disable_clear_route_cache“ or “route_cache_action“ can be set.
	// It is recommended to set “route_cache_action“ which supersedes “disable_clear_route_cache“.
	disable_clear_route_cache?: bool
	// Specifies the action to be taken when an external processor response is
	// received in response to request headers. It is recommended to set this field than set
	// :ref:`disable_clear_route_cache <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.disable_clear_route_cache>`.
	// Only one of “disable_clear_route_cache“ or “route_cache_action“ can be set.
	route_cache_action?: #ExternalProcessor_RouteCacheAction
	// Specifies the deferred closure timeout for gRPC stream that connects to external processor. Currently, the deferred stream closure
	// is only used in :ref:`observability_mode <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.observability_mode>`.
	// In observability mode, gRPC streams may be held open to the external processor longer than the lifetime of the regular client to
	// backend stream lifetime. In this case, Envoy will eventually timeout the external processor stream according to this time limit.
	// The default value is 5000 milliseconds (5 seconds) if not specified.
	deferred_close_timeout?: durationpb.#Duration
	// Send body to the side stream server once it arrives without waiting for the header response from that server.
	// It only works for STREAMED body processing mode. For any other body processing modes, it is ignored.
	// The server has two options upon receiving a header request:
	//
	// 1. Instant Response: send the header response as soon as the header request is received.
	//
	// 2. Delayed Response: wait for the body before sending any response.
	//
	// In all scenarios, the header-body ordering must always be maintained.
	//
	// If enabled Envoy will ignore the
	// :ref:`mode_override <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.mode_override>`
	// value that the server sends in the header response. This is because Envoy may have already
	// sent the body to the server, prior to processing the header response.
	send_body_without_waiting_for_header_response?: bool
	// When :ref:`allow_mode_override
	// <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.allow_mode_override>` is enabled and
	// “allowed_override_modes“ is configured, the filter config :ref:`processing_mode
	// <envoy_v3_api_field_extensions.filters.http.ext_proc.v3.ExternalProcessor.processing_mode>`
	// can only be overridden by the response message from the external processing server iff the
	// :ref:`mode_override <envoy_v3_api_field_service.ext_proc.v3.ProcessingResponse.mode_override>` is allowed by
	// the “allowed_override_modes“ allow-list below.
	allowed_override_modes?: [...#ProcessingMode]
}

// ExtProcHttpService is used for HTTP communication between the filter and the external processing service.
#ExtProcHttpService: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.ExtProcHttpService"
	// Sets the HTTP service which the external processing requests must be sent to.
	http_service?: v3.#HttpService
}

// The MetadataOptions structure defines options for the sending and receiving of
// dynamic metadata. Specifically, which namespaces to send to the server, whether
// metadata returned by the server may be written, and how that metadata may be written.
#MetadataOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.MetadataOptions"
	// Describes which typed or untyped dynamic metadata namespaces to forward to
	// the external processing server.
	forwarding_namespaces?: #MetadataOptions_MetadataNamespaces
	// Describes which typed or untyped dynamic metadata namespaces to accept from
	// the external processing server. Set to empty or leave unset to disallow writing
	// any received dynamic metadata. Receiving of typed metadata is not supported.
	receiving_namespaces?: #MetadataOptions_MetadataNamespaces
}

// The HeaderForwardingRules structure specifies what headers are
// allowed to be forwarded to the external processing server.
//
// This works as below:
//
//  1. If neither “allowed_headers“ nor “disallowed_headers“ is set, all headers are forwarded.
//  2. If both “allowed_headers“ and “disallowed_headers“ are set, only headers in the
//     “allowed_headers“ but not in the “disallowed_headers“ are forwarded.
//  3. If “allowed_headers“ is set, and “disallowed_headers“ is not set, only headers in
//     the “allowed_headers“ are forwarded.
//  4. If “disallowed_headers“ is set, and “allowed_headers“ is not set, all headers except
//     headers in the “disallowed_headers“ are forwarded.
#HeaderForwardingRules: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.HeaderForwardingRules"
	// If set, specifically allow any header in this list to be forwarded to the external
	// processing server. This can be overridden by the below “disallowed_headers“.
	allowed_headers?: v32.#ListStringMatcher
	// If set, specifically disallow any header in this list to be forwarded to the external
	// processing server. This overrides the above “allowed_headers“ if a header matches both.
	disallowed_headers?: v32.#ListStringMatcher
}

// Extra settings that may be added to per-route configuration for a
// virtual host or cluster.
#ExtProcPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.ExtProcPerRoute"
	// Disable the filter for this particular vhost or route.
	// If disabled is specified in multiple per-filter-configs, the most specific one will be used.
	disabled?: bool
	// Override aspects of the configuration for this route. A set of
	// overrides in a more specific configuration will override a "disabled"
	// flag set in a less-specific one.
	overrides?: #ExtProcOverrides
}

// Overrides that may be set on a per-route basis
// [#next-free-field: 8]
#ExtProcOverrides: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.ExtProcOverrides"
	// Set a different processing mode for this route than the default.
	processing_mode?: #ProcessingMode
	// [#not-implemented-hide:]
	// Set a different asynchronous processing option than the default.
	async_mode?: bool
	// [#not-implemented-hide:]
	// Set different optional attributes than the default setting of the
	// “request_attributes“ field.
	request_attributes?: [...string]
	// [#not-implemented-hide:]
	// Set different optional properties than the default setting of the
	// “response_attributes“ field.
	response_attributes?: [...string]
	// Set a different gRPC service for this route than the default.
	grpc_service?: v3.#GrpcService
	// Options related to the sending and receiving of dynamic metadata.
	// Lists of forwarding and receiving namespaces will be overridden in their entirety,
	// meaning the most-specific config that specifies this override will be the final
	// config used. It is the prerogative of the control plane to ensure this
	// most-specific config contains the correct final overrides.
	metadata_options?: #MetadataOptions
	// Additional metadata to include into streams initiated to the ext_proc gRPC
	// service. This can be used for scenarios in which additional ad hoc
	// authorization headers (e.g. “x-foo-bar: baz-key“) are to be injected or
	// when a route needs to partially override inherited metadata.
	grpc_initial_metadata?: [...v3.#HeaderValue]
}

#MetadataOptions_MetadataNamespaces: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_proc.v3.MetadataOptions_MetadataNamespaces"
	// Specifies a list of metadata namespaces whose values, if present,
	// will be passed to the ext_proc service as an opaque *protobuf::Struct*.
	untyped?: [...string]
	// Specifies a list of metadata namespaces whose values, if present,
	// will be passed to the ext_proc service as a *protobuf::Any*. This allows
	// envoy and the external processing server to share the protobuf message
	// definition for safe parsing.
	typed?: [...string]
}
