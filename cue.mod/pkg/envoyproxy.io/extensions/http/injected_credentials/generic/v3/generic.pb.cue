package v3

import (
	v3 "envoyproxy.io/extensions/transport_sockets/tls/v3"
)

// Generic extension can be used to inject HTTP Basic Auth, Bearer Token, or any arbitrary credential
// into the proxied requests.
// The credential will be injected into the specified HTTP request header.
// Refer to [RFC 6750: The OAuth 2.0 Authorization Framework: Bearer Token Usage](https://www.rfc-editor.org/rfc/rfc6750) for details.
#Generic: {
	"@type": "type.googleapis.com/envoy.extensions.http.injected_credentials.generic.v3.Generic"
	// The SDS configuration for the credential that will be injected to the specified HTTP request header.
	// It must be a generic secret.
	credential?: v3.#SdsSecretConfig
	// The header that will be injected to the HTTP request with the provided credential.
	// If not set, filter will default to: “Authorization“
	header?: string
}
