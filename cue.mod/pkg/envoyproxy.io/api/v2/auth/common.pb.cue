package auth

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
	core "envoyproxy.io/api/v2/core"
	matcher "envoyproxy.io/type/matcher"
)

#TlsParameters_TlsProtocol: "TLS_AUTO" | "TLSv1_0" | "TLSv1_1" | "TLSv1_2" | "TLSv1_3"

TlsParameters_TlsProtocol_TLS_AUTO: "TLS_AUTO"
TlsParameters_TlsProtocol_TLSv1_0:  "TLSv1_0"
TlsParameters_TlsProtocol_TLSv1_1:  "TLSv1_1"
TlsParameters_TlsProtocol_TLSv1_2:  "TLSv1_2"
TlsParameters_TlsProtocol_TLSv1_3:  "TLSv1_3"

// Peer certificate verification mode.
#CertificateValidationContext_TrustChainVerification: "VERIFY_TRUST_CHAIN" | "ACCEPT_UNTRUSTED"

CertificateValidationContext_TrustChainVerification_VERIFY_TRUST_CHAIN: "VERIFY_TRUST_CHAIN"
CertificateValidationContext_TrustChainVerification_ACCEPT_UNTRUSTED:   "ACCEPT_UNTRUSTED"

#TlsParameters: {
	"@type": "type.googleapis.com/envoy.api.v2.auth.TlsParameters"
	// Minimum TLS protocol version. By default, it's ``TLSv1_2`` for both clients and servers.
	tls_minimum_protocol_version?: #TlsParameters_TlsProtocol
	// Maximum TLS protocol version. By default, it's ``TLSv1_2`` for clients and ``TLSv1_3`` for
	// servers.
	tls_maximum_protocol_version?: #TlsParameters_TlsProtocol
	// If specified, the TLS listener will only support the specified `cipher list
	// <https://commondatastorage.googleapis.com/chromium-boringssl-docs/ssl.h.html#Cipher-suite-configuration>`_
	// when negotiating TLS 1.0-1.2 (this setting has no effect when negotiating TLS 1.3). If not
	// specified, the default list will be used.
	//
	// In non-FIPS builds, the default cipher list is:
	//
	// .. code-block:: none
	//
	//   [ECDHE-ECDSA-AES128-GCM-SHA256|ECDHE-ECDSA-CHACHA20-POLY1305]
	//   [ECDHE-RSA-AES128-GCM-SHA256|ECDHE-RSA-CHACHA20-POLY1305]
	//   ECDHE-ECDSA-AES128-SHA
	//   ECDHE-RSA-AES128-SHA
	//   AES128-GCM-SHA256
	//   AES128-SHA
	//   ECDHE-ECDSA-AES256-GCM-SHA384
	//   ECDHE-RSA-AES256-GCM-SHA384
	//   ECDHE-ECDSA-AES256-SHA
	//   ECDHE-RSA-AES256-SHA
	//   AES256-GCM-SHA384
	//   AES256-SHA
	//
	// In builds using :ref:`BoringSSL FIPS <arch_overview_ssl_fips>`, the default cipher list is:
	//
	// .. code-block:: none
	//
	//   ECDHE-ECDSA-AES128-GCM-SHA256
	//   ECDHE-RSA-AES128-GCM-SHA256
	//   ECDHE-ECDSA-AES128-SHA
	//   ECDHE-RSA-AES128-SHA
	//   AES128-GCM-SHA256
	//   AES128-SHA
	//   ECDHE-ECDSA-AES256-GCM-SHA384
	//   ECDHE-RSA-AES256-GCM-SHA384
	//   ECDHE-ECDSA-AES256-SHA
	//   ECDHE-RSA-AES256-SHA
	//   AES256-GCM-SHA384
	//   AES256-SHA
	cipher_suites?: [...string]
	// If specified, the TLS connection will only support the specified ECDH
	// curves. If not specified, the default curves will be used.
	//
	// In non-FIPS builds, the default curves are:
	//
	// .. code-block:: none
	//
	//   X25519
	//   P-256
	//
	// In builds using :ref:`BoringSSL FIPS <arch_overview_ssl_fips>`, the default curve is:
	//
	// .. code-block:: none
	//
	//   P-256
	ecdh_curves?: [...string]
}

// BoringSSL private key method configuration. The private key methods are used for external
// (potentially asynchronous) signing and decryption operations. Some use cases for private key
// methods would be TPM support and TLS acceleration.
#PrivateKeyProvider: {
	"@type": "type.googleapis.com/envoy.api.v2.auth.PrivateKeyProvider"
	// Private key method provider name. The name must match a
	// supported private key method provider type.
	provider_name?: string
	// Deprecated: Do not use.
	config?:       _struct.#Struct
	typed_config?: _
}

