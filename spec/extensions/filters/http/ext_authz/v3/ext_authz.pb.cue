package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/v3"
	v32 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
)

// [#next-free-field: 17]
#ExtAuthz: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.ExtAuthz"
	// gRPC service configuration (default timeout: 200ms).
	grpc_service?: v3.#GrpcService
	// HTTP service configuration (default timeout: 200ms).
	http_service?: #HttpService
	// API version for ext_authz transport protocol. This describes the ext_authz gRPC endpoint and
	// version of messages used on the wire.
	transport_api_version?: v3.#ApiVersion
	//  Changes filter's behaviour on errors:
	//
	//  1. When set to true, the filter will ``accept`` client request even if the communication with
	//  the authorization service has failed, or if the authorization service has returned a HTTP 5xx
	//  error.
	//
	//  2. When set to false, ext-authz will ``reject`` client requests and return a ``Forbidden``
	//  response if the communication with the authorization service has failed, or if the
	//  authorization service has returned a HTTP 5xx error.
	//
	// Note that errors can be ``always`` tracked in the :ref:`stats
	// <config_http_filters_ext_authz_stats>`.
	failure_mode_allow?: bool
	// Enables filter to buffer the client request body and send it within the authorization request.
	// A ``x-envoy-auth-partial-body: false|true`` metadata header will be added to the authorization
	// request message indicating if the body data is partial.
	with_request_body?: #BufferSettings
	// Clears route cache in order to allow the external authorization service to correctly affect
	// routing decisions. Filter clears all cached routes when:
	//
	// 1. The field is set to ``true``.
	//
	// 2. The status returned from the authorization service is a HTTP 200 or gRPC 0.
	//
	// 3. At least one ``authorization response header`` is added to the client request, or is used for
	// altering another client request header.
	//
	clear_route_cache?: bool
	// Sets the HTTP status that is returned to the client when there is a network error between the
	// filter and the authorization server. The default status is HTTP 403 Forbidden.
	status_on_error?: v31.#HttpStatus
	// Specifies a list of metadata namespaces whose values, if present, will be passed to the
	// ext_authz service. :ref:`filter_metadata <envoy_v3_api_field_config.core.v3.Metadata.filter_metadata>` is passed as an opaque ``protobuf::Struct``.
	//
	// For example, if the ``jwt_authn`` filter is used and :ref:`payload_in_metadata
	// <envoy_v3_api_field_extensions.filters.http.jwt_authn.v3.JwtProvider.payload_in_metadata>` is set,
	// then the following will pass the jwt payload to the authorization server.
	//
	// .. code-block:: yaml
	//
	//    metadata_context_namespaces:
	//    - envoy.filters.http.jwt_authn
	//
	metadata_context_namespaces?: [...string]
	// Specifies a list of metadata namespaces whose values, if present, will be passed to the
	// ext_authz service. :ref:`typed_filter_metadata <envoy_v3_api_field_config.core.v3.Metadata.typed_filter_metadata>` is passed as an ``protobuf::Any``.
	//
	// It works in a way similar to ``metadata_context_namespaces`` but allows envoy and external authz server to share the protobuf message definition
	// in order to do a safe parsing.
	//
	typed_metadata_context_namespaces?: [...string]
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
	deny_at_disable?: v3.#RuntimeFeatureFlag
	// Specifies if the peer certificate is sent to the external service.
	//
	// When this field is true, Envoy will include the peer X.509 certificate, if available, in the
	// :ref:`certificate<envoy_v3_api_field_service.auth.v3.AttributeContext.Peer.certificate>`.
	include_peer_certificate?: bool
	// Optional additional prefix to use when emitting statistics. This allows to distinguish
	// emitted statistics between configured ``ext_authz`` filters in an HTTP filter chain. For example:
	//
	// .. code-block:: yaml
	//
	//   http_filters:
	//     - name: envoy.filters.http.ext_authz
	//       typed_config:
	//         "@type": type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.ExtAuthz
	//         stat_prefix: waf # This emits ext_authz.waf.ok, ext_authz.waf.denied, etc.
	//     - name: envoy.filters.http.ext_authz
	//       typed_config:
	//         "@type": type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.ExtAuthz
	//         stat_prefix: blocker # This emits ext_authz.blocker.ok, ext_authz.blocker.denied, etc.
	//
	stat_prefix?: string
	// Optional labels that will be passed to :ref:`labels<envoy_v3_api_field_service.auth.v3.AttributeContext.Peer.labels>` in
	// :ref:`destination<envoy_v3_api_field_service.auth.v3.AttributeContext.destination>`.
	// The labels will be read from :ref:`metadata<envoy_v3_api_msg_config.core.v3.Node>` with the specified key.
	bootstrap_metadata_labels_key?: string
}

// Configuration for buffering the request data.
#BufferSettings: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ext_authz.v3.BufferSettings"
	// Sets the maximum size of a message body that the filter will hold in memory. Envoy will return
	// ``HTTP 413`` and will *not* initiate the authorization process when buffer reaches the number
	// set in this field. Note that this setting will have precedence over :ref:`failure_mode_allow
	// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.failure_mode_allow>`.
	max_request_bytes?: uint32
	// When this field is true, Envoy will buffer the message until ``max_request_bytes`` is reached.
	// The authorization request will be dispatched and no 413 HTTP error will be returned by the
	// filter.
	allow_partial_message?: bool
	// If true, the body sent to the external authorization service is set with raw bytes, it sets
	// the :ref:`raw_body<envoy_v3_api_field_service.auth.v3.AttributeContext.HttpRequest.raw_body>`
	// field of HTTP request attribute context. Otherwise, :ref:`body
	// <envoy_v3_api_field_service.auth.v3.AttributeContext.HttpRequest.body>` will be filled
	// with UTF-8 string request body.
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
	// Sets a prefix to the value of authorization request header ``Path``.
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
	//
	// .. note::
	//
	//   In addition to the the user's supplied matchers, ``Host``, ``Method``, ``Path``,
	//   ``Content-Length``, and ``Authorization`` are **automatically included** to the list.
	//
	// .. note::
	//
	//   By default, ``Content-Length`` header is set to ``0`` and the request to the authorization
	//   service has no message body. However, the authorization request *may* include the buffered
	//   client request body (controlled by :ref:`with_request_body
	//   <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.with_request_body>`
	//   setting) hence the value of its ``Content-Length`` reflects the size of its payload size.
	//
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
	// response headers that have a correspondent match will be added to the client's response. Note
	// that coexistent headers will be appended.
	allowed_upstream_headers_to_append?: v32.#ListStringMatcher
	// When this :ref:`list <envoy_v3_api_msg_type.matcher.v3.ListStringMatcher>`. is set, authorization
	// response headers that have a correspondent match will be added to the client's response. Note
	// that when this list is *not* set, all the authorization response headers, except ``Authority
	// (Host)`` will be in the response to the client. When a header is included in this list, ``Path``,
	// ``Status``, ``Content-Length``, ``WWWAuthenticate`` and ``Location`` are automatically added.
	allowed_client_headers?: v32.#ListStringMatcher
	// When this :ref:`list <envoy_v3_api_msg_type.matcher.v3.ListStringMatcher>`. is set, authorization
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
	//   These settings are only applied to a filter configured with a
	//   :ref:`grpc_service<envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.grpc_service>`.
	context_extensions?: [string]: string
	// When set to true, disable the configured :ref:`with_request_body
	// <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.with_request_body>` for a route.
	disable_request_body_buffering?: bool
}
