package v2

import (
	core "envoyproxy.io/api/v2/core"
)

// HTTP version
#HTTPAccessLogEntry_HTTPVersion: "PROTOCOL_UNSPECIFIED" | "HTTP10" | "HTTP11" | "HTTP2" | "HTTP3"

HTTPAccessLogEntry_HTTPVersion_PROTOCOL_UNSPECIFIED: "PROTOCOL_UNSPECIFIED"
HTTPAccessLogEntry_HTTPVersion_HTTP10:               "HTTP10"
HTTPAccessLogEntry_HTTPVersion_HTTP11:               "HTTP11"
HTTPAccessLogEntry_HTTPVersion_HTTP2:                "HTTP2"
HTTPAccessLogEntry_HTTPVersion_HTTP3:                "HTTP3"

// Reasons why the request was unauthorized
#ResponseFlags_Unauthorized_Reason: "REASON_UNSPECIFIED" | "EXTERNAL_SERVICE"

ResponseFlags_Unauthorized_Reason_REASON_UNSPECIFIED: "REASON_UNSPECIFIED"
ResponseFlags_Unauthorized_Reason_EXTERNAL_SERVICE:   "EXTERNAL_SERVICE"

#TLSProperties_TLSVersion: "VERSION_UNSPECIFIED" | "TLSv1" | "TLSv1_1" | "TLSv1_2" | "TLSv1_3"

TLSProperties_TLSVersion_VERSION_UNSPECIFIED: "VERSION_UNSPECIFIED"
TLSProperties_TLSVersion_TLSv1:               "TLSv1"
TLSProperties_TLSVersion_TLSv1_1:             "TLSv1_1"
TLSProperties_TLSVersion_TLSv1_2:             "TLSv1_2"
TLSProperties_TLSVersion_TLSv1_3:             "TLSv1_3"

#TCPAccessLogEntry: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.TCPAccessLogEntry"
	// Common properties shared by all Envoy access logs.
	common_properties?: #AccessLogCommon
	// Properties of the TCP connection.
	connection_properties?: #ConnectionProperties
}

#HTTPAccessLogEntry: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.HTTPAccessLogEntry"
	// Common properties shared by all Envoy access logs.
	common_properties?: #AccessLogCommon
	protocol_version?:  #HTTPAccessLogEntry_HTTPVersion
	// Description of the incoming HTTP request.
	request?: #HTTPRequestProperties
	// Description of the outgoing HTTP response.
	response?: #HTTPResponseProperties
}

// Defines fields for a connection
#ConnectionProperties: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.ConnectionProperties"
	// Number of bytes received from downstream.
	received_bytes?: uint64
	// Number of bytes sent to downstream.
	sent_bytes?: uint64
}