// [#next-free-field: 7]
#TlsCertificate: {
	"@type": "type.googleapis.com/envoy.api.v2.auth.TlsCertificate"
	// The TLS certificate chain.
	certificate_chain?: core.#DataSource
	// The TLS private key.
	private_key?: core.#DataSource
	// BoringSSL private key method provider. This is an alternative to :ref:`private_key
	// <envoy_api_field_auth.TlsCertificate.private_key>` field. This can't be
	// marked as ``oneof`` due to API compatibility reasons. Setting both :ref:`private_key
	// <envoy_api_field_auth.TlsCertificate.private_key>` and
	// :ref:`private_key_provider
	// <envoy_api_field_auth.TlsCertificate.private_key_provider>` fields will result in an
	// error.
	private_key_provider?: #PrivateKeyProvider
	// The password to decrypt the TLS private key. If this field is not set, it is assumed that the
	// TLS private key is not password encrypted.
	password?: core.#DataSource
	// [#not-implemented-hide:]
	ocsp_staple?: core.#DataSource
	// [#not-implemented-hide:]
	signed_certificate_timestamp?: [...core.#DataSource]
}

#TlsSessionTicketKeys: {
	"@type": "type.googleapis.com/envoy.api.v2.auth.TlsSessionTicketKeys"
	// Keys for encrypting and decrypting TLS session tickets. The
	// first key in the array contains the key to encrypt all new sessions created by this context.
	// All keys are candidates for decrypting received tickets. This allows for easy rotation of keys
	// by, for example, putting the new key first, and the previous key second.
	//
	// If :ref:`session_ticket_keys <envoy_api_field_auth.DownstreamTlsContext.session_ticket_keys>`
	// is not specified, the TLS library will still support resuming sessions via tickets, but it will
	// use an internally-generated and managed key, so sessions cannot be resumed across hot restarts
	// or on different hosts.
	//
	// Each key must contain exactly 80 bytes of cryptographically-secure random data. For
	// example, the output of ``openssl rand 80``.
	//
	// .. attention::
	//
	//   Using this feature has serious security considerations and risks. Improper handling of keys
	//   may result in loss of secrecy in connections, even if ciphers supporting perfect forward
	//   secrecy are used. See https://www.imperialviolet.org/2013/06/27/botchingpfs.html for some
	//   discussion. To minimize the risk, you must:
	//
	//   * Keep the session ticket keys at least as secure as your TLS certificate private keys
	//   * Rotate session ticket keys at least daily, and preferably hourly
	//   * Always generate keys using a cryptographically-secure random data source
	keys?: [...core.#DataSource]
}

