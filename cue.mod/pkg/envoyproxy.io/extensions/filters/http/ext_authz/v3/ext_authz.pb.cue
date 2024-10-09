package v3

import (
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
	v3 "envoyproxy.io/config/core/v3"
	v31 "envoyproxy.io/type/v3"
	v32 "envoyproxy.io/type/matcher/v3"
	v33 "envoyproxy.io/config/common/mutation_rules/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// [#next-free-field: 30]
#ExtAuthz: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.ExtAuthz"
	// gRPC service configuration (default timeout: 200ms).
	grpc_service?: v3.#GrpcService
	// HTTP service configuration (default timeout: 200ms).
	http_service?: #HttpService
	// API version for ext_authz transport protocol. This describes the ext_authz gRPC endpoint and
	// version of messages used on the wire.
	transport_api_version?: v3.#ApiVersion
	//	Changes filter's behaviour on errors:
	//
	//	1. When set to true, the filter will ``accept`` client request even if the communication with
	//	the authorization service has failed, or if the authorization service has returned a HTTP 5xx
	//	error.
	//
	//	2. When set to false, ext-authz will ``reject`` client requests and return a ``Forbidden``
	//	response if the communication with the authorization service has failed, or if the
	//	authorization service has returned a HTTP 5xx error.
	//
	// Note that errors can be “always“ tracked in the :ref:`stats
	// <config_http_filters_ext_authz_stats>`.
	failure_mode_allow?: bool
	// When “failure_mode_allow“ and “failure_mode_allow_header_add“ are both set to true,
	// “x-envoy-auth-failure-mode-allowed: true“ will be added to request headers if the communication
	// with the authorization service has failed, or if the authorization service has returned a
	// HTTP 5xx error.
	failure_mode_allow_header_add?: bool
	// Enables filter to buffer the client request body and send it within the authorization request.
	// A “x-envoy-auth-partial-body: false|true“ metadata header will be added to the authorization
	// request message indicating if the body data is partial.
	with_request_body?: #BufferSettings
	// Clears route cache in order to allow the external authorization service to correctly affect
	// routing decisions. Filter clears all cached routes when:
	//
	// 1. The field is set to “true“.
	//
	// 2. The status returned from the authorization service is a HTTP 200 or gRPC 0.
	//
	// 3. At least one “authorization response header“ is added to the client request, or is used for
	// altering another client request header.
	clear_route_cache?: bool
	// Sets the HTTP status that is returned to the client when the authorization server returns an error
	// or cannot be reached. The default status is HTTP 403 Forbidden.
	status_on_error?: v31.#HttpStatus
	// When this is set to true, the filter will check the :ref:`ext_authz response
	// <envoy_v3_api_msg_service.auth.v3.CheckResponse>` for invalid header &
	// query parameter mutations. If the side stream response is invalid, it will send a local reply
	// to the downstream request with status HTTP 500 Internal Server Error.
	//
	// Note that headers_to_remove & query_parameters_to_remove are validated, but invalid elements in
	// those fields should not affect any headers & thus will not cause the filter to send a local
	// reply.
	//
	// When set to false, any invalid mutations will be visible to the rest of envoy and may cause
	// unexpected behavior.
	//
	// If you are using ext_authz with an untrusted ext_authz server, you should set this to true.
	validate_mutations?: bool
	// Specifies a list of metadata namespaces whose values, if present, will be passed to the
	// ext_authz service. The :ref:`filter_metadata <envoy_v3_api_field_config.core.v3.Metadata.filter_metadata>`
	// is passed as an opaque “protobuf::Struct“.
	//
	// Please note that this field exclusively applies to the gRPC ext_authz service and has no effect on the HTTP service.
	//
	// For example, if the “jwt_authn“ filter is used and :ref:`payload_in_metadata
	// <envoy_v3_api_field_extensions.filters.http.jwt_authn.v3.JwtProvider.payload_in_metadata>` is set,
	// then the following will pass the jwt payload to the authorization server.
	//
	// .. code-block:: yaml
	//
	//	metadata_context_namespaces:
	//	- envoy.filters.http.jwt_authn
	metadata_context_namespaces?: [...string]
	// Specifies a list of metadata namespaces whose values, if present, will be passed to the
	// ext_authz service. :ref:`typed_filter_metadata <envoy_v3_api_field_config.core.v3.Metadata.typed_filter_metadata>`
	// is passed as a “protobuf::Any“.
	//
	// Please note that this field exclusively applies to the gRPC ext_authz service and has no effect on the HTTP service.
	//
	// It works in a way similar to “metadata_context_namespaces“ but allows Envoy and ext_authz server to share
	// the protobuf message definition in order to do a safe parsing.
	typed_metadata_context_namespaces?: [...string]
	// Specifies a list of route metadata namespaces whose values, if present, will be passed to the
	// ext_authz service at :ref:`route_metadata_context <envoy_v3_api_field_service.auth.v3.AttributeContext.route_metadata_context>` in
	// :ref:`CheckRequest <envoy_v3_api_field_service.auth.v3.CheckRequest.attributes>`.
	// :ref:`filter_metadata <envoy_v3_api_field_config.core.v3.Metadata.filter_metadata>` is passed as an opaque “protobuf::Struct“.
	route_metadata_context_namespaces?: [...string]
	// Specifies a list of route metadata namespaces whose values, if present, will be passed to the
	// ext_authz service at :ref:`route_metadata_context <envoy_v3_api_field_service.auth.v3.AttributeContext.route_metadata_context>` in
	// :ref:`CheckRequest <envoy_v3_api_field_service.auth.v3.CheckRequest.attributes>`.
	// :ref:`typed_filter_metadata <envoy_v3_api_field_config.core.v3.Metadata.typed_filter_metadata>` is passed as an “protobuf::Any“.
	route_typed_metadata_context_namespaces?: [...string]
	// Specifies if the filter is enabled.
	//
	// If :ref:`runtime_key <envoy_v3_api_field_config.core.v3.RuntimeFractionalPercent.runtime_key>` is specified,
	// Envoy will lookup the runtime key to get the percentage of requests to filter.
	//
	// If this field is not specified, the filter will be enabled for all requests.
	filter_enabled?: v3.#RuntimeFractionalPercent
	// Specifies if the filter is enabled with metadata matcher.
	// If this field is not specified, the filter will be enabled for all requests.
	filter_enabled_metadata?: v32.#MetadataMatcher
	// Specifies whether to deny the requests, when the filter is disabled.
	// If :ref:`runtime_key <envoy_v3_api_field_config.core.v3.RuntimeFeatureFlag.runtime_key>` is specified,
	// Envoy will lookup the runtime key to determine whether to deny request for
	// filter protected path at filter disabling. If filter is disabled in
	// typed_per_filter_config for the path, requests will not be denied.
	//
	// If this field is not specified, all requests will be allowed when disabled.
	//
	// If a request is denied due to this setting, the response code in :ref:`status_on_error
	// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.status_on_error>` will
	// be returned.
	deny_at_disable?: v3.#RuntimeFeatureFlag
	// Specifies if the peer certificate is sent to the external service.
	//
	// When this field is true, Envoy will include the peer X.509 certificate, if available, in the
	// :ref:`certificate<envoy_v3_api_field_service.auth.v3.AttributeContext.Peer.certificate>`.
	include_peer_certificate?: bool
	// Optional additional prefix to use when emitting statistics. This allows to distinguish
	// emitted statistics between configured “ext_authz“ filters in an HTTP filter chain. For example:
	//
	// .. code-block:: yaml
	//
	//	http_filters:
	//	  - name: envoy.filters.http.ext_authz
	//	    typed_config:
	//	      "@type": type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.ExtAuthz
	//	      stat_prefix: waf # This emits ext_authz.waf.ok, ext_authz.waf.denied, etc.
	//	  - name: envoy.filters.http.ext_authz
	//	    typed_config:
	//	      "@type": type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.ExtAuthz
	//	      stat_prefix: blocker # This emits ext_authz.blocker.ok, ext_authz.blocker.denied, etc.
	stat_prefix?: string
	// Optional labels that will be passed to :ref:`labels<envoy_v3_api_field_service.auth.v3.AttributeContext.Peer.labels>` in
	// :ref:`destination<envoy_v3_api_field_service.auth.v3.AttributeContext.destination>`.
	// The labels will be read from :ref:`metadata<envoy_v3_api_msg_config.core.v3.Node>` with the specified key.
	bootstrap_metadata_labels_key?: string
	// Check request to authorization server will include the client request headers that have a correspondent match
	// in the :ref:`list <envoy_v3_api_msg_type.matcher.v3.ListStringMatcher>`. If this option isn't specified, then
	// all client request headers are included in the check request to a gRPC authorization server, whereas no client request headers
	// (besides the ones allowed by default - see note below) are included in the check request to an HTTP authorization server.
	// This inconsistency between gRPC and HTTP servers is to maintain backwards compatibility with legacy behavior.
	//
	// .. note::
	//
	//  1. For requests to an HTTP authorization server: in addition to the the user's supplied matchers, “Host“, “Method“, “Path“,
	//     “Content-Length“, and “Authorization“ are **additionally included** in the list.
	//
	// .. note::
	//
	//  2. For requests to an HTTP authorization server: *Content-Length* will be set to 0 and the request to the
	//     authorization server will not have a message body. However, the check request can include the buffered
	//     client request body (controlled by :ref:`with_request_body
	//     <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.with_request_body>` setting),
	//     consequently the value of *Content-Length* of the authorization request reflects the size of
	//     its payload size.
	//
	// .. note::
	//
	//  3. This can be overridden by the field “disallowed_headers“ below. That is, if a header
	//     matches for both “allowed_headers“ and “disallowed_headers“, the header will NOT be sent.
	allowed_headers?: v32.#ListStringMatcher
	// If set, specifically disallow any header in this list to be forwarded to the external
	// authentication server. This overrides the above “allowed_headers“ if a header matches both.
	disallowed_headers?: v32.#ListStringMatcher
	// Specifies if the TLS session level details like SNI are sent to the external service.
	//
	// When this field is true, Envoy will include the SNI name used for TLSClientHello, if available, in the
	// :ref:`tls_session<envoy_v3_api_field_service.auth.v3.AttributeContext.tls_session>`.
	include_tls_session?: bool
	// Whether to increment cluster statistics (e.g. cluster.<cluster_name>.upstream_rq_*) on authorization failure.
	// Defaults to true.
	charge_cluster_response_stats?: wrapperspb.#BoolValue
	// Whether to encode the raw headers (i.e. unsanitized values & unconcatenated multi-line headers)
	// in authentication request. Works with both HTTP and GRPC clients.
	//
	// When this is set to true, header values are not sanitized. Headers with the same key will also
	// not be combined into a single, comma-separated header.
	// Requests to GRPC services will populate the field
	// :ref:`header_map<envoy_v3_api_field_service.auth.v3.AttributeContext.HttpRequest.header_map>`.
	// Requests to HTTP services will be constructed with the unsanitized header values and preserved
	// multi-line headers with the same key.
	//
	// If this field is set to false, header values will be sanitized, with any non-UTF-8-compliant
	// bytes replaced with '!'. Headers with the same key will have their values concatenated into a
	// single comma-separated header value.
	// Requests to GRPC services will populate the field
	// :ref:`headers<envoy_v3_api_field_service.auth.v3.AttributeContext.HttpRequest.headers>`.
	// Requests to HTTP services will have their header values sanitized and will not preserve
	// multi-line headers with the same key.
	//
	// It's recommended you set this to true unless you already rely on the old behavior. False is the
	// default only for backwards compatibility.
	encode_raw_headers?: bool
	// Rules for what modifications an ext_authz server may make to the request headers before
	// continuing decoding / forwarding upstream.
	//
	// If set to anything, enables header mutation checking against configured rules. Note that
	// :ref:`HeaderMutationRules <envoy_v3_api_msg_config.common.mutation_rules.v3.HeaderMutationRules>`
	// has defaults that change ext_authz behavior. Also note that if this field is set to anything,
	// ext_authz can no longer append to :-prefixed headers.
	//
	// If empty, header mutation rule checking is completely disabled.
	//
	// Regardless of what is configured here, ext_authz cannot remove :-prefixed headers.
	//
	// This field and “validate_mutations“ have different use cases. “validate_mutations“ enables
	// correctness checks for all header / query parameter mutations (e.g. for invalid characters).
	// This field allows the filter to reject mutations to specific headers.
	decoder_header_mutation_rules?: v33.#HeaderMutationRules
	// Enable / disable ingestion of dynamic metadata from ext_authz service.
	//
	// If false, the filter will ignore dynamic metadata injected by the ext_authz service. If the
	// ext_authz service tries injecting dynamic metadata, the filter will log, increment the
	// “ignored_dynamic_metadata“ stat, then continue handling the response.
	//
	// If true, the filter will ingest dynamic metadata entries as normal.
	//
	// If unset, defaults to true.
	enable_dynamic_metadata_ingestion?: wrapperspb.#BoolValue
	// Additional metadata to be added to the filter state for logging purposes. The metadata will be
	// added to StreamInfo's filter state under the namespace corresponding to the ext_authz filter
	// name.
	filter_metadata?: structpb.#Struct
	// When set to true, the filter will emit per-stream stats for access logging. The filter state
	// key will be the same as the filter name.
	//
	// If using Envoy GRPC, emits latency, bytes sent / received, upstream info, and upstream cluster
	// info. If not using Envoy GRPC, emits only latency. Note that stats are ONLY added to filter
	// state if a check request is actually made to an ext_authz service.
	//
	// If this is false the filter will not emit stats, but filter_metadata will still be respected if
	// it has a value.
	emit_filter_state_stats?: bool
}

