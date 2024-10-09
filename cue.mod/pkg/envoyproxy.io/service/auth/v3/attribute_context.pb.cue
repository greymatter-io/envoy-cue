package v3

import (
	timestamppb "envoyproxy.io/deps/protobuf/types/known/timestamppb"
	v3 "envoyproxy.io/config/core/v3"
)

// An attribute is a piece of metadata that describes an activity on a network.
// For example, the size of an HTTP request, or the status code of an HTTP response.
//
// Each attribute has a type and a name, which is logically defined as a proto message field
// of the “AttributeContext“. The “AttributeContext“ is a collection of individual attributes
// supported by Envoy authorization system.
// [#comment: The following items are left out of this proto
// Request.Auth field for jwt tokens
// Request.Api for api management
// Origin peer that originated the request
// Caching Protocol
// request_context return values to inject back into the filter chain
// peer.claims -- from X.509 extensions
// Configuration
// - field mask to send
// - which return values from request_context are copied back
// - which return values are copied into request_headers]
// [#next-free-field: 14]
#AttributeContext: {
	"@type": "type.googleapis.com/envoy.service.auth.v3.AttributeContext"
	// The source of a network activity, such as starting a TCP connection.
	// In a multi hop network activity, the source represents the sender of the
	// last hop.
	source?: #AttributeContext_Peer
	// The destination of a network activity, such as accepting a TCP connection.
	// In a multi hop network activity, the destination represents the receiver of
	// the last hop.
	destination?: #AttributeContext_Peer
	// Represents a network request, such as an HTTP request.
	request?: #AttributeContext_Request
	// This is analogous to http_request.headers, however these contents will not be sent to the
	// upstream server. Context_extensions provide an extension mechanism for sending additional
	// information to the auth server without modifying the proto definition. It maps to the
	// internal opaque context in the filter chain.
	context_extensions?: [string]: string
	// Dynamic metadata associated with the request.
	metadata_context?: v3.#Metadata
	// Metadata associated with the selected route.
	route_metadata_context?: v3.#Metadata
	// TLS session details of the underlying connection.
	// This is not populated by default and will be populated only if the ext_authz filter has
	// been specifically configured to include this information.
	// For HTTP ext_authz, that requires :ref:`include_tls_session <config_http_filters_ext_authz>`
	// to be set to true.
	// For network ext_authz, that requires :ref:`include_tls_session <config_network_filters_ext_authz>`
	// to be set to true.
	tls_session?: #AttributeContext_TLSSession
}

// This message defines attributes for a node that handles a network request.
// The node can be either a service or an application that sends, forwards,
// or receives the request. Service peers should fill in the “service“,
// “principal“, and “labels“ as appropriate.
// [#next-free-field: 6]
#AttributeContext_Peer: {
	"@type": "type.googleapis.com/envoy.service.auth.v3.AttributeContext_Peer"
	// The address of the peer, this is typically the IP address.
	// It can also be UDS path, or others.
	address?: v3.#Address
	// The canonical service name of the peer.
	// It should be set to :ref:`the HTTP x-envoy-downstream-service-cluster
	// <config_http_conn_man_headers_downstream-service-cluster>`
	// If a more trusted source of the service name is available through mTLS/secure naming, it
	// should be used.
	service?: string
	// The labels associated with the peer.
	// These could be pod labels for Kubernetes or tags for VMs.
	// The source of the labels could be an X.509 certificate or other configuration.
	labels?: [string]: string
	// The authenticated identity of this peer.
	// For example, the identity associated with the workload such as a service account.
	// If an X.509 certificate is used to assert the identity this field should be sourced from
	// “URI Subject Alternative Names“, “DNS Subject Alternate Names“ or “Subject“ in that order.
	// The primary identity should be the principal. The principal format is issuer specific.
	//
	// Examples:
	//
	// - SPIFFE format is “spiffe://trust-domain/path“.
	// - Google account format is “https://accounts.google.com/{userid}“.
	principal?: string
	// The X.509 certificate used to authenticate the identify of this peer.
	// When present, the certificate contents are encoded in URL and PEM format.
	certificate?: string
}

