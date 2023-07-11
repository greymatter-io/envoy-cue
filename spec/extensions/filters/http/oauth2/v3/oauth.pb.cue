package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v32 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
	v33 "envoyproxy.io/envoy-cue/spec/config/route/v3"
)

#OAuth2Config_AuthType: "URL_ENCODED_BODY" | "BASIC_AUTH"

OAuth2Config_AuthType_URL_ENCODED_BODY: "URL_ENCODED_BODY"
OAuth2Config_AuthType_BASIC_AUTH:       "BASIC_AUTH"

#OAuth2Credentials: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2Credentials"
	// The client_id to be used in the authorize calls. This value will be URL encoded when sent to the OAuth server.
	client_id?: string
	// The secret used to retrieve the access token. This value will be URL encoded when sent to the OAuth server.
	token_secret?: v3.#SdsSecretConfig
	// If present, the secret token will be a HMAC using the provided secret.
	hmac_secret?: v3.#SdsSecretConfig
	// The cookie names used in OAuth filters flow.
	cookie_names?: #OAuth2Credentials_CookieNames
}

// OAuth config
//
// [#next-free-field: 12]
#OAuth2Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2Config"
	// Endpoint on the authorization server to retrieve the access token from.
	token_endpoint?: v31.#HttpUri
	// The endpoint redirect to for authorization in response to unauthorized requests.
	authorization_endpoint?: string
	// Credentials used for OAuth.
	credentials?: #OAuth2Credentials
	// The redirect URI passed to the authorization endpoint. Supports header formatting
	// tokens. For more information, including details on header value syntax, see the
	// documentation on :ref:`custom request headers <config_http_conn_man_headers_custom_request_headers>`.
	//
	// This URI should not contain any query parameters.
	redirect_uri?: string
	// Matching criteria used to determine whether a path appears to be the result of a redirect from the authorization server.
	redirect_path_matcher?: v32.#PathMatcher
	// The path to sign a user out, clearing their credential cookies.
	signout_path?: v32.#PathMatcher
	// Forward the OAuth token as a Bearer to upstream web service.
	forward_bearer_token?: bool
	// Any request that matches any of the provided matchers will be passed through without OAuth validation.
	pass_through_matcher?: [...v33.#HeaderMatcher]
	// Optional list of OAuth scopes to be claimed in the authorization request. If not specified,
	// defaults to "user" scope.
	// OAuth RFC https://tools.ietf.org/html/rfc6749#section-3.3
	auth_scopes?: [...string]
	// Optional resource parameter for authorization request
	// RFC: https://tools.ietf.org/html/rfc8707
	resources?: [...string]
	// Defines how ``client_id`` and ``client_secret`` are sent in OAuth client to OAuth server requests.
	// RFC https://datatracker.ietf.org/doc/html/rfc6749#section-2.3.1
	auth_type?: #OAuth2Config_AuthType
}

// Filter config.
#OAuth2: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2"
	// Leave this empty to disable OAuth2 for a specific route, using per filter config.
	config?: #OAuth2Config
}

#OAuth2Credentials_CookieNames: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2Credentials_CookieNames"
	// Cookie name to hold OAuth bearer token value. When the authentication server validates the
	// client and returns an authorization token back to the OAuth filter, no matter what format
	// that token is, if :ref:`forward_bearer_token <envoy_v3_api_field_extensions.filters.http.oauth2.v3.OAuth2Config.forward_bearer_token>`
	// is set to true the filter will send over the bearer token as a cookie with this name to the
	// upstream. Defaults to ``BearerToken``.
	bearer_token?: string
	// Cookie name to hold OAuth HMAC value. Defaults to ``OauthHMAC``.
	oauth_hmac?: string
	// Cookie name to hold OAuth expiry value. Defaults to ``OauthExpires``.
	oauth_expires?: string
}
