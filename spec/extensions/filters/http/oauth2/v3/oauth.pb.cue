package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v32 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
	v33 "envoyproxy.io/envoy-cue/spec/config/route/v3"
)

#CookieConfig_SameSite: "DISABLED" | "STRICT" | "LAX" | "NONE"

CookieConfig_SameSite_DISABLED: "DISABLED"
CookieConfig_SameSite_STRICT:   "STRICT"
CookieConfig_SameSite_LAX:      "LAX"
CookieConfig_SameSite_NONE:     "NONE"

// Supported JWT signing algorithms for the client assertion.
#PrivateKeyJwtConfig_SigningAlgorithm: "RS256" | "RS384" | "RS512" | "ES256" | "ES384" | "ES512"

PrivateKeyJwtConfig_SigningAlgorithm_RS256: "RS256"
PrivateKeyJwtConfig_SigningAlgorithm_RS384: "RS384"
PrivateKeyJwtConfig_SigningAlgorithm_RS512: "RS512"
PrivateKeyJwtConfig_SigningAlgorithm_ES256: "ES256"
PrivateKeyJwtConfig_SigningAlgorithm_ES384: "ES384"
PrivateKeyJwtConfig_SigningAlgorithm_ES512: "ES512"

#OAuth2Config_AuthType: "URL_ENCODED_BODY" | "BASIC_AUTH" | "TLS_CLIENT_AUTH" | "PRIVATE_KEY_JWT"

OAuth2Config_AuthType_URL_ENCODED_BODY: "URL_ENCODED_BODY"
OAuth2Config_AuthType_BASIC_AUTH:       "BASIC_AUTH"
OAuth2Config_AuthType_TLS_CLIENT_AUTH:  "TLS_CLIENT_AUTH"
OAuth2Config_AuthType_PRIVATE_KEY_JWT:  "PRIVATE_KEY_JWT"

// OAuth cookie configuration attributes.
#CookieConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.CookieConfig"
	// The value used for the SameSite cookie attribute.
	same_site?: #CookieConfig_SameSite
	// The path attribute for the cookie.
	//
	// This controls the scope of the cookie and is useful for path-based routing scenarios
	// where different logical boundaries or applications may operate with different OAuth2 clients.
	// The CSRF cookie (nonce cookie) can be configured with a different path than session cookies
	// to support flows where the callback URL is on a different path.
	//
	// If not specified, defaults to “/“.
	path?: string
	// If true, the “Partitioned“ attribute will be set on the cookie.
	//
	// Modern browsers (Firefox, Chrome with third-party cookie deprecation) warn or block
	// "foreign" cookies unless they carry the “Partitioned“ attribute alongside “SameSite=None; Secure“.
	// When Envoy is used in a gateway/IdP flow that sets OAuth/OIDC cookies for a parent domain
	// (e.g., “Domain=.example.com“) while running on a different host, those cookies are
	// considered third-party and will be rejected without “Partitioned“.
	//
	// See `CHIPS <https://developers.google.com/privacy-sandbox/3pcd/chips>`_ for more information.
	//
	// Default is false.
	partitioned?: bool
}

// [#next-free-field: 8]
#CookieConfigs: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.CookieConfigs"
	// Configuration for the bearer token cookie.
	bearer_token_cookie_config?: #CookieConfig
	// Configuration for the OAuth HMAC cookie.
	oauth_hmac_cookie_config?: #CookieConfig
	// Configuration for the OAuth expires cookie.
	oauth_expires_cookie_config?: #CookieConfig
	// Configuration for the ID token cookie.
	id_token_cookie_config?: #CookieConfig
	// Configuration for the refresh token cookie.
	refresh_token_cookie_config?: #CookieConfig
	// Configuration for the OAuth nonce cookie.
	oauth_nonce_cookie_config?: #CookieConfig
	// Configuration for the code verifier cookie.
	code_verifier_cookie_config?: #CookieConfig
}

// [#next-free-field: 6]
#OAuth2Credentials: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2Credentials"
	// The client_id to be used in the authorize calls. This value will be URL encoded when sent to the OAuth server.
	client_id?: string
	// The secret used to retrieve the access token. This value will be URL encoded when sent to the OAuth server.
	// This field is required unless :ref:`auth_type <envoy_v3_api_field_extensions.filters.http.oauth2.v3.OAuth2Config.auth_type>`
	// is set to “TLS_CLIENT_AUTH“, in which case authentication is done via the client certificate.
	// When “auth_type“ is “PRIVATE_KEY_JWT“, this field must contain the PEM-encoded private key
	// used to sign the JWT client assertion.
	token_secret?: v3.#SdsSecretConfig
	// If present, the secret token will be a HMAC using the provided secret.
	hmac_secret?: v3.#SdsSecretConfig
	// The cookie names used in OAuth filters flow.
	cookie_names?: #OAuth2Credentials_CookieNames
	// The domain to set the cookie on. If not set, the cookie will default to the host of the request, not including the subdomains.
	// This is useful when token cookies need to be shared across multiple subdomains.
	cookie_domain?: string
}

