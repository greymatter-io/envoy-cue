package v2

import (
	_type "envoyproxy.io/type"
	core "envoyproxy.io/api/v2/core"
	matcher "envoyproxy.io/type/matcher"
)

// [#next-free-field: 12]
#ExtAuthz: {
	"@type": "type.googleapis.com/envoy.config.filter.http.ext_authz.v2.ExtAuthz"
	// gRPC service configuration (default timeout: 200ms).
	grpc_service?: core.#GrpcService
	// HTTP service configuration (default timeout: 200ms).
	http_service?: #HttpService
	//  Changes filter's behaviour on errors:
	//
	//  1. When set to true, the filter will *accept* client request even if the communication with
	//  the authorization service has failed, or if the authorization service has returned a HTTP 5xx
	//  error.
	//
	//  2. When set to false, ext-authz will *reject* client requests and return a *Forbidden*
	//  response if the communication with the authorization service has failed, or if the
	//  authorization service has returned a HTTP 5xx error.
	//
	// Note that errors can be *always* tracked in the :ref:`stats
	// <config_http_filters_ext_authz_stats>`.
	failure_mode_allow?: bool
	// [#not-implemented-hide: Support for this field has been removed.]
	//
	// Deprecated: Do not use.
	use_alpha?: bool
	// Enables filter to buffer the client request body and send it within the authorization request.
	// A ``x-envoy-auth-partial-body: false|true`` metadata header will be added to the authorization
	// request message indicating if the body data is partial.
	with_request_body?: #BufferSettings
	// Clears route cache in order to allow the external authorization service to correctly affect
	// routing decisions. Filter clears all cached routes when:
	//
	// 1. The field is set to *true*.
	//
	// 2. The status returned from the authorization service is a HTTP 200 or gRPC 0.
	//
	// 3. At least one *authorization response header* is added to the client request, or is used for
	// altering another client request header.
	//
	clear_route_cache?: bool
	// Sets the HTTP status that is returned to the client when there is a network error between the
	// filter and the authorization server. The default status is HTTP 403 Forbidden.
	status_on_error?: _type.#HttpStatus
	// Specifies a list of metadata namespaces whose values, if present, will be passed to the
	// ext_authz service as an opaque *protobuf::Struct*.
	//
	// For example, if the *jwt_authn* filter is used and :ref:`payload_in_metadata
	// <envoy_api_field_config.filter.http.jwt_authn.v2alpha.JwtProvider.payload_in_metadata>` is set,
	// then the following will pass the jwt payload to the authorization server.
	//
	// .. code-block:: yaml
	//
	//    metadata_context_namespaces:
	//    - envoy.filters.http.jwt_authn
	//
	metadata_context_namespaces?: [...string]
	// Specifies if the filter is enabled.
	//
	// If :ref:`runtime_key <envoy_api_field_core.RuntimeFractionalPercent.runtime_key>` is specified,
	// Envoy will lookup the runtime key to get the percentage of requests to filter.
	//
	// If this field is not specified, the filter will be enabled for all requests.
	filter_enabled?: core.#RuntimeFractionalPercent
	// Specifies whether to deny the requests, when the filter is disabled.
	// If :ref:`runtime_key <envoy_api_field_core.RuntimeFeatureFlag.runtime_key>` is specified,
	// Envoy will lookup the runtime key to determine whether to deny request for
	// filter protected path at filter disabling. If filter is disabled in
	// typed_per_filter_config for the path, requests will not be denied.
	//
	// If this field is not specified, all requests will be allowed when disabled.
	deny_at_disable?: core.#RuntimeFeatureFlag
	// Specifies if the peer certificate is sent to the external service.
	//
	// When this field is true, Envoy will include the peer X.509 certificate, if available, in the
	// :ref:`certificate<envoy_api_field_service.auth.v2.AttributeContext.Peer.certificate>`.
	include_peer_certificate?: bool
}

// Configuration for buffering the request data.
#BufferSettings: {
	"@type": "type.googleapis.com/envoy.config.filter.http.ext_authz.v2.BufferSettings"
	// Sets the maximum size of a message body that the filter will hold in memory. Envoy will return
	// *HTTP 413* and will *not* initiate the authorization process when buffer reaches the number
	// set in this field. Note that this setting will have precedence over :ref:`failure_mode_allow
	// <envoy_api_field_config.filter.http.ext_authz.v2.ExtAuthz.failure_mode_allow>`.
	max_request_bytes?: uint32
	// When this field is true, Envoy will buffer the message until *max_request_bytes* is reached.
	// The authorization request will be dispatched and no 413 HTTP error will be returned by the
	// filter.
	allow_partial_message?: bool
}

