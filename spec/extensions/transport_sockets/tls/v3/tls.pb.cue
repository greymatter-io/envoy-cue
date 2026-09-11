package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#DownstreamTlsContext_OcspStaplePolicy: "LENIENT_STAPLING" | "STRICT_STAPLING" | "MUST_STAPLE"

DownstreamTlsContext_OcspStaplePolicy_LENIENT_STAPLING: "LENIENT_STAPLING"
DownstreamTlsContext_OcspStaplePolicy_STRICT_STAPLING:  "STRICT_STAPLING"
DownstreamTlsContext_OcspStaplePolicy_MUST_STAPLE:      "MUST_STAPLE"

// [#next-free-field: 8]
#UpstreamTlsContext: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.UpstreamTlsContext"
	// Common TLS context settings.
	//
	// .. attention::
	//
	//	Server certificate verification is not enabled by default. To enable verification, configure
	//	:ref:`trusted_ca<envoy_v3_api_field_extensions.transport_sockets.tls.v3.CertificateValidationContext.trusted_ca>`.
	common_tls_context?: #CommonTlsContext
	// SNI string to use when creating TLS backend connections.
	sni?: string
	// If true, replaces the SNI for the connection with the hostname of the upstream host, if
	// the hostname is known due to either a DNS cluster type or the
	// :ref:`hostname <envoy_v3_api_field_config.endpoint.v3.Endpoint.hostname>` is set on
	// the host.
	//
	// See :ref:`SNI configuration <start_quick_start_securing_sni_client>` for details on how this
	// interacts with other validation options.
	auto_host_sni?: bool
	// If true, replaces any Subject Alternative Name (SAN) validations with a validation for a DNS SAN matching
	// the SNI value sent. The validation uses the actual requested SNI, regardless of how the SNI is configured.
	//
	// For common cases where an SNI value is present and the server certificate should include a corresponding SAN,
	// this option ensures the SAN is properly validated.
	//
	// See the :ref:`validation configuration <start_quick_start_securing_validation>` for how this interacts with
	// other validation options.
	auto_sni_san_validation?: bool
	// If true, server-initiated TLS renegotiation will be allowed.
	//
	// .. attention::
	//
	//	TLS renegotiation is considered insecure and shouldn't be used unless absolutely necessary.
	allow_renegotiation?: bool
	// Maximum number of session keys (Pre-Shared Keys for TLSv1.3+, Session IDs and Session Tickets
	// for TLSv1.2 and older) to be stored for session resumption.
	//
	// Defaults to 1, setting this to 0 disables session resumption.
	max_session_keys?: uint32
	// Controls enforcement of the “keyUsage“ extension in peer certificates. If set to “true“,
	// the handshake will fail if the “keyUsage“ is incompatible with TLS usage.
	//
	// .. attention::
	//
	//	This field is deprecated and ignored. Envoy now always enforces the ``keyUsage`` extension
	//	in peer certificates, making this option unconfigurable.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/transport_sockets/tls/v3/tls.proto.
	enforce_rsa_key_usage?: bool
}

// [#next-free-field: 12]
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
	// If “true“, the TLS server will not maintain a session cache of TLS sessions.
	//
	// .. note::
	//
	//	This applies only to TLSv1.2 and earlier.
	disable_stateful_session_resumption?: bool
	// Maximum lifetime of TLS sessions. If specified, “session_timeout“ will change the maximum lifetime
	// of the TLS session.
	//
	// This serves as a hint for the `TLS session ticket lifetime (for TLSv1.2) <https://tools.ietf.org/html/rfc5077#section-5.6>`_.
	// Only whole seconds are considered; fractional seconds are ignored.
	session_timeout?: string
	// Configuration for handling certificates without an OCSP response or with expired responses.
	//
	// Defaults to “LENIENT_STAPLING“
	ocsp_staple_policy?: #DownstreamTlsContext_OcspStaplePolicy
	// Multiple certificates are allowed in Downstream transport socket to serve different SNI.
	// This option controls the behavior when no matching certificate is found for the received SNI value,
	// or no SNI value was sent. If enabled, all certificates will be evaluated for a match for non-SNI criteria
	// such as key type and OCSP settings. If disabled, the first provided certificate will be used.
	// Defaults to “false“. See more details in :ref:`Multiple TLS certificates <arch_overview_ssl_cert_select>`.
	full_scan_certs_on_sni_mismatch?: bool
	// If “true“, the downstream client's preferred cipher is used during the handshake. If “false“, Envoy
	// uses its preferred cipher.
	//
	// .. note::
	//
	//	This has no effect when using TLSv1_3.
	prefer_client_ciphers?: bool
}

// TLS key log configuration.
// The key log file format is "format used by NSS for its SSLKEYLOGFILE debugging output" (text taken from openssl man page)
#TlsKeyLog: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.TlsKeyLog"
	// Path to save the TLS key log.
	path?: string
	// Local IP address ranges to filter connections for TLS key logging. If not set, matches any local IP address.
	local_address_range?: [...v3.#CidrRange]
	// Remote IP address ranges to filter connections for TLS key logging. If not set, matches any remote IP address.
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
	// are valid in the certificates fetched through this setting.
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
	// For the downstream TLS socket, select a TLS certificate based on TLS client hello. If empty,
	// defaults to native TLS certificate selection behavior: DNS SANs or Subject Common Name in TLS
	// certificates is extracted as server name pattern to match SNI.
	//
	// For the upstream TLS socket, select a TLS certificate based on TLS server hello and the
	// transport socket options.
	// [#extension-category: envoy.tls.certificate_selectors,envoy.tls.upstream_certificate_selectors]
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
	// Combines the default “CertificateValidationContext“ with the SDS-provided dynamic context for certificate
	// validation.
	//
	// When the SDS server returns a dynamic “CertificateValidationContext“, it is merged
	// with the default context using “Message::MergeFrom()“. The merging rules are as follows:
	//
	// * **Singular Fields:** Dynamic fields override the default singular fields.
	// * **Repeated Fields:** Dynamic repeated fields are concatenated with the default repeated fields.
	// * **Boolean Fields:** Boolean fields are combined using a logical OR operation.
	//
	// The resulting “CertificateValidationContext“ is used to perform certificate validation.
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

// Config for the Certificate Provider to fetch certificates. Certificates are fetched/refreshed asynchronously over
// the network relative to the TLS handshake.
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
