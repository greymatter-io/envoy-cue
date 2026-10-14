package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Filter configuration.
// [#next-free-field: 9]
#GcpAuthnFilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.GcpAuthnFilterConfig"
	// The HTTP URI to fetch tokens from GCE Metadata Server(https://cloud.google.com/compute/docs/metadata/overview).
	// The URL format is "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/identity?audience=[AUDIENCE]"
	//
	// This field is deprecated because it does not match the API surface provided by the google auth libraries.
	// Control planes should not attempt to override the metadata server URI.
	// The cluster and timeout can be configured using the ``cluster`` and ``timeout`` fields instead.
	// For backward compatibility, the cluster and timeout configured in this field will be used
	// if the new ``cluster`` and ``timeout`` fields are not set.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/http/gcp_authn/v3/gcp_authn.proto.
	http_uri?: v3.#HttpUri
	// Retry policy for fetching tokens.
	// Not supported by all data planes.
	retry_policy?: v3.#RetryPolicy
	// Token cache configuration. This field is optional.
	cache_config?: #TokenCacheConfig
	// Request header location to extract the token. By default (i.e. if this field is not specified), the token
	// is extracted to the Authorization HTTP header, in the format "Authorization: Bearer <token>".
	// If ``token_metadata_key`` is set, this field takes no effect.
	// Not supported by all data planes.
	token_header?: #TokenHeader
	// Optional dynamic metadata key to save the token. The metadata uses the filter config name as the namespace.
	// Takes precedence over ``token_header``.
	token_metadata_key?: string
	// Cluster to send traffic to the GCE metadata server. Not supported
	// by all data planes; a data plane may instead have its own mechanism
	// for contacting the metadata server.
	cluster?: string
	// Timeout for fetching the tokens from the GCE metadata server.
	// Not supported by all data planes.
	timeout?: string
	// Defines the authentication service. This field overrides the cluster's typed_filter_metadata definition.
	audience?: #Audience
}

// Audience is the URL of the receiving service that performs token authentication.
// It will be provided to the filter through cluster's typed_filter_metadata.
// [#next-free-field: 6]
#Audience: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.Audience"
	// The audience URL, used for fetching unbound JWT token.
	url?: string
	// If defined, the filter will fetch unbound Access Token instead of JWT.
	// It takes precedence over ``url``.
	access_token?: #Audience_AccessToken
	// If defined, the filter will fetch bound JWT token instead of unbound.
	// It takes precedence over ``access_token`` and ``url``.
	bound_jwt?: #Audience_BoundJwt
	// If defined, the filter will fetch bound Access Token instead of unbound.
	// It takes precedence over ``bound_jwt``, ``access_token`` and ``url``.
	bound_access_token?: #Audience_BoundAccessToken
	// If defined, the filter will fetch an access token for a service account.
	// It takes precedence over ``bound_access_token``, ``bound_jwt``, ``access_token``, and ``url``.
	// Requires inlined audience definition in the filter configuration.
	iam_access_token?: #Audience_IAMAccessToken
}

// Token Cache configuration.
#TokenCacheConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.TokenCacheConfig"
	// The number of cache entries. The maximum number of entries is INT64_MAX as it is constrained by underlying cache implementation.
	// Default value 0 (i.e., proto3 defaults) disables the cache by default. Other default values will enable the cache.
	cache_size?: uint64
}

#TokenHeader: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.TokenHeader"
	// The HTTP header's name. Defaults to ``Authorization`` if not specified.
	name?: string
	// The header's prefix. The format is "value_prefix<token>"
	// For example, for "Authorization: Bearer <token>", value_prefix="Bearer " with a space at the
	// end.
	value_prefix?: string
	// If set, the filter checks if the target header is already present (by header key existence,
	// even if the header value is empty). If present, it skips token fetching and preserves the
	// existing header intact (``value_prefix`` has no effect on the preserved header). If absent,
	// a new token is fetched and written using ``name`` and ``value_prefix``.
	// If not set, the default behavior is to unconditionally overwrite the header.
	preserve_existing?: #TokenHeader_PreserveExisting
}

#Audience_AccessToken: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.Audience_AccessToken"
	// Optional custom OAuth scopes for the access token request.
	// If empty, the filter will not request scopes explicitly, so the metadata server's default
	// scopes will be used.
	// When populated, the filter appends "?scopes=<comma-separated-scopes>" to the
	// metadata server token request. Note that the metadata server replaces default
	// scopes with the provided list rather than appending; to preserve general GCP API
	// access, callers should explicitly include "https://www.googleapis.com/auth/cloud-platform".
	// Validation rules require each scope to be non-empty and disallow whitespace or commas,
	// as commas are used as the delimiter for the metadata server and OAuth 2.0 scopes
	// cannot contain whitespace (RFC 6749 Section 3.3).
	scopes?: [...string]
}

#Audience_BoundJwt: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.Audience_BoundJwt"
	// The audience URL, used for fetching bound JWT token.
	url?: string
}

#Audience_BoundAccessToken: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.Audience_BoundAccessToken"
	// Optional custom OAuth scopes for the bound access token request.
	// If empty, the filter will not request scopes explicitly, so the metadata server's default
	// scopes will be used.
	// When populated, the filter appends "&scopes=<comma-separated-scopes>" to the
	// metadata server token request. Note that the metadata server replaces default
	// scopes with the provided list rather than appending; to preserve general GCP API
	// access, callers should explicitly include "https://www.googleapis.com/auth/cloud-platform".
	// Validation rules require each scope to be non-empty and disallow whitespace or commas,
	// as commas are used as the delimiter for the metadata server and OAuth 2.0 scopes
	// cannot contain whitespace (RFC 6749 Section 3.3).
	scopes?: [...string]
}

// Default lifetime is 1h.
#Audience_IAMAccessToken: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.Audience_IAMAccessToken"
	// A template string for the account email or unique ID for which the credentials are requested,
	// e.g. ``my-sa-%DYNAMIC_METADATA(my_filter:tenant_project)%@my-project.iam.gserviceaccount.com``.
	account?: string
	// A template string for the authorization header value,
	// e.g. ``Bearer %DYNAMIC_METADATA(gcp_authn:token)%``.
	authorization?: string
	// Optional custom scopes for the token request.
	// Default scope is https://www.googleapis.com/auth/cloud-platform.
	scopes?: [...string]
}

// Configuration options for preserving an existing token header.
#TokenHeader_PreserveExisting: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.TokenHeader_PreserveExisting"
}
