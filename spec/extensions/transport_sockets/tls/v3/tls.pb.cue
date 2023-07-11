package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#DownstreamTlsContext_OcspStaplePolicy: "LENIENT_STAPLING" | "STRICT_STAPLING" | "MUST_STAPLE"

DownstreamTlsContext_OcspStaplePolicy_LENIENT_STAPLING: "LENIENT_STAPLING"
DownstreamTlsContext_OcspStaplePolicy_STRICT_STAPLING:  "STRICT_STAPLING"
DownstreamTlsContext_OcspStaplePolicy_MUST_STAPLE:      "MUST_STAPLE"

#UpstreamTlsContext: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.UpstreamTlsContext"
	// Common TLS context settings.
	//
	// .. attention::
	//
	//   Server certificate verification is not enabled by default. Configure
	//   :ref:`trusted_ca<envoy_v3_api_field_extensions.transport_sockets.tls.v3.CertificateValidationContext.trusted_ca>` to enable
	//   verification.
	common_tls_context?: #CommonTlsContext
	// SNI string to use when creating TLS backend connections.
	sni?: string
	// If true, server-initiated TLS renegotiation will be allowed.
	//
	// .. attention::
	//
	//   TLS renegotiation is considered insecure and shouldn't be used unless absolutely necessary.
	allow_renegotiation?: bool
	// Maximum number of session keys (Pre-Shared Keys for TLSv1.3+, Session IDs and Session Tickets
	// for TLSv1.2 and older) to store for the purpose of session resumption.
	//
	// Defaults to 1, setting this to 0 disables session resumption.
	max_session_keys?: uint32
}

// [#next-free-field: 9]
#DownstreamTlsContext: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.DownstreamTlsContext"
	// Common TLS context settings.
	common_tls_context?: #CommonTlsContext
	// If specified, Envoy will reject connections without a valid client
	// certificate.
	require_client_certificate?: bool
	// If specified, Envoy will reject connections without a valid and matching SNI.
	// [#not-implemented-hide:]
	require_sni?: bool
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
	// If specified, ``session_timeout`` will change the maximum lifetime (in seconds) of the TLS session.
	// Currently this value is used as a hint for the `TLS session ticket lifetime (for TLSv1.2) <https://tools.ietf.org/html/rfc5077#section-5.6>`_.
	// Only seconds can be specified (fractional seconds are ignored).
	session_timeout?: string
	// Config for whether to use certificates if they do not have
	// an accompanying OCSP response or if the response expires at runtime.
	// Defaults to LENIENT_STAPLING
	ocsp_staple_policy?: #DownstreamTlsContext_OcspStaplePolicy
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
// [#next-free-field: 16]
#CommonTlsContext: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.CommonTlsContext"
	// TLS protocol versions, cipher suites etc.
	tls_params?: #TlsParameters
	// :ref:`Multiple TLS certificates <arch_overview_ssl_cert_select>` can be associated with the
	// same context to allow both RSA and ECDSA certificates.
	//
	// Only a single TLS certificate is supported in client contexts. In server contexts, the first
	// RSA certificate is used for clients that only support RSA and the first ECDSA certificate is
	// used for clients that support ECDSA.
	//
	// Only one of ``tls_certificates``, ``tls_certificate_sds_secret_configs``,
	// and ``tls_certificate_provider_instance`` may be used.
	// [#next-major-version: These mutually exclusive fields should ideally be in a oneof, but it's
	// not legal to put a repeated field in a oneof. In the next major version, we should rework
	// this to avoid this problem.]
	tls_certificates?: [...#TlsCertificate]
	// Configs for fetching TLS certificates via SDS API. Note SDS API allows certificates to be
	// fetched/refreshed over the network asynchronously with respect to the TLS handshake.
	//
	// The same number and types of certificates as :ref:`tls_certificates <envoy_v3_api_field_extensions.transport_sockets.tls.v3.CommonTlsContext.tls_certificates>`
	// are valid in the the certificates fetched through this setting.
	//
	// Only one of ``tls_certificates``, ``tls_certificate_sds_secret_configs``,
	// and ``tls_certificate_provider_instance`` may be used.
	// [#next-major-version: These mutually exclusive fields should ideally be in a oneof, but it's
	// not legal to put a repeated field in a oneof. In the next major version, we should rework
	// this to avoid this problem.]
	tls_certificate_sds_secret_configs?: [...#SdsSecretConfig]
	// Certificate provider instance for fetching TLS certs.
	//
	// Only one of ``tls_certificates``, ``tls_certificate_sds_secret_configs``,
	// and ``tls_certificate_provider_instance`` may be used.
	// [#not-implemented-hide:]
	tls_certificate_provider_instance?: #CertificateProviderPluginInstance
	// Certificate provider for fetching TLS certificates.
	// [#not-implemented-hide:]
	//
	// Deprecated: Do not use.
	tls_certificate_certificate_provider?: #CommonTlsContext_CertificateProvider
	// Certificate provider instance for fetching TLS certificates.
	// [#not-implemented-hide:]
	//
	// Deprecated: Do not use.
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
	// Deprecated: Do not use.
	validation_context_certificate_provider?: #CommonTlsContext_CertificateProvider
	// Certificate provider instance for fetching validation context.
	// [#not-implemented-hide:]
	//
	// Deprecated: Do not use.
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
	// ``default_validation_context.trusted_ca`` field.
	// [#not-implemented-hide:]
	//
	// Deprecated: Do not use.
	validation_context_certificate_provider?: #CommonTlsContext_CertificateProvider
	// Certificate provider instance for fetching CA certs. This will populate the
	// ``default_validation_context.trusted_ca`` field.
	// [#not-implemented-hide:]
	//
	// Deprecated: Do not use.
	validation_context_certificate_provider_instance?: #CommonTlsContext_CertificateProviderInstance
}