// Configuration for buffering the request data.
#BufferSettings: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.BufferSettings"
	// Sets the maximum size of a message body that the filter will hold in memory. Envoy will return
	// “HTTP 413“ and will *not* initiate the authorization process when buffer reaches the number
	// set in this field. Note that this setting will have precedence over :ref:`failure_mode_allow
	// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.failure_mode_allow>`.
	max_request_bytes?: uint32
	// When this field is true, Envoy will buffer the message until “max_request_bytes“ is reached.
	// The authorization request will be dispatched and no 413 HTTP error will be returned by the
	// filter.
	allow_partial_message?: bool
	// If true, the body sent to the external authorization service is set with raw bytes, it sets
	// the :ref:`raw_body<envoy_v3_api_field_service.auth.v3.AttributeContext.HttpRequest.raw_body>`
	// field of HTTP request attribute context. Otherwise, :ref:`body
	// <envoy_v3_api_field_service.auth.v3.AttributeContext.HttpRequest.body>` will be filled
	// with UTF-8 string request body.
	//
	// This field only affects configurations using a :ref:`grpc_service
	// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.grpc_service>`. In configurations that use
	// an :ref:`http_service <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.http_service>`, this
	// has no effect.
	pack_as_bytes?: bool
}

// HttpService is used for raw HTTP communication between the filter and the authorization service.
// When configured, the filter will parse the client request and use these attributes to call the
// authorization server. Depending on the response, the filter may reject or accept the client
// request. Note that in any of these events, metadata can be added, removed or overridden by the
// filter:
//
// *On authorization request*, a list of allowed request headers may be supplied. See
// :ref:`allowed_headers
// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.AuthorizationRequest.allowed_headers>`
// for details. Additional headers metadata may be added to the authorization request. See
// :ref:`headers_to_add
// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.AuthorizationRequest.headers_to_add>` for
// details.
//
// On authorization response status HTTP 200 OK, the filter will allow traffic to the upstream and
// additional headers metadata may be added to the original client request. See
// :ref:`allowed_upstream_headers
// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.AuthorizationResponse.allowed_upstream_headers>`
// for details. Additionally, the filter may add additional headers to the client's response. See
// :ref:`allowed_client_headers_on_success
// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.AuthorizationResponse.allowed_client_headers_on_success>`
// for details.
//
// On other authorization response statuses, the filter will not allow traffic. Additional headers
// metadata as well as body may be added to the client's response. See :ref:`allowed_client_headers
// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.AuthorizationResponse.allowed_client_headers>`
// for details.
// [#next-free-field: 9]
#HttpService: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.HttpService"
	// Sets the HTTP server URI which the authorization requests must be sent to.
	server_uri?: v3.#HttpUri
	// Sets a prefix to the value of authorization request header “Path“.
	path_prefix?: string
	// Settings used for controlling authorization request metadata.
	authorization_request?: #AuthorizationRequest
	// Settings used for controlling authorization response metadata.
	authorization_response?: #AuthorizationResponse
}

