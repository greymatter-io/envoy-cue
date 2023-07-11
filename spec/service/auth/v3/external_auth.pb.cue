package v3

import (
	_struct "envoyproxy.io/envoy-cue/spec/deps/golang/protobuf/ptypes/struct"
	status "envoyproxy.io/envoy-cue/spec/deps/genproto/googleapis/rpc/status"
	v3 "envoyproxy.io/envoy-cue/spec/type/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#CheckRequest: {
	"@type": "type.googleapis.com/envoy.service.auth.v3.CheckRequest"
	// The request attributes.
	attributes?: #AttributeContext
}

// HTTP attributes for a denied response.
#DeniedHttpResponse: {
	"@type": "type.googleapis.com/envoy.service.auth.v3.DeniedHttpResponse"
	// This field allows the authorization service to send an HTTP response status code to the
	// downstream client. If not set, Envoy sends ``403 Forbidden`` HTTP status code by default.
	status?: v3.#HttpStatus
	// This field allows the authorization service to send HTTP response headers
	// to the downstream client. Note that the :ref:`append field in HeaderValueOption <envoy_v3_api_field_config.core.v3.HeaderValueOption.append>` defaults to
	// false when used in this message.
	headers?: [...v31.#HeaderValueOption]
	// This field allows the authorization service to send a response body data
	// to the downstream client.
	body?: string
}

// HTTP attributes for an OK response.
// [#next-free-field: 9]
#OkHttpResponse: {
	"@type": "type.googleapis.com/envoy.service.auth.v3.OkHttpResponse"
	// HTTP entity headers in addition to the original request headers. This allows the authorization
	// service to append, to add or to override headers from the original request before
	// dispatching it to the upstream. Note that the :ref:`append field in HeaderValueOption <envoy_v3_api_field_config.core.v3.HeaderValueOption.append>` defaults to
	// false when used in this message. By setting the ``append`` field to ``true``,
	// the filter will append the correspondent header value to the matched request header.
	// By leaving ``append`` as false, the filter will either add a new header, or override an existing
	// one if there is a match.
	headers?: [...v31.#HeaderValueOption]
	// HTTP entity headers to remove from the original request before dispatching
	// it to the upstream. This allows the authorization service to act on auth
	// related headers (like ``Authorization``), process them, and consume them.
	// Under this model, the upstream will either receive the request (if it's
	// authorized) or not receive it (if it's not), but will not see headers
	// containing authorization credentials.
	//
	// Pseudo headers (such as ``:authority``, ``:method``, ``:path`` etc), as well as
	// the header ``Host``, may not be removed as that would make the request
	// malformed. If mentioned in ``headers_to_remove`` these special headers will
	// be ignored.
	//
	// When using the HTTP service this must instead be set by the HTTP
	// authorization service as a comma separated list like so:
	// ``x-envoy-auth-headers-to-remove: one-auth-header, another-auth-header``.
	headers_to_remove?: [...string]
	// This field has been deprecated in favor of :ref:`CheckResponse.dynamic_metadata
	// <envoy_v3_api_field_service.auth.v3.CheckResponse.dynamic_metadata>`. Until it is removed,
	// setting this field overrides :ref:`CheckResponse.dynamic_metadata
	// <envoy_v3_api_field_service.auth.v3.CheckResponse.dynamic_metadata>`.
	//
	// Deprecated: Do not use.
	dynamic_metadata?: _struct.#Struct
	// This field allows the authorization service to send HTTP response headers
	// to the downstream client on success. Note that the :ref:`append field in HeaderValueOption <envoy_v3_api_field_config.core.v3.HeaderValueOption.append>`
	// defaults to false when used in this message.
	response_headers_to_add?: [...v31.#HeaderValueOption]
	// This field allows the authorization service to set (and overwrite) query
	// string parameters on the original request before it is sent upstream.
	query_parameters_to_set?: [...v31.#QueryParameter]
	// This field allows the authorization service to specify which query parameters
	// should be removed from the original request before it is sent upstream. Each
	// element in this list is a case-sensitive query parameter name to be removed.
	query_parameters_to_remove?: [...string]
}

// Intended for gRPC and Network Authorization servers ``only``.
#CheckResponse: {
	"@type": "type.googleapis.com/envoy.service.auth.v3.CheckResponse"
	// Status ``OK`` allows the request. Any other status indicates the request should be denied, and
	// for HTTP filter, if not overridden by :ref:`denied HTTP response status <envoy_v3_api_field_service.auth.v3.DeniedHttpResponse.status>`
	// Envoy sends ``403 Forbidden`` HTTP status code by default.
	status?: status.#Status
	// Supplies http attributes for a denied response.
	denied_response?: #DeniedHttpResponse
	// Supplies http attributes for an ok response.
	ok_response?: #OkHttpResponse
	// Optional response metadata that will be emitted as dynamic metadata to be consumed by the next
	// filter. This metadata lives in a namespace specified by the canonical name of extension filter
	// that requires it:
	//
	// - :ref:`envoy.filters.http.ext_authz <config_http_filters_ext_authz_dynamic_metadata>` for HTTP filter.
	// - :ref:`envoy.filters.network.ext_authz <config_network_filters_ext_authz_dynamic_metadata>` for network filter.
	dynamic_metadata?: _struct.#Struct
}

// AuthorizationClient is the client API for Authorization service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#AuthorizationClient: _

// AuthorizationServer is the server API for Authorization service.
#AuthorizationServer: _

// UnimplementedAuthorizationServer can be embedded to have forward compatible implementations.
#UnimplementedAuthorizationServer: {
	"@type": "type.googleapis.com/envoy.service.auth.v3.UnimplementedAuthorizationServer"
}
