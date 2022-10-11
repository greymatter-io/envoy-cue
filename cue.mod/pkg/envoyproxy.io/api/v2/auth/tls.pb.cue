package auth

#UpstreamTlsContext: {
	"@type": "type.googleapis.com/envoy.api.v2.auth.UpstreamTlsContext"
	// Common TLS context settings.
	//
	// .. attention::
	//
	//   Server certificate verification is not enabled by default. Configure
	//   :ref:`trusted_ca<envoy_api_field_auth.CertificateValidationContext.trusted_ca>` to enable
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

// [#next-free-field: 8]
#DownstreamTlsContext: {
	"@type": "type.googleapis.com/envoy.api.v2.auth.DownstreamTlsContext"
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
	// the keys specified through either :ref:`session_ticket_keys <envoy_api_field_auth.DownstreamTlsContext.session_ticket_keys>`
	// or :ref:`session_ticket_keys_sds_secret_config <envoy_api_field_auth.DownstreamTlsContext.session_ticket_keys_sds_secret_config>`.
	// If this config is set to false and no keys are explicitly configured, the TLS server will issue
	// TLS session tickets and encrypt/decrypt them using an internally-generated and managed key, with the
	// implication that sessions cannot be resumed across hot restarts or on different hosts.
	disable_stateless_session_resumption?: bool
	// If specified, ``session_timeout`` will change the maximum lifetime (in seconds) of the TLS session.
	// Currently this value is used as a hint for the `TLS session ticket lifetime (for TLSv1.2) <https://tools.ietf.org/html/rfc5077#section-5.6>`_.
	// Only seconds can be specified (fractional seconds are ignored).
	session_timeout?: string
}

// TLS context shared by both client and server TLS contexts.
// [#next-free-field: 9]
#CommonTlsContext: {
	"@type": "type.googleapis.com/envoy.api.v2.auth.CommonTlsContext"
	// TLS protocol versions, cipher suites etc.
	tls_params?: #TlsParameters
	// :ref:`Multiple TLS certificates <arch_overview_ssl_cert_select>` can be associated with the
	// same context to allow both RSA and ECDSA certificates.
	//
	// Only a single TLS certificate is supported in client contexts. In server contexts, the first
	// RSA certificate is used for clients that only support RSA and the first ECDSA certificate is
	// used for clients that support ECDSA.
	tls_certificates?: [...#TlsCertificate]
	// Configs for fetching TLS certificates via SDS API.
	tls_certificate_sds_secret_configs?: [...#SdsSecretConfig]
	// How to validate peer certificates.
	validation_context?: #CertificateValidationContext
	// Config for fetching validation context via SDS API.
	validation_context_sds_secret_config?: #SdsSecretConfig
	// Combined certificate validation context holds a default CertificateValidationContext
	// and SDS config. When SDS server returns dynamic CertificateValidationContext, both dynamic
	// and default CertificateValidationContext are merged into a new CertificateValidationContext
	// for validation. This merge is done by Message::MergeFrom(), so dynamic
	// CertificateValidationContext overwrites singular fields in default
	// CertificateValidationContext, and concatenates repeated fields to default
	// CertificateValidationContext, and logical OR is applied to boolean fields.
	combined_validation_context?: #CommonTlsContext_CombinedCertificateValidationContext
	// Supplies the list of ALPN protocols that the listener should expose. In
	// practice this is likely to be set to one of two values (see the
	// :ref:`codec_type
	// <envoy_api_field_config.filter.network.http_connection_manager.v2.HttpConnectionManager.codec_type>`
	// parameter in the HTTP connection manager for more information):
	//
	// * "h2,http/1.1" If the listener is going to support both HTTP/2 and HTTP/1.1.
	// * "http/1.1" If the listener is only going to support HTTP/1.1.
	//
	// There is no default for this parameter. If empty, Envoy will not expose ALPN.
	alpn_protocols?: [...string]
}

#CommonTlsContext_CombinedCertificateValidationContext: {
	"@type": "type.googleapis.com/envoy.api.v2.auth.CommonTlsContext_CombinedCertificateValidationContext"
	// How to validate peer certificates.
	default_validation_context?: #CertificateValidationContext
	// Config for fetching validation context via SDS API.
	validation_context_sds_secret_config?: #SdsSecretConfig
}