// [#next-free-field: 11]
#CertificateValidationContext: {
	"@type": "type.googleapis.com/envoy.api.v2.auth.CertificateValidationContext"
	// TLS certificate data containing certificate authority certificates to use in verifying
	// a presented peer certificate (e.g. server certificate for clusters or client certificate
	// for listeners). If not specified and a peer certificate is presented it will not be
	// verified. By default, a client certificate is optional, unless one of the additional
	// options (:ref:`require_client_certificate
	// <envoy_api_field_auth.DownstreamTlsContext.require_client_certificate>`,
	// :ref:`verify_certificate_spki
	// <envoy_api_field_auth.CertificateValidationContext.verify_certificate_spki>`,
	// :ref:`verify_certificate_hash
	// <envoy_api_field_auth.CertificateValidationContext.verify_certificate_hash>`, or
	// :ref:`match_subject_alt_names
	// <envoy_api_field_auth.CertificateValidationContext.match_subject_alt_names>`) is also
	// specified.
	//
	// It can optionally contain certificate revocation lists, in which case Envoy will verify
	// that the presented peer certificate has not been revoked by one of the included CRLs.
	//
	// See :ref:`the TLS overview <arch_overview_ssl_enabling_verification>` for a list of common
	// system CA locations.
	trusted_ca?: core.#DataSource
	// An optional list of base64-encoded SHA-256 hashes. If specified, Envoy will verify that the
	// SHA-256 of the DER-encoded Subject Public Key Information (SPKI) of the presented certificate
	// matches one of the specified values.
	//
	// A base64-encoded SHA-256 of the Subject Public Key Information (SPKI) of the certificate
	// can be generated with the following command:
	//
	// .. code-block:: bash
	//
	//   $ openssl x509 -in path/to/client.crt -noout -pubkey
	//     | openssl pkey -pubin -outform DER
	//     | openssl dgst -sha256 -binary
	//     | openssl enc -base64
	//   NvqYIYSbgK2vCJpQhObf77vv+bQWtc5ek5RIOwPiC9A=
	//
	// This is the format used in HTTP Public Key Pinning.
	//
	// When both:
	// :ref:`verify_certificate_hash
	// <envoy_api_field_auth.CertificateValidationContext.verify_certificate_hash>` and
	// :ref:`verify_certificate_spki
	// <envoy_api_field_auth.CertificateValidationContext.verify_certificate_spki>` are specified,
	// a hash matching value from either of the lists will result in the certificate being accepted.
	//
	// .. attention::
	//
	//   This option is preferred over :ref:`verify_certificate_hash
	//   <envoy_api_field_auth.CertificateValidationContext.verify_certificate_hash>`,
	//   because SPKI is tied to a private key, so it doesn't change when the certificate
	//   is renewed using the same private key.
	verify_certificate_spki?: [...string]
	// An optional list of hex-encoded SHA-256 hashes. If specified, Envoy will verify that
	// the SHA-256 of the DER-encoded presented certificate matches one of the specified values.
	//
	// A hex-encoded SHA-256 of the certificate can be generated with the following command:
	//
	// .. code-block:: bash
	//
	//   $ openssl x509 -in path/to/client.crt -outform DER | openssl dgst -sha256 | cut -d" " -f2
	//   df6ff72fe9116521268f6f2dd4966f51df479883fe7037b39f75916ac3049d1a
	//
	// A long hex-encoded and colon-separated SHA-256 (a.k.a. "fingerprint") of the certificate
	// can be generated with the following command:
	//
	// .. code-block:: bash
	//
	//   $ openssl x509 -in path/to/client.crt -noout -fingerprint -sha256 | cut -d"=" -f2
	//   DF:6F:F7:2F:E9:11:65:21:26:8F:6F:2D:D4:96:6F:51:DF:47:98:83:FE:70:37:B3:9F:75:91:6A:C3:04:9D:1A
	//
	// Both of those formats are acceptable.
	//
	// When both:
	// :ref:`verify_certificate_hash
	// <envoy_api_field_auth.CertificateValidationContext.verify_certificate_hash>` and
	// :ref:`verify_certificate_spki
	// <envoy_api_field_auth.CertificateValidationContext.verify_certificate_spki>` are specified,
	// a hash matching value from either of the lists will result in the certificate being accepted.
	verify_certificate_hash?: [...string]
	// An optional list of Subject Alternative Names. If specified, Envoy will verify that the
	// Subject Alternative Name of the presented certificate matches one of the specified values.
	//
	// .. attention::
	//
	//   Subject Alternative Names are easily spoofable and verifying only them is insecure,
	//   therefore this option must be used together with :ref:`trusted_ca
	//   <envoy_api_field_auth.CertificateValidationContext.trusted_ca>`.
	//
	// Deprecated: Do not use.
	verify_subject_alt_name?: [...string]
	// An optional list of Subject Alternative name matchers. Envoy will verify that the
	// Subject Alternative Name of the presented certificate matches one of the specified matches.
	//
	// When a certificate has wildcard DNS SAN entries, to match a specific client, it should be
	// configured with exact match type in the :ref:`string matcher <envoy_api_msg_type.matcher.StringMatcher>`.
	// For example if the certificate has "\*.example.com" as DNS SAN entry, to allow only "api.example.com",
	// it should be configured as shown below.
	//
	// .. code-block:: yaml
	//
	//  match_subject_alt_names:
	//    exact: "api.example.com"
	//
	// .. attention::
	//
	//   Subject Alternative Names are easily spoofable and verifying only them is insecure,
	//   therefore this option must be used together with :ref:`trusted_ca
	//   <envoy_api_field_auth.CertificateValidationContext.trusted_ca>`.
	match_subject_alt_names?: [...matcher.#StringMatcher]
	// [#not-implemented-hide:] Must present a signed time-stamped OCSP response.
	require_ocsp_staple?: bool
	// [#not-implemented-hide:] Must present signed certificate time-stamp.
	require_signed_certificate_timestamp?: bool
	// An optional `certificate revocation list
	// <https://en.wikipedia.org/wiki/Certificate_revocation_list>`_
	// (in PEM format). If specified, Envoy will verify that the presented peer
	// certificate has not been revoked by this CRL. If this DataSource contains
	// multiple CRLs, all of them will be used.
	crl?: core.#DataSource
	// If specified, Envoy will not reject expired certificates.
	allow_expired_certificate?: bool
	// Certificate trust chain verification mode.
	trust_chain_verification?: #CertificateValidationContext_TrustChainVerification
}