// Configuration for “PRIVATE_KEY_JWT“ client authentication (RFC 7523).
#PrivateKeyJwtConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.PrivateKeyJwtConfig"
	// The signing algorithm to use for the JWT assertion.
	// The private key provided in “token_secret“ must match the algorithm family: an RSA key for
	// the “RS*“ algorithms, or an EC key for the “ES*“ algorithms.
	// Default: “RS256“.
	signing_algorithm?: #PrivateKeyJwtConfig_SigningAlgorithm
	// The lifetime of the JWT assertion. After this duration, the assertion expires.
	// The value is truncated to whole seconds, so it must be at least “1s“ when set.
	// Default: “60s“.
	assertion_lifetime?: string
}

// Defines how an OAuth token is forwarded upstream.
#OAuth2TokenForwarding: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2TokenForwarding"
	// The upstream request header that will carry the token.
	// Pseudo-headers (names starting with “:“) and the “Host“ header are not allowed.
	header?: string
}

// Configuration for the “post_logout_redirect_uri“ parameter used in OpenID Connect
// `RP-Initiated Logout requests <https://openid.net/specs/openid-connect-rpinitiated-1_0.html>`_.
// This configuration is ignored if “end_session_endpoint“ is not set.
#PostLogoutRedirectUri: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.PostLogoutRedirectUri"
	// Do not include the “post_logout_redirect_uri“ parameter in requests to the
	// configured “end_session_endpoint“.
	disabled?: bool
	// URI to send as the “post_logout_redirect_uri“ parameter. Supports header formatting
	// tokens, and will be percent-encoded automatically when building the logout URL.
	//
	// The URI should be registered with the authorization server.
	uri?: string
}