#AuthorizationRequest: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.AuthorizationRequest"
	// Authorization request includes the client request headers that have a correspondent match
	// in the :ref:`list <envoy_v3_api_msg_type.matcher.v3.ListStringMatcher>`.
	// This field has been deprecated in favor of :ref:`allowed_headers
	// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.allowed_headers>`.
	//
	// .. note::
	//
	//	In addition to the the user's supplied matchers, ``Host``, ``Method``, ``Path``,
	//	``Content-Length``, and ``Authorization`` are **automatically included** to the list.
	//
	// .. note::
	//
	//	By default, ``Content-Length`` header is set to ``0`` and the request to the authorization
	//	service has no message body. However, the authorization request *may* include the buffered
	//	client request body (controlled by :ref:`with_request_body
	//	<envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.with_request_body>`
	//	setting) hence the value of its ``Content-Length`` reflects the size of its payload size.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/http/ext_authz/v3/ext_authz.proto.
	allowed_headers?: v32.#ListStringMatcher
	// Sets a list of headers that will be included to the request to authorization service. Note that
	// client request of the same key will be overridden.
	headers_to_add?: [...v3.#HeaderValue]
}

// [#next-free-field: 6]
#AuthorizationResponse: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.AuthorizationResponse"
	// When this :ref:`list <envoy_v3_api_msg_type.matcher.v3.ListStringMatcher>` is set, authorization
	// response headers that have a correspondent match will be added to the original client request.
	// Note that coexistent headers will be overridden.
	allowed_upstream_headers?: v32.#ListStringMatcher
	// When this :ref:`list <envoy_v3_api_msg_type.matcher.v3.ListStringMatcher>` is set, authorization
	// response headers that have a correspondent match will be added to the original client request.
	// Note that coexistent headers will be appended.
	allowed_upstream_headers_to_append?: v32.#ListStringMatcher
	// When this :ref:`list <envoy_v3_api_msg_type.matcher.v3.ListStringMatcher>` is set, authorization
	// response headers that have a correspondent match will be added to the client's response. Note
	// that when this list is *not* set, all the authorization response headers, except “Authority
	// (Host)“ will be in the response to the client. When a header is included in this list, “Path“,
	// “Status“, “Content-Length“, “WWWAuthenticate“ and “Location“ are automatically added.
	allowed_client_headers?: v32.#ListStringMatcher
	// When this :ref:`list <envoy_v3_api_msg_type.matcher.v3.ListStringMatcher>` is set, authorization
	// response headers that have a correspondent match will be added to the client's response when
	// the authorization response itself is successful, i.e. not failed or denied. When this list is
	// *not* set, no additional headers will be added to the client's response on success.
	allowed_client_headers_on_success?: v32.#ListStringMatcher
	// When this :ref:`list <envoy_v3_api_msg_type.matcher.v3.ListStringMatcher>` is set, authorization
	// response headers that have a correspondent match will be emitted as dynamic metadata to be consumed
	// by the next filter. This metadata lives in a namespace specified by the canonical name of extension filter
	// that requires it:
	//
	// - :ref:`envoy.filters.http.ext_authz <config_http_filters_ext_authz_dynamic_metadata>` for HTTP filter.
	// - :ref:`envoy.filters.network.ext_authz <config_network_filters_ext_authz_dynamic_metadata>` for network filter.
	dynamic_metadata_from_headers?: v32.#ListStringMatcher
}

