package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration specific to the `SPIFFE <https://github.com/spiffe/spiffe>`_ certificate validator.
//
// Example:
//
// .. validated-code-block:: yaml
//
//	:type-name: envoy.extensions.transport_sockets.tls.v3.CertificateValidationContext
//
//	custom_validator_config:
//	  name: envoy.tls.cert_validator.spiffe
//	  typed_config:
//	    "@type": type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.SPIFFECertValidatorConfig
//	    trust_domains:
//	    - name: foo.com
//	      trust_bundle:
//	        filename: "foo.pem"
//	    - name: envoy.com
//	      trust_bundle:
//	        filename: "envoy.pem"
//
// In this example, a presented peer certificate whose SAN matches “spiffe://foo.com/**“ is validated against
// the "foo.pem" x.509 certificate. All the trust bundles are isolated from each other, so no trust domain can mint
// a SVID belonging to another trust domain. That means, in this example, a SVID signed by “envoy.com“'s CA with “spiffe://foo.com/**“
// SAN would be rejected since Envoy selects the trust bundle according to the presented SAN before validate the certificate.
//
// Note that SPIFFE validator inherits and uses the following options from :ref:`CertificateValidationContext <envoy_v3_api_msg_extensions.transport_sockets.tls.v3.CertificateValidationContext>`.
//
// - :ref:`allow_expired_certificate <envoy_v3_api_field_extensions.transport_sockets.tls.v3.CertificateValidationContext.allow_expired_certificate>` to allow expired certificates.
// - :ref:`match_typed_subject_alt_names <envoy_v3_api_field_extensions.transport_sockets.tls.v3.CertificateValidationContext.match_typed_subject_alt_names>` to match **URI** SAN of certificates. Unlike the default validator, SPIFFE validator only matches **URI** SAN (which equals to SVID in SPIFFE terminology) and ignore other SAN types.
//
// To support multi-tenant use cases, a filter state object “envoy.tls.cert_validator.spiffe.workload_trust_domain“
// should be used to define the per-connection workload trust domain. When matching a peer trust domain, both the
// workload and the peer trust domains are used in selecting the validation certificate. The filter state object
// should be shared with the upstream to be used in the upstream TLS context SPIFFE validation context.
#SPIFFECertValidatorConfig: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.SPIFFECertValidatorConfig"
	// This field specifies trust domains used for validating incoming X.509-SVID(s).
	trust_domains?: [...#SPIFFECertValidatorConfig_TrustDomain]
	// This field specifies all trust bundles as a single DataSource. If both
	// trust_bundles and trust_domains are specified, trust_bundles will
	// take precedence. Currently assumes file will be a SPIFFE Trust Bundle Map.
	// If DataSource is a file, dynamic file watching will be enabled,
	// and updates to the specified file will trigger a refresh of the trust_bundles.
	trust_bundles?: v3.#DataSource
}

#SPIFFECertValidatorConfig_TrustDomain: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.SPIFFECertValidatorConfig_TrustDomain"
	// Name of the trust domain, “example.com“, “foo.bar.gov“ for example.
	// Note that this must *not* have "spiffe://" prefix.
	name?: string
	// Specify a data source holding x.509 trust bundle used for validating incoming SVID(s) in this trust domain.
	trust_bundle?: v3.#DataSource
	// Optional workload trust domain selection condition. The filter object
	// “envoy.tls.cert_validator.spiffe.workload_trust_domain“ must match exactly the value of this field.
	// If not specified, the filter state object must be absent or be empty to match this trust domain.
	workload_trust_domain?: string
}
