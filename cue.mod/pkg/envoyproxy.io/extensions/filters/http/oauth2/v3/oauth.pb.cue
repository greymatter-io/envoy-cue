package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	v3 "envoyproxy.io/extensions/transport_sockets/tls/v3"
	v31 "envoyproxy.io/config/core/v3"
	v32 "envoyproxy.io/type/matcher/v3"
	v33 "envoyproxy.io/config/route/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

#OAuth2Config_AuthType: "URL_ENCODED_BODY" | "BASIC_AUTH"

OAuth2Config_AuthType_URL_ENCODED_BODY: "URL_ENCODED_BODY"
OAuth2Config_AuthType_BASIC_AUTH:       "BASIC_AUTH"

// [#next-free-field: 6]
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
	// The domain to set the cookie on. If not set, the cookie will default to the host of the request, not including the subdomains.
	// This is useful when token cookies need to be shared across multiple subdomains.
	cookie_domain?: string
}

// OAuth config
//
// [#next-free-field: 21]
#OAuth2Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2Config"
	// Endpoint on the authorization server to retrieve the access token from.
	token_endpoint?: v31.#HttpUri
	// Specifies the retry policy for requests to the OAuth server. If not specified, then no retries will be performed.
	retry_policy?: v31.#RetryPolicy
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
	// If set to true, preserve the existing authorization header.
	// By default the client strips the existing authorization header before forwarding upstream.
	// Can not be set to true if forward_bearer_token is already set to true.
	// Default value is false.
	preserve_authorization_header?: bool
	// Any request that matches any of the provided matchers will be passed through without OAuth validation.
	pass_through_matcher?: [...v33.#HeaderMatcher]
	// Optional list of OAuth scopes to be claimed in the authorization request. If not specified,
	// defaults to "user" scope.
	// OAuth RFC https://tools.ietf.org/html/rfc6749#section-3.3
	auth_scopes?: [...string]
	// Optional resource parameter for authorization request
	// RFC: https://tools.ietf.org/html/rfc8707
	resources?: [...string]
	// Defines how “client_id“ and “client_secret“ are sent in OAuth client to OAuth server requests.
	// RFC https://datatracker.ietf.org/doc/html/rfc6749#section-2.3.1
	auth_type?: #OAuth2Config_AuthType
	// If set to true, allows automatic access token refresh using the associated refresh token (see
	// `RFC 6749 section 6 <https://datatracker.ietf.org/doc/html/rfc6749#section-6>`_), provided that the OAuth server supports that.
	// Default value is false.
	use_refresh_token?: wrapperspb.#BoolValue
	// The default lifetime in seconds of the access token, if omitted by the authorization server.
	//
	// If this value is not set, it will default to “0s“. In this case, the expiry must be set by
	// the authorization server or the OAuth flow will fail.
	default_expires_in?: durationpb.#Duration
	// Any request that matches any of the provided matchers won't be redirected to OAuth server when tokens are not valid.
	// Automatic access token refresh will be performed for these requests, if enabled.
	// This behavior can be useful for AJAX requests.
	deny_redirect_matcher?: [...v33.#HeaderMatcher]
	// The default lifetime in seconds of the refresh token, if the exp (expiration time) claim is omitted in the refresh token or the refresh token is not JWT.
	//
	// If this value is not set, it will default to “604800s“. In this case, the cookie with the refresh token will be expired
	// in a week.
	// This setting is only considered if “use_refresh_token“ is set to true, otherwise the authorization server expiration or “default_expires_in“ is used.
	default_refresh_token_expires_in?: durationpb.#Duration
	// If set to true, the client will not set a cookie for ID Token even if one is received from the Identity Provider. This may be useful in cases where the ID
	// Token is too large for HTTP cookies (longer than 4096 characters). Enabling this option will only disable setting the cookie response header, the filter
	// will still process incoming ID Tokens as part of the HMAC if they are there. This is to ensure compatibility while switching this setting on. Future
	// sessions would not set the IdToken cookie header.
	disable_id_token_set_cookie?: bool
	// If set to true, the client will not set a cookie for Access Token even if one is received from the Identity Provider.
	// Enabling this option will only disable setting the cookie response header, the filter
	// will still process incoming Access Tokens as part of the HMAC if they are there. This is to ensure compatibility while switching this setting on. Future
	// sessions would not set the Access Token cookie header.
	disable_access_token_set_cookie?: bool
	// If set to true, the client will not set a cookie for Refresh Token even if one is received from the Identity Provider.
	// Enabling this option will only disable setting the cookie response header, the filter
	// will still process incoming Refresh Tokens as part of the HMAC if they are there. This is to ensure compatibility while switching this setting on. Future
	// sessions would not set the Refresh Token cookie header.
	disable_refresh_token_set_cookie?: bool
}

// Filter config.
#OAuth2: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2"
	// Leave this empty to disable OAuth2 for a specific route, using per filter config.
	config?: #OAuth2Config
}

// [#next-free-field: 7]
#OAuth2Credentials_CookieNames: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2Credentials_CookieNames"
	// Cookie name to hold OAuth bearer token value. When the authentication server validates the
	// client and returns an authorization token back to the OAuth filter, no matter what format
	// that token is, if :ref:`forward_bearer_token <envoy_v3_api_field_extensions.filters.http.oauth2.v3.OAuth2Config.forward_bearer_token>`
	// is set to true the filter will send over the bearer token as a cookie with this name to the
	// upstream. Defaults to “BearerToken“.
	bearer_token?: string
	// Cookie name to hold OAuth HMAC value. Defaults to “OauthHMAC“.
	oauth_hmac?: string
	// Cookie name to hold OAuth expiry value. Defaults to “OauthExpires“.
	oauth_expires?: string
	// Cookie name to hold the id token. Defaults to “IdToken“.
	id_token?: string
	// Cookie name to hold the refresh token. Defaults to “RefreshToken“.
	refresh_token?: string
	// Cookie name to hold the nonce value. Defaults to “OauthNonce“.
	oauth_nonce?: string
}
