package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
)

// Authentication attributes for a downstream mTLS connection. All modes require that a peer certificate
// was presented and validated using the ValidationContext in the DownstreamTlsContext configuration.
//
// If neither field is set, a configuration loading error will be generated. This is so that
// not validating SANs requires an affirmative configuration to disable, to prevent accidentally
// not configuring SAN validation.
//
// If “any_validated_client_certificate“ is set in addition to “san_matcher“ or a future field
// which specifies additional validation, the other field always takes precedence over
// “any_validated_client_certificate“ and all specified validation is performed.
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.rbac.principals.mtls_authenticated.v3.Config"
	// Specifies a SAN that must be present in the validated peer certificate.
	san_matcher?: v3.#SubjectAltNameMatcher
	// Only require that the peer certificate is present and valid.
	any_validated_client_certificate?: bool
}
