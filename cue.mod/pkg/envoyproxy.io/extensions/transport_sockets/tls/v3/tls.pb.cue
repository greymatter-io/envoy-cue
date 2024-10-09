package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	v3 "envoyproxy.io/config/core/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

#DownstreamTlsContext_OcspStaplePolicy: "LENIENT_STAPLING" | "STRICT_STAPLING" | "MUST_STAPLE"

DownstreamTlsContext_OcspStaplePolicy_LENIENT_STAPLING: "LENIENT_STAPLING"
DownstreamTlsContext_OcspStaplePolicy_STRICT_STAPLING:  "STRICT_STAPLING"
DownstreamTlsContext_OcspStaplePolicy_MUST_STAPLE:      "MUST_STAPLE"

// [#next-free-field: 6]
#UpstreamTlsContext: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.UpstreamTlsContext"
	// Common TLS context settings.
	//
	// .. attention::
	//
	//	Server certificate verification is not enabled by default. Configure
	//	:ref:`trusted_ca<envoy_v3_api_field_extensions.transport_sockets.tls.v3.CertificateValidationContext.trusted_ca>` to enable
	//	verification.
	common_tls_context?: #CommonTlsContext
	// SNI string to use when creating TLS backend connections.
	sni?: string
	// If true, server-initiated TLS renegotiation will be allowed.
	//
	// .. attention::
	//
	//	TLS renegotiation is considered insecure and shouldn't be used unless absolutely necessary.
	allow_renegotiation?: bool
	// Maximum number of session keys (Pre-Shared Keys for TLSv1.3+, Session IDs and Session Tickets
	// for TLSv1.2 and older) to store for the purpose of session resumption.
	//
	// Defaults to 1, setting this to 0 disables session resumption.
	max_session_keys?: wrapperspb.#UInt32Value
	// This field is used to control the enforcement, whereby the handshake will fail if the keyUsage extension
	// is present and incompatible with the TLS usage. Currently, the default value is false (i.e., enforcement off)
	// but it is expected to be changed to true by default in a future release.
	// “ssl.was_key_usage_invalid“ in :ref:`listener metrics <config_listener_stats>` will be set for certificate
	// configurations that would fail if this option were set to true.
	enforce_rsa_key_usage?: wrapperspb.#BoolValue
}

// [#next-free-field: 12]
#DownstreamTlsContext: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.DownstreamTlsContext"
	// Common TLS context settings.
	common_tls_context?: #CommonTlsContext
	// If specified, Envoy will reject connections without a valid client
	// certificate.
	require_client_certificate?: wrapperspb.#BoolValue
	// If specified, Envoy will reject connections without a valid and matching SNI.
	// [#not-implemented-hide:]
	require_sni?: wrapperspb.#BoolValue
	// TLS session ticket key settings.
	session_ticket_keys?: #TlsSessionTicketKeys
	// Config for fetching TLS session ticket keys via SDS API.
	session_ticket_keys_sds_secret_config?: #SdsSecretConfig
	// Config for controlling stateless TLS session resumption: setting this to true will cause the TLS
	// server to not issue TLS session tickets for the purposes of stateless TLS session resumption.
	// If set to false, the TLS server will issue TLS session tickets and encrypt/decrypt them using
	// the keys specified through either :ref:`session_ticket_keys <envoy_v3_api_field_extensions.transport_sockets.tls.v3.DownstreamTlsContext.session_ticket_keys>`
	// or :ref:`session_ticket_keys_sds_secret_config <envoy_v3_api_field_extensions.transport_sockets.tls.v3.DownstreamTlsContext.session_ticket_keys_sds_secret_config>`.
	// If this config is set to false and no keys are explicitly configured, the TLS server will issue
	// TLS session tickets and encrypt/decrypt them using an internally-generated and managed key, with the
	// implication that sessions cannot be resumed across hot restarts or on different hosts.
	disable_stateless_session_resumption?: bool
	// If set to true, the TLS server will not maintain a session cache of TLS sessions. (This is
	// relevant only for TLSv1.2 and earlier.)
	disable_stateful_session_resumption?: bool
	// If specified, “session_timeout“ will change the maximum lifetime (in seconds) of the TLS session.
	// Currently this value is used as a hint for the `TLS session ticket lifetime (for TLSv1.2) <https://tools.ietf.org/html/rfc5077#section-5.6>`_.
	// Only seconds can be specified (fractional seconds are ignored).
	session_timeout?: durationpb.#Duration
	// Config for whether to use certificates if they do not have
	// an accompanying OCSP response or if the response expires at runtime.
	// Defaults to LENIENT_STAPLING
	ocsp_staple_policy?: #DownstreamTlsContext_OcspStaplePolicy
	// Multiple certificates are allowed in Downstream transport socket to serve different SNI.
	// If the client provides SNI but no such cert matched, it will decide to full scan certificates or not based on this config.
	// Defaults to false. See more details in :ref:`Multiple TLS certificates <arch_overview_ssl_cert_select>`.
	full_scan_certs_on_sni_mismatch?: wrapperspb.#BoolValue
	// By default, Envoy as a server uses its preferred cipher during the handshake.
	// Setting this to true would allow the downstream client's preferred cipher to be used instead.
	// Has no effect when using TLSv1_3.
	prefer_client_ciphers?: bool
}

