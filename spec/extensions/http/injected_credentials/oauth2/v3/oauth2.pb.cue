package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
)

#OAuth2_AuthType: "BASIC_AUTH" | "URL_ENCODED_BODY"

OAuth2_AuthType_BASIC_AUTH:       "BASIC_AUTH"
OAuth2_AuthType_URL_ENCODED_BODY: "URL_ENCODED_BODY"

// OAuth2 extension can be used to retrieve an OAuth2 access token from an authorization server and inject it into the
// proxied requests.
// Currently, only the Client Credentials Grant flow is supported.
// The access token will be injected into the request headers using the “Authorization“ header as a bearer token.
// [#next-free-field: 6]
#OAuth2: {
	"@type": "type.googleapis.com/envoy.extensions.http.injected_credentials.oauth2.v3.OAuth2"
	// Endpoint on the authorization server to retrieve the access token from.
	// Refer to [RFC 6749: The OAuth 2.0 Authorization Framework](https://www.rfc-editor.org/rfc/rfc6749#section-3.2) for details.
	token_endpoint?: v3.#HttpUri
	// Optional list of OAuth scopes to be claimed in the authorization request.
	// Refer to [RFC 6749: The OAuth 2.0 Authorization Framework](https://www.rfc-editor.org/rfc/rfc6749#section-4.4.2) for details.
	scopes?: [...string]
	// Client Credentials Grant.
	// Refer to [RFC 6749: The OAuth 2.0 Authorization Framework](https://www.rfc-editor.org/rfc/rfc6749#section-4.4) for details.
	client_credentials?: #OAuth2_ClientCredentials
	// The interval between two successive retries to fetch token from Identity Provider. Default is 2 secs.
	// The interval must be at least 1 second.
	token_fetch_retry_interval?: string
	// Optional list of additional parameters to send to the token endpoint.
	// These parameters will be URL-encoded and included in the token request body.
	endpoint_params?: [...#OAuth2_EndpointParameter]
}

// Credentials to authenticate client to the authorization server.
// Refer to [RFC 6749: The OAuth 2.0 Authorization Framework](https://www.rfc-editor.org/rfc/rfc6749#section-2.3) for details.
#OAuth2_ClientCredentials: {
	"@type": "type.googleapis.com/envoy.extensions.http.injected_credentials.oauth2.v3.OAuth2_ClientCredentials"
	// Client ID.
	// Refer to [RFC 6749: The OAuth 2.0 Authorization Framework](https://www.rfc-editor.org/rfc/rfc6749#section-2.3.1) for details.
	client_id?: string
	// Client secret.
	// Refer to [RFC 6749: The OAuth 2.0 Authorization Framework](https://www.rfc-editor.org/rfc/rfc6749#section-2.3.1) for details.
	client_secret?: v31.#SdsSecretConfig
	// The method to use when sending credentials to the authorization server.
	// Refer to [RFC 6749: The OAuth 2.0 Authorization Framework](https://www.rfc-editor.org/rfc/rfc6749#section-2.3.1) for details.
	auth_type?: #OAuth2_AuthType
}

// Optional additional parameters to include in the token endpoint request body.
// These parameters will be URL-encoded and added to the request body along with the standard OAuth2 parameters.
// Refer to your authorization server's documentation for supported parameters.
#OAuth2_EndpointParameter: {
	"@type": "type.googleapis.com/envoy.extensions.http.injected_credentials.oauth2.v3.OAuth2_EndpointParameter"
	// Parameter name.
	name?: string
	// Parameter value.
	value?: string
}