// HttpService is used for raw HTTP communication between the filter and the authorization service.
// When configured, the filter will parse the client request and use these attributes to call the
// authorization server. Depending on the response, the filter may reject or accept the client
// request. Note that in any of these events, metadata can be added, removed or overridden by the
// filter:
//
// *On authorization request*, a list of allowed request headers may be supplied. See
// :ref:`allowed_headers
// <envoy_api_field_config.filter.http.ext_authz.v2.AuthorizationRequest.allowed_headers>`
// for details. Additional headers metadata may be added to the authorization request. See
// :ref:`headers_to_add
// <envoy_api_field_config.filter.http.ext_authz.v2.AuthorizationRequest.headers_to_add>` for
// details.
//
// On authorization response status HTTP 200 OK, the filter will allow traffic to the upstream and
// additional headers metadata may be added to the original client request. See
// :ref:`allowed_upstream_headers
// <envoy_api_field_config.filter.http.ext_authz.v2.AuthorizationResponse.allowed_upstream_headers>`
// for details.
//
// On other authorization response statuses, the filter will not allow traffic. Additional headers
// metadata as well as body may be added to the client's response. See :ref:`allowed_client_headers
// <envoy_api_field_config.filter.http.ext_authz.v2.AuthorizationResponse.allowed_client_headers>`
// for details.
// [#next-free-field: 9]
#HttpService: {
	"@type": "type.googleapis.com/envoy.config.filter.http.ext_authz.v2.HttpService"
	// Sets the HTTP server URI which the authorization requests must be sent to.
	server_uri?: core.#HttpUri
	// Sets a prefix to the value of authorization request header *Path*.
	path_prefix?: string
	// Settings used for controlling authorization request metadata.
	authorization_request?: #AuthorizationRequest
	// Settings used for controlling authorization response metadata.
	authorization_response?: #AuthorizationResponse
}

#AuthorizationRequest: {
	"@type": "type.googleapis.com/envoy.config.filter.http.ext_authz.v2.AuthorizationRequest"
	// Authorization request will include the client request headers that have a correspondent match
	// in the :ref:`list <envoy_api_msg_type.matcher.ListStringMatcher>`. Note that in addition to the
	// user's supplied matchers:
	//
	// 1. *Host*, *Method*, *Path* and *Content-Length* are automatically included to the list.
	//
	// 2. *Content-Length* will be set to 0 and the request to the authorization service will not have
	// a message body. However, the authorization request can include the buffered client request body
	// (controlled by :ref:`with_request_body
	// <envoy_api_field_config.filter.http.ext_authz.v2.ExtAuthz.with_request_body>` setting),
	// consequently the value of *Content-Length* of the authorization request reflects the size of
	// its payload size.
	//
	allowed_headers?: matcher.#ListStringMatcher
	// Sets a list of headers that will be included to the request to authorization service. Note that
	// client request of the same key will be overridden.
	headers_to_add?: [...core.#HeaderValue]
}

#AuthorizationResponse: {
	"@type": "type.googleapis.com/envoy.config.filter.http.ext_authz.v2.AuthorizationResponse"
	// When this :ref:`list <envoy_api_msg_type.matcher.ListStringMatcher>` is set, authorization
	// response headers that have a correspondent match will be added to the original client request.
	// Note that coexistent headers will be overridden.
	allowed_upstream_headers?: matcher.#ListStringMatcher
	// When this :ref:`list <envoy_api_msg_type.matcher.ListStringMatcher>`. is set, authorization
	// response headers that have a correspondent match will be added to the client's response. Note
	// that when this list is *not* set, all the authorization response headers, except *Authority
	// (Host)* will be in the response to the client. When a header is included in this list, *Path*,
	// *Status*, *Content-Length*, *WWWAuthenticate* and *Location* are automatically added.
	allowed_client_headers?: matcher.#ListStringMatcher
}

// Extra settings on a per virtualhost/route/weighted-cluster level.
#ExtAuthzPerRoute: {
	"@type": "type.googleapis.com/envoy.config.filter.http.ext_authz.v2.ExtAuthzPerRoute"
	// Disable the ext auth filter for this particular vhost or route.
	// If disabled is specified in multiple per-filter-configs, the most specific one will be used.
	disabled?: bool
	// Check request settings for this route.
	check_settings?: #CheckSettings
}

// Extra settings for the check request. You can use this to provide extra context for the
// external authorization server on specific virtual hosts \ routes. For example, adding a context
// extension on the virtual host level can give the ext-authz server information on what virtual
// host is used without needing to parse the host header. If CheckSettings is specified in multiple
// per-filter-configs, they will be merged in order, and the result will be used.
#CheckSettings: {
	"@type": "type.googleapis.com/envoy.config.filter.http.ext_authz.v2.CheckSettings"
	// Context extensions to set on the CheckRequest's
	// :ref:`AttributeContext.context_extensions<envoy_api_field_service.auth.v2.AttributeContext.context_extensions>`
	//
	// Merge semantics for this field are such that keys from more specific configs override.
	//
	// .. note::
	//
	//   These settings are only applied to a filter configured with a
	//   :ref:`grpc_service<envoy_api_field_config.filter.http.ext_authz.v2.ExtAuthz.grpc_service>`.
	context_extensions?: [string]: string
}