// Defines fields that are shared by all Envoy access logs.
// [#next-free-field: 22]
#AccessLogCommon: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.AccessLogCommon"
	// [#not-implemented-hide:]
	// This field indicates the rate at which this log entry was sampled.
	// Valid range is (0.0, 1.0].
	sample_rate?: float64
	// This field is the remote/origin address on which the request from the user was received.
	// Note: This may not be the physical peer. E.g, if the remote address is inferred from for
	// example the x-forwarder-for header, proxy protocol, etc.
	downstream_remote_address?: core.#Address
	// This field is the local/destination address on which the request from the user was received.
	downstream_local_address?: core.#Address
	// If the connection is secure,S this field will contain TLS properties.
	tls_properties?: #TLSProperties
	// The time that Envoy started servicing this request. This is effectively the time that the first
	// downstream byte is received.
	start_time?: string
	// Interval between the first downstream byte received and the last
	// downstream byte received (i.e. time it takes to receive a request).
	time_to_last_rx_byte?: string
	// Interval between the first downstream byte received and the first upstream byte sent. There may
	// by considerable delta between *time_to_last_rx_byte* and this value due to filters.
	// Additionally, the same caveats apply as documented in *time_to_last_downstream_tx_byte* about
	// not accounting for kernel socket buffer time, etc.
	time_to_first_upstream_tx_byte?: string
	// Interval between the first downstream byte received and the last upstream byte sent. There may
	// by considerable delta between *time_to_last_rx_byte* and this value due to filters.
	// Additionally, the same caveats apply as documented in *time_to_last_downstream_tx_byte* about
	// not accounting for kernel socket buffer time, etc.
	time_to_last_upstream_tx_byte?: string
	// Interval between the first downstream byte received and the first upstream
	// byte received (i.e. time it takes to start receiving a response).
	time_to_first_upstream_rx_byte?: string
	// Interval between the first downstream byte received and the last upstream
	// byte received (i.e. time it takes to receive a complete response).
	time_to_last_upstream_rx_byte?: string
	// Interval between the first downstream byte received and the first downstream byte sent.
	// There may be a considerable delta between the *time_to_first_upstream_rx_byte* and this field
	// due to filters. Additionally, the same caveats apply as documented in
	// *time_to_last_downstream_tx_byte* about not accounting for kernel socket buffer time, etc.
	time_to_first_downstream_tx_byte?: string
	// Interval between the first downstream byte received and the last downstream byte sent.
	// Depending on protocol, buffering, windowing, filters, etc. there may be a considerable delta
	// between *time_to_last_upstream_rx_byte* and this field. Note also that this is an approximate
	// time. In the current implementation it does not include kernel socket buffer time. In the
	// current implementation it also does not include send window buffering inside the HTTP/2 codec.
	// In the future it is likely that work will be done to make this duration more accurate.
	time_to_last_downstream_tx_byte?: string
	// The upstream remote/destination address that handles this exchange. This does not include
	// retries.
	upstream_remote_address?: core.#Address
	// The upstream local/origin address that handles this exchange. This does not include retries.
	upstream_local_address?: core.#Address
	// The upstream cluster that *upstream_remote_address* belongs to.
	upstream_cluster?: string
	// Flags indicating occurrences during request/response processing.
	response_flags?: #ResponseFlags
	// All metadata encountered during request processing, including endpoint
	// selection.
	//
	// This can be used to associate IDs attached to the various configurations
	// used to process this request with the access log entry. For example, a
	// route created from a higher level forwarding rule with some ID can place
	// that ID in this field and cross reference later. It can also be used to
	// determine if a canary endpoint was used or not.
	metadata?: core.#Metadata
	// If upstream connection failed due to transport socket (e.g. TLS handshake), provides the
	// failure reason from the transport socket. The format of this field depends on the configured
	// upstream transport socket. Common TLS failures are in
	// :ref:`TLS trouble shooting <arch_overview_ssl_trouble_shooting>`.
	upstream_transport_failure_reason?: string
	// The name of the route
	route_name?: string
	// This field is the downstream direct remote address on which the request from the user was
	// received. Note: This is always the physical peer, even if the remote address is inferred from
	// for example the x-forwarder-for header, proxy protocol, etc.
	downstream_direct_remote_address?: core.#Address
	// Map of filter state in stream info that have been configured to be logged. If the filter
	// state serialized to any message other than `google.protobuf.Any` it will be packed into
	// `google.protobuf.Any`.
	filter_state_objects?: [string]: _
}

// Flags indicating occurrences during request/response processing.
// [#next-free-field: 20]
#ResponseFlags: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.ResponseFlags"
	// Indicates local server healthcheck failed.
	failed_local_healthcheck?: bool
	// Indicates there was no healthy upstream.
	no_healthy_upstream?: bool
	// Indicates an there was an upstream request timeout.
	upstream_request_timeout?: bool
	// Indicates local codec level reset was sent on the stream.
	local_reset?: bool
	// Indicates remote codec level reset was received on the stream.
	upstream_remote_reset?: bool
	// Indicates there was a local reset by a connection pool due to an initial connection failure.
	upstream_connection_failure?: bool
	// Indicates the stream was reset due to an upstream connection termination.
	upstream_connection_termination?: bool
	// Indicates the stream was reset because of a resource overflow.
	upstream_overflow?: bool
	// Indicates no route was found for the request.
	no_route_found?: bool
	// Indicates that the request was delayed before proxying.
	delay_injected?: bool
	// Indicates that the request was aborted with an injected error code.
	fault_injected?: bool
	// Indicates that the request was rate-limited locally.
	rate_limited?: bool
	// Indicates if the request was deemed unauthorized and the reason for it.
	unauthorized_details?: #ResponseFlags_Unauthorized
	// Indicates that the request was rejected because there was an error in rate limit service.
	rate_limit_service_error?: bool
	// Indicates the stream was reset due to a downstream connection termination.
	downstream_connection_termination?: bool
	// Indicates that the upstream retry limit was exceeded, resulting in a downstream error.
	upstream_retry_limit_exceeded?: bool
	// Indicates that the stream idle timeout was hit, resulting in a downstream 408.
	stream_idle_timeout?: bool
	// Indicates that the request was rejected because an envoy request header failed strict
	// validation.
	invalid_envoy_request_headers?: bool
	// Indicates there was an HTTP protocol error on the downstream request.
	downstream_protocol_error?: bool
}

