package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Filter configuration.
#GcpAuthnFilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.GcpAuthnFilterConfig"
	// The HTTP URI to fetch tokens from GCE Metadata Server(https://cloud.google.com/compute/docs/metadata/overview).
	// The URL format is "http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/identity?audience=[AUDIENCE]"
	http_uri?: v3.#HttpUri
	// Retry policy for fetching tokens.
	// This field is optional. If it is not configured, the filter will be fail-closed (i.e., reject the requests).
	retry_policy?: v3.#RetryPolicy
	// Token cache configuration. This field is optional.
	cache_config?: #TokenCacheConfig
}

// Audience is the URL of the receiving service that performs token authentication.
// It will be provided to the filter through cluster's typed_filter_metadata.
#Audience: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.Audience"
	url?:    string
}

// Token Cache configuration.
#TokenCacheConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gcp_authn.v3.TokenCacheConfig"
	// The number of cache entries. The maximum number of entries is INT64_MAX as it is constrained by underlying cache implementation.
	// Default value 0 (i.e., proto3 defaults) disables the cache by default. Other default values will enable the cache.
	cache_size?: uint64
}
