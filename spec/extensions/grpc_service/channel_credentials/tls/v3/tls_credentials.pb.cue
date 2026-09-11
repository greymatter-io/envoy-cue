package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
)

// [#not-implemented-hide:]
#TlsCredentials: {
	"@type": "type.googleapis.com/envoy.extensions.grpc_service.channel_credentials.tls.v3.TlsCredentials"
	// The certificate provider instance for the root cert. Must be set.
	root_certificate_provider?: v3.#CommonTlsContext_CertificateProviderInstance
	// The certificate provider instance for the identity cert. Optional;
	// if unset, no identity certificate will be sent to the server.
	identity_certificate_provider?: v3.#CommonTlsContext_CertificateProviderInstance
}