// Represents a network request, such as an HTTP request.
#AttributeContext_Request: {
	"@type": "type.googleapis.com/envoy.service.auth.v3.AttributeContext_Request"
	// The timestamp when the proxy receives the first byte of the request.
	time?: timestamppb.#Timestamp
	// Represents an HTTP request or an HTTP-like request.
	http?: #AttributeContext_HttpRequest
}

// This message defines attributes for an HTTP request.
// HTTP/1.x, HTTP/2, gRPC are all considered as HTTP requests.
// [#next-free-field: 14]
#AttributeContext_HttpRequest: {
	"@type": "type.googleapis.com/envoy.service.auth.v3.AttributeContext_HttpRequest"
	// The unique ID for a request, which can be propagated to downstream
	// systems. The ID should have low probability of collision
	// within a single day for a specific service.
	// For HTTP requests, it should be X-Request-ID or equivalent.
	id?: string
	// The HTTP request method, such as “GET“, “POST“.
	method?: string
	// The HTTP request headers. If multiple headers share the same key, they
	// must be merged according to the HTTP spec. All header keys must be
	// lower-cased, because HTTP header keys are case-insensitive.
	// Header value is encoded as UTF-8 string. Non-UTF-8 characters will be replaced by "!".
	// This field will not be set if
	// :ref:`encode_raw_headers <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.encode_raw_headers>`
	// is set to true.
	headers?: [string]: string
	// A list of the raw HTTP request headers. This is used instead of
	// :ref:`headers <envoy_v3_api_field_service.auth.v3.AttributeContext.HttpRequest.headers>` when
	// :ref:`encode_raw_headers <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.encode_raw_headers>`
	// is set to true.
	//
	// Note that this is not actually a map type. “header_map“ contains a single repeated field
	// “headers“.
	//
	// Here, only the “key“ and “raw_value“ fields will be populated for each HeaderValue, and
	// that is only when
	// :ref:`encode_raw_headers <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.ExtAuthz.encode_raw_headers>`
	// is set to true.
	//
	// Also, unlike the
	// :ref:`headers <envoy_v3_api_field_service.auth.v3.AttributeContext.HttpRequest.headers>`
	// field, headers with the same key are not combined into a single comma separated header.
	header_map?: v3.#HeaderMap
	// The request target, as it appears in the first line of the HTTP request. This includes
	// the URL path and query-string. No decoding is performed.
	path?: string
	// The HTTP request “Host“ or “:authority“ header value.
	host?: string
	// The HTTP URL scheme, such as “http“ and “https“.
	scheme?: string
	// This field is always empty, and exists for compatibility reasons. The HTTP URL query is
	// included in “path“ field.
	query?: string
	// This field is always empty, and exists for compatibility reasons. The URL fragment is
	// not submitted as part of HTTP requests; it is unknowable.
	fragment?: string
	// The HTTP request size in bytes. If unknown, it must be -1.
	size?: int64
	// The network protocol used with the request, such as "HTTP/1.0", "HTTP/1.1", or "HTTP/2".
	//
	// See :repo:`headers.h:ProtocolStrings <source/common/http/headers.h>` for a list of all
	// possible values.
	protocol?: string
	// The HTTP request body.
	body?: string
	// The HTTP request body in bytes. This is used instead of
	// :ref:`body <envoy_v3_api_field_service.auth.v3.AttributeContext.HttpRequest.body>` when
	// :ref:`pack_as_bytes <envoy_v3_api_field_extensions.filters.http.ext_authz.v3.BufferSettings.pack_as_bytes>`
	// is set to true.
	raw_body?: bytes
}

// This message defines attributes for the underlying TLS session.
#AttributeContext_TLSSession: {
	"@type": "type.googleapis.com/envoy.service.auth.v3.AttributeContext_TLSSession"
	// SNI used for TLS session.
	sni?: string
}
