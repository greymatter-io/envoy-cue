package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
)

// External Authorization filter calls out to an external service over the
// gRPC Authorization API defined by
// :ref:`CheckRequest <envoy_v3_api_msg_service.auth.v3.CheckRequest>`.
// A failed check will cause this filter to close the TCP connection.
// [#next-free-field: 12]
#ExtAuthz: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.ext_authz.v3.ExtAuthz"
	// The prefix to use when emitting statistics.
	stat_prefix?: string
	// The external authorization gRPC service configuration.
	// The default timeout is set to 200ms by this filter.
	grpc_service?: v3.#GrpcService
	// The filter's behaviour in case the external authorization service does
	// not respond back. When it is set to true, Envoy will also allow traffic in case of
	// communication failure between authorization service and the proxy.
	// Defaults to false.
	failure_mode_allow?: bool
	// Specifies if the peer certificate is sent to the external service.
	//
	// When this field is true, Envoy will include the peer X.509 certificate, if available, in the
	// :ref:`certificate<envoy_v3_api_field_service.auth.v3.AttributeContext.Peer.certificate>`.
	include_peer_certificate?: bool
	// API version for ext_authz transport protocol. This describes the ext_authz gRPC endpoint and
	// version of Check{Request,Response} used on the wire.
	transport_api_version?: v3.#ApiVersion
	// Specifies if the filter is enabled with metadata matcher.
	// If this field is not specified, the filter will be enabled for all requests.
	filter_enabled_metadata?: v31.#MetadataMatcher
	// Optional labels that will be passed to :ref:`labels<envoy_v3_api_field_service.auth.v3.AttributeContext.Peer.labels>` in
	// :ref:`destination<envoy_v3_api_field_service.auth.v3.AttributeContext.destination>`.
	// The labels will be read from :ref:`metadata<envoy_v3_api_msg_config.core.v3.Node>` with the specified key.
	bootstrap_metadata_labels_key?: string
	// Specifies if the TLS session level details like SNI are sent to the external service.
	//
	// When this field is true, Envoy will include the SNI name used for TLSClientHello, if available, in the
	// :ref:`tls_session<envoy_v3_api_field_service.auth.v3.AttributeContext.tls_session>`.
	include_tls_session?: bool
	// When set to “true“, the filter will send a TLS “access_denied(49)“ alert before closing
	// the connection when authorization is denied. This provides better visibility to TLS clients
	// about the reason for connection closure. This alert is only sent for TLS connections. The
	// non-TLS connections will be closed without sending an alert.
	//
	// Defaults to “false“.
	send_tls_alert_on_denial?: bool
	// Specifies a list of metadata namespaces whose values, if present, will be passed to the
	// ext_authz service. The :ref:`filter_metadata <envoy_v3_api_field_config.core.v3.Metadata.filter_metadata>`
	// is passed as an opaque “protobuf::Struct“.
	//
	// For example, if the “proxy_protocol“ listener filter is used and populates TLV metadata,
	// then the following will pass that metadata to the authorization server for making decisions
	// based on proxy protocol information.
	//
	// .. code-block:: yaml
	//
	//	metadata_context_namespaces:
	//	- envoy.filters.listener.proxy_protocol
	metadata_context_namespaces?: [...string]
	// Specifies a list of metadata namespaces whose values, if present, will be passed to the
	// ext_authz service. :ref:`typed_filter_metadata <envoy_v3_api_field_config.core.v3.Metadata.typed_filter_metadata>`
	// is passed as a “protobuf::Any“.
	//
	// This works similarly to “metadata_context_namespaces“ but allows Envoy and the ext_authz server to share
	// the protobuf message definition in order to perform safe parsing.
	typed_metadata_context_namespaces?: [...string]
}