// OAuth config
//
// [#next-free-field: 34]
#OAuth2Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2Config"
	// Endpoint on the authorization server to retrieve the access token from.
	token_endpoint?: v31.#HttpUri
	// Specifies the retry policy for requests to the OAuth server. If not specified, then no retries will be performed.
	retry_policy?: v31.#RetryPolicy
	// The endpoint redirect to for authorization in response to unauthorized requests.
	authorization_endpoint?: string
	// The endpoint at the authorization server to request the user be logged out of the Authorization server.
	// This field is optional and should be set only if openid is in the auth_scopes and the authorization server
	// supports the OpenID Connect RP-Initiated Logout specification.
	// For more information, see https://openid.net/specs/openid-connect-rpinitiated-1_0.html
	//
	// If configured, the OAuth2 filter will redirect users to this endpoint when they access the signout_path.
	end_session_endpoint?: string
	// Optional control for the “post_logout_redirect_uri“ parameter sent to the “end_session_endpoint“ when a user
	// accesses the “signout_path“.
	// This field should be set only if “openid“ is in the “auth_scopes“, the “end_session_endpoint“ is configured,
	// and the authorization server supports the OpenID Connect RP-Initiated Logout specification.
	//
	// If unset, Envoy preserves the historical behavior and sends “<scheme>://<host>/“, constructed from the inbound
	// request, as “post_logout_redirect_uri“.
	post_logout_redirect_uri?: #PostLogoutRedirectUri
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
	// Forward the OIDC ID token to the upstream.
	//
	// If the configured header is “Authorization“, Envoy forwards the ID token using the
	// “Bearer“ prefix. For any other header, Envoy forwards the raw token value.
	// If not specified, the ID token will not be forwarded.
	//
	// This can not be configured with :ref:`forward_bearer_token
	// <envoy_v3_api_field_extensions.filters.http.oauth2.v3.OAuth2Config.forward_bearer_token>`
	// or :ref:`preserve_authorization_header
	// <envoy_v3_api_field_extensions.filters.http.oauth2.v3.OAuth2Config.preserve_authorization_header>`
	// when the header is “Authorization“.
	forward_id_token?: #OAuth2TokenForwarding
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
	// Default value is true.
	use_refresh_token?: bool
	// The default lifetime in seconds of the access token, if omitted by the authorization server.
	//
	// If this value is not set, it will default to “0s“. In this case, the expiry must be set by
	// the authorization server or the OAuth flow will fail.
	default_expires_in?: string
	// Any request that matches any of the provided matchers won't be redirected to OAuth server when tokens are not valid.
	// Automatic access token refresh will be performed for these requests, if enabled.
	// This behavior can be useful for AJAX requests.
	deny_redirect_matcher?: [...v33.#HeaderMatcher]
	// The default lifetime in seconds of the refresh token, if the exp (expiration time) claim is omitted in the refresh token or the refresh token is not JWT.
	//
	// If this value is not set, it will default to “604800s“. In this case, the cookie with the refresh token will be expired
	// in a week.
	// This setting is only considered if “use_refresh_token“ is set to true, otherwise the authorization server expiration or “default_expires_in“ is used.
	default_refresh_token_expires_in?: string
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
	// Controls for attributes that can be set on the cookies.
	cookie_configs?: #CookieConfigs
	// Optional additional prefix to use when emitting statistics.
	stat_prefix?: string
	// Optional expiration time for the CSRF protection token cookie.
	// The CSRF token prevents cross-site request forgery attacks during the OAuth2 flow.
	// If not specified, defaults to “600s“ (10 minutes), which should provide sufficient time
	// for users to complete the OAuth2 authorization flow.
	csrf_token_expires_in?: string
	// Optional expiration time for the code verifier cookie.
	// The code verifier is stored in a secure, HTTP-only cookie during the OAuth2 authorization process.
	// If not specified, defaults to “600s“ (10 minutes), which should provide sufficient time
	// for users to complete the OAuth2 authorization flow.
	code_verifier_token_expires_in?: string
	// Disable token encryption. When set to true, both the access token and the ID token will be stored in plain text.
	// This option should only be used in secure environments where token encryption is not required.
	// Default is false (tokens are encrypted).
	disable_token_encryption?: bool
	// Any request that matches any of the provided matchers will be allowed to continue to upstream
	// even if OAuth validation fails (missing, invalid, or expired credentials).
	// This is useful for services that can handle both authenticated and unauthenticated requests,
	// enabling graceful degradation patterns.
	//
	// When triggered, all OAuth cookies are stripped from the request and the request proceeds as unauthenticated.
	// Context headers “x-envoy-oauth-status: failed“ and “x-envoy-oauth-failure-reason“ are added to inform upstream.
	//
	// Note: If a request matches pass_through_matcher, it bypasses OAuth validation and this matcher won't be evaluated.
	// This matcher takes precedence over deny_redirect_matcher.
	allow_failed_matcher?: [...v33.#HeaderMatcher]
	// Optional base URI (scheme + host, e.g. “https://app.example.com“) used to build the
	// original request URI that is encoded into the OAuth2 “state“ parameter.
	// This URI will be used later to redirect users on a successful OAuth.
	//
	// This is useful when Envoy sits behind a gateway or load balancer that terminates the
	// user-facing hostname: In that case, the post-authentication redirect derived from “state“ would
	// send the user to an internal host they didn't request.
	//
	// Supports request header formatting tokens.
	//
	// Example:
	//
	//	original_request_uri: "%REQ(x-forwarded-proto?:scheme)%://%REQ(x-forwarded-host?:authority)%"
	//
	// If not set, defaults to “<:scheme>://<:authority>“ of the incoming request.
	original_request_uri?: string
	// Optional list of domains that are allowed as
	// 1. redirect_uri: which is what the IdP calls after OAuth
	// 2. original_request_uri: the one extracted from the state of an OAuth callback (where should the request go after OAuth)
	//
	// This mitigates:
	// - injecting a malicious x-forwarded-host or any header that is used to template the redirect urls
	// - open redirect attacks where an attacker crafts a “state“ value pointing to an untrusted host.
	//
	// Each entry is matched against the host (with any port stripped) extracted from the
	// formatted “redirect_uri“, the formatted “original_request_uri“, and the URL decoded from
	// the “state“ parameter on callback. Matching is case-insensitive and supports two forms:
	//
	//   - Exact match, e.g. “example.com“ matches only “example.com“.
	//   - Wildcard subdomain match using a leading “*.“, e.g. “*.example.com“ matches
	//     “foo.example.com“ and “bar.baz.example.com“ but not “example.com“ itself.
	//
	// IPv6 literals must be configured without surrounding brackets (e.g. “::1“, not “[::1]“).
	//
	// If this list is empty (the default), all hosts are allowed and no validation is performed.
	allowed_redirect_domains?: [...string]
	// If set to true, the expiration time for the ID token cookie will always be derived from the
	// “expires_in“ field of the access token response rather than from the “exp“ claim in the
	// ID token JWT. This is useful when the access token response advertises a longer lifetime than
	// the ID token and you want the ID token cookie to remain valid for that full duration.
	// Default is false (use the ID token's own “exp“ claim when available).
	use_access_token_expiry_for_id_token_cookie?: bool
	// Configuration for “PRIVATE_KEY_JWT“ client authentication.
	// Only used when :ref:`auth_type <envoy_v3_api_field_extensions.filters.http.oauth2.v3.OAuth2Config.auth_type>`
	// is set to “PRIVATE_KEY_JWT“.
	private_key_jwt_config?: #PrivateKeyJwtConfig
}

// Per-route OAuth2 config.
//
// This message supplies an OAuth2Config for the matched route.
// It overrides the filter-level config for requests matching the route.
// If neither the global config nor a per-route config is specified, OAuth2 is disabled for the route.
#OAuth2PerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2PerRoute"
	// Full OAuth2 config for this route.
	config?: #OAuth2Config
}

// Filter config.
#OAuth2: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.oauth2.v3.OAuth2"
	// The OAuth2 filter config.
	config?: #OAuth2Config
}

// [#next-free-field: 8]
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
	// Cookie name to hold the PKCE code verifier. Defaults to “OauthCodeVerifier“.
	code_verifier?: string
}