// Extra settings on a per virtualhost/route/weighted-cluster level.
#ExtAuthzPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.ExtAuthzPerRoute"
	// Disable the ext auth filter for this particular vhost or route.
	// If disabled is specified in multiple per-filter-configs, the most specific one will be used.
	disabled?: bool
	// Check request settings for this route.
	check_settings?: #CheckSettings
}

// Extra settings for the check request.
#CheckSettings: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.CheckSettings"
	// Context extensions to set on the CheckRequest's
	// :ref:`AttributeContext.context_extensions<envoy_v3_api_field_service.auth.v3.AttributeContext.context_extensions>`
	//
	// You can use this to provide extra context for the external authorization server on specific
	// virtual hosts/routes. For example, adding a context extension on the virtual host level can
	// give the ext-authz server information on what virtual host is used without needing to parse the
	// host header. If CheckSettings is specified in multiple per-filter-configs, they will be merged
	// in order, and the result will be used.
	//
	// Merge semantics for this field are such that keys from more specific configs override.
	//
	// .. note::
	//
	//	These settings are only applied to a filter configured with a
	//	:ref:`grpc_service<envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.grpc_service>`.
	context_extensions?: [string]: string
	// When set to true, disable the configured :ref:`with_request_body
	// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.with_request_body>` for a specific route.
	//
	// Please note that only one of *disable_request_body_buffering* or
	// :ref:`with_request_body <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.CheckSettings.with_request_body>`
	// may be specified.
	disable_request_body_buffering?: bool
	// Enable or override request body buffering, which is configured using the
	// :ref:`with_request_body <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.with_request_body>`
	// option for a specific route.
	//
	// Please note that only only one of *with_request_body* or
	// :ref:`disable_request_body_buffering <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.CheckSettings.disable_request_body_buffering>`
	// may be specified.
	with_request_body?: #BufferSettings
}