// TLS key log configuration.
// The key log file format is "format used by NSS for its SSLKEYLOGFILE debugging output" (text taken from openssl man page)
#TlsKeyLog: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.TlsKeyLog"
	// The path to save the TLS key log.
	path?: string
	// The local IP address that will be used to filter the connection which should save the TLS key log
	// If it is not set, any local IP address  will be matched.
	local_address_range?: [...v3.#CidrRange]
	// The remote IP address that will be used to filter the connection which should save the TLS key log
	// If it is not set, any remote IP address will be matched.
	remote_address_range?: [...v3.#CidrRange]
}

// TLS context shared by both client and server TLS contexts.
// [#next-free-field: 17]
#CommonTlsContext: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.CommonTlsContext"
	// TLS protocol versions, cipher suites etc.
	tls_params?: #TlsParameters
	// Only a single TLS certificate is supported in client contexts. In server contexts,
	// :ref:`Multiple TLS certificates <arch_overview_ssl_cert_select>` can be associated with the
	// same context to allow both RSA and ECDSA certificates and support SNI-based selection.
	//
	// If “tls_certificate_provider_instance“ is set, this field is ignored.
	// If this field is set, “tls_certificate_sds_secret_configs“ is ignored.
	tls_certificates?: [...#TlsCertificate]
	// Configs for fetching TLS certificates via SDS API. Note SDS API allows certificates to be
	// fetched/refreshed over the network asynchronously with respect to the TLS handshake.
	//
	// The same number and types of certificates as :ref:`tls_certificates <envoy_v3_api_field_extensions.transport_sockets.tls.v3.CommonTlsContext.tls_certificates>`
	// are valid in the the certificates fetched through this setting.
	//
	// If “tls_certificates“ or “tls_certificate_provider_instance“ are set, this field
	// is ignored.
	tls_certificate_sds_secret_configs?: [...#SdsSecretConfig]
	// Certificate provider instance for fetching TLS certs.
	//
	// If this field is set, “tls_certificates“ and “tls_certificate_provider_instance“
	// are ignored.
	// [#not-implemented-hide:]
	tls_certificate_provider_instance?: #CertificateProviderPluginInstance
	// Custom TLS certificate selector.
	//
	// Select TLS certificate based on TLS client hello.
	// If empty, defaults to native TLS certificate selection behavior:
	// DNS SANs or Subject Common Name in TLS certificates is extracted as server name pattern to match SNI.
	custom_tls_certificate_selector?: v3.#TypedExtensionConfig
	// Certificate provider for fetching TLS certificates.
	// [#not-implemented-hide:]
	//
	// Deprecated: Marked as deprecated in envoy/extensions/transport_sockets/tls/v3/tls.proto.
	tls_certificate_certificate_provider?: #CommonTlsContext_CertificateProvider
	// Certificate provider instance for fetching TLS certificates.
	// [#not-implemented-hide:]
	//
	// Deprecated: Marked as deprecated in envoy/extensions/transport_sockets/tls/v3/tls.proto.
	tls_certificate_certificate_provider_instance?: #CommonTlsContext_CertificateProviderInstance
	// How to validate peer certificates.
	validation_context?: #CertificateValidationContext
	// Config for fetching validation context via SDS API. Note SDS API allows certificates to be
	// fetched/refreshed over the network asynchronously with respect to the TLS handshake.
	validation_context_sds_secret_config?: #SdsSecretConfig
	// Combined certificate validation context holds a default CertificateValidationContext
	// and SDS config. When SDS server returns dynamic CertificateValidationContext, both dynamic
	// and default CertificateValidationContext are merged into a new CertificateValidationContext
	// for validation. This merge is done by Message::MergeFrom(), so dynamic
	// CertificateValidationContext overwrites singular fields in default
	// CertificateValidationContext, and concatenates repeated fields to default
	// CertificateValidationContext, and logical OR is applied to boolean fields.
	combined_validation_context?: #CommonTlsContext_CombinedCertificateValidationContext
	// Certificate provider for fetching validation context.
	// [#not-implemented-hide:]
	//
	// Deprecated: Marked as deprecated in envoy/extensions/transport_sockets/tls/v3/tls.proto.
	validation_context_certificate_provider?: #CommonTlsContext_CertificateProvider
	// Certificate provider instance for fetching validation context.
	// [#not-implemented-hide:]
	//
	// Deprecated: Marked as deprecated in envoy/extensions/transport_sockets/tls/v3/tls.proto.
	validation_context_certificate_provider_instance?: #CommonTlsContext_CertificateProviderInstance
	// Supplies the list of ALPN protocols that the listener should expose. In
	// practice this is likely to be set to one of two values (see the
	// :ref:`codec_type
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.codec_type>`
	// parameter in the HTTP connection manager for more information):
	//
	// * "h2,http/1.1" If the listener is going to support both HTTP/2 and HTTP/1.1.
	// * "http/1.1" If the listener is only going to support HTTP/1.1.
	//
	// There is no default for this parameter. If empty, Envoy will not expose ALPN.
	alpn_protocols?: [...string]
	// Custom TLS handshaker. If empty, defaults to native TLS handshaking
	// behavior.
	custom_handshaker?: v3.#TypedExtensionConfig
	// TLS key log configuration
	key_log?: #TlsKeyLog
}

// Config for Certificate provider to get certificates. This provider should allow certificates to be
// fetched/refreshed over the network asynchronously with respect to the TLS handshake.
//
// DEPRECATED: This message is not currently used, but if we ever do need it, we will want to
// move it out of CommonTlsContext and into common.proto, similar to the existing
// CertificateProviderPluginInstance message.
//
// [#not-implemented-hide:]
#CommonTlsContext_CertificateProvider: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.CommonTlsContext_CertificateProvider"
	// opaque name used to specify certificate instances or types. For example, "ROOTCA" to specify
	// a root-certificate (validation context) or "TLS" to specify a new tls-certificate.
	name?:         string
	typed_config?: v3.#TypedExtensionConfig
}

// Similar to CertificateProvider above, but allows the provider instances to be configured on
// the client side instead of being sent from the control plane.
//
// DEPRECATED: This message was moved outside of CommonTlsContext
// and now lives in common.proto.
//
// [#not-implemented-hide:]
#CommonTlsContext_CertificateProviderInstance: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.CommonTlsContext_CertificateProviderInstance"
	// Provider instance name. This name must be defined in the client's configuration (e.g., a
	// bootstrap file) to correspond to a provider instance (i.e., the same data in the typed_config
	// field that would be sent in the CertificateProvider message if the config was sent by the
	// control plane). If not present, defaults to "default".
	//
	// Instance names should generally be defined not in terms of the underlying provider
	// implementation (e.g., "file_watcher") but rather in terms of the function of the
	// certificates (e.g., "foo_deployment_identity").
	instance_name?: string
	// Opaque name used to specify certificate instances or types. For example, "ROOTCA" to specify
	// a root-certificate (validation context) or "example.com" to specify a certificate for a
	// particular domain. Not all provider instances will actually use this field, so the value
	// defaults to the empty string.
	certificate_name?: string
}

#CommonTlsContext_CombinedCertificateValidationContext: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.CommonTlsContext_CombinedCertificateValidationContext"
	// How to validate peer certificates.
	default_validation_context?: #CertificateValidationContext
	// Config for fetching validation context via SDS API. Note SDS API allows certificates to be
	// fetched/refreshed over the network asynchronously with respect to the TLS handshake.
	validation_context_sds_secret_config?: #SdsSecretConfig
	// Certificate provider for fetching CA certs. This will populate the
	// “default_validation_context.trusted_ca“ field.
	// [#not-implemented-hide:]
	//
	// Deprecated: Marked as deprecated in envoy/extensions/transport_sockets/tls/v3/tls.proto.
	validation_context_certificate_provider?: #CommonTlsContext_CertificateProvider
	// Certificate provider instance for fetching CA certs. This will populate the
	// “default_validation_context.trusted_ca“ field.
	// [#not-implemented-hide:]
	//
	// Deprecated: Marked as deprecated in envoy/extensions/transport_sockets/tls/v3/tls.proto.
	validation_context_certificate_provider_instance?: #CommonTlsContext_CertificateProviderInstance
}