// Properties of a negotiated TLS connection.
// [#next-free-field: 7]
#TLSProperties: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.TLSProperties"
	// Version of TLS that was negotiated.
	tls_version?: #TLSProperties_TLSVersion
	// TLS cipher suite negotiated during handshake. The value is a
	// four-digit hex code defined by the IANA TLS Cipher Suite Registry
	// (e.g. ``009C`` for ``TLS_RSA_WITH_AES_128_GCM_SHA256``).
	//
	// Here it is expressed as an integer.
	tls_cipher_suite?: uint32
	// SNI hostname from handshake.
	tls_sni_hostname?: string
	// Properties of the local certificate used to negotiate TLS.
	local_certificate_properties?: #TLSProperties_CertificateProperties
	// Properties of the peer certificate used to negotiate TLS.
	peer_certificate_properties?: #TLSProperties_CertificateProperties
	// The TLS session ID.
	tls_session_id?: string
}

// [#next-free-field: 14]
#HTTPRequestProperties: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.HTTPRequestProperties"
	// The request method (RFC 7231/2616).
	request_method?: core.#RequestMethod
	// The scheme portion of the incoming request URI.
	scheme?: string
	// HTTP/2 ``:authority`` or HTTP/1.1 ``Host`` header value.
	authority?: string
	// The port of the incoming request URI
	// (unused currently, as port is composed onto authority).
	port?: uint32
	// The path portion from the incoming request URI.
	path?: string
	// Value of the ``User-Agent`` request header.
	user_agent?: string
	// Value of the ``Referer`` request header.
	referer?: string
	// Value of the ``X-Forwarded-For`` request header.
	forwarded_for?: string
	// Value of the ``X-Request-Id`` request header
	//
	// This header is used by Envoy to uniquely identify a request.
	// It will be generated for all external requests and internal requests that
	// do not already have a request ID.
	request_id?: string
	// Value of the ``X-Envoy-Original-Path`` request header.
	original_path?: string
	// Size of the HTTP request headers in bytes.
	//
	// This value is captured from the OSI layer 7 perspective, i.e. it does not
	// include overhead from framing or encoding at other networking layers.
	request_headers_bytes?: uint64
	// Size of the HTTP request body in bytes.
	//
	// This value is captured from the OSI layer 7 perspective, i.e. it does not
	// include overhead from framing or encoding at other networking layers.
	request_body_bytes?: uint64
	// Map of additional headers that have been configured to be logged.
	request_headers?: [string]: string
}

// [#next-free-field: 7]
#HTTPResponseProperties: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.HTTPResponseProperties"
	// The HTTP response code returned by Envoy.
	response_code?: uint32
	// Size of the HTTP response headers in bytes.
	//
	// This value is captured from the OSI layer 7 perspective, i.e. it does not
	// include overhead from framing or encoding at other networking layers.
	response_headers_bytes?: uint64
	// Size of the HTTP response body in bytes.
	//
	// This value is captured from the OSI layer 7 perspective, i.e. it does not
	// include overhead from framing or encoding at other networking layers.
	response_body_bytes?: uint64
	// Map of additional headers configured to be logged.
	response_headers?: [string]: string
	// Map of trailers configured to be logged.
	response_trailers?: [string]: string
	// The HTTP response code details.
	response_code_details?: string
}

#ResponseFlags_Unauthorized: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.ResponseFlags_Unauthorized"
	reason?: #ResponseFlags_Unauthorized_Reason
}

#TLSProperties_CertificateProperties: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.TLSProperties_CertificateProperties"
	// SANs present in the certificate.
	subject_alt_name?: [...#TLSProperties_CertificateProperties_SubjectAltName]
	// The subject field of the certificate.
	subject?: string
}

#TLSProperties_CertificateProperties_SubjectAltName: {
	"@type": "type.googleapis.com/envoy.data.accesslog.v2.TLSProperties_CertificateProperties_SubjectAltName"
	uri?:    string
	// [#not-implemented-hide:]
	dns?: string
}
