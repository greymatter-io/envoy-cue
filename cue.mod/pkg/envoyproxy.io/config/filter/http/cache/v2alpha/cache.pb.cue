package v2alpha

import (
	matcher "envoyproxy.io/type/matcher"
	route "envoyproxy.io/api/v2/route"
)

#CacheConfig: {
	"@type": "type.googleapis.com/envoy.config.filter.http.cache.v2alpha.CacheConfig"
	// Config specific to the cache storage implementation.
	typed_config?: _
	// List of matching rules that defines allowed *Vary* headers.
	//
	// The *vary* response header holds a list of header names that affect the
	// contents of a response, as described by
	// https://httpwg.org/specs/rfc7234.html#caching.negotiated.responses.
	//
	// During insertion, *allowed_vary_headers* acts as a allowlist: if a
	// response's *vary* header mentions any header names that aren't matched by any rules in
	// *allowed_vary_headers*, that response will not be cached.
	//
	// During lookup, *allowed_vary_headers* controls what request headers will be
	// sent to the cache storage implementation.
	allowed_vary_headers?: [...matcher.#StringMatcher]
	// [#not-implemented-hide:]
	// <TODO(toddmgreer) implement key customization>
	//
	// Modifies cache key creation by restricting which parts of the URL are included.
	key_creator_params?: #CacheConfig_KeyCreatorParams
	// [#not-implemented-hide:]
	// <TODO(toddmgreer) implement size limit>
	//
	// Max body size the cache filter will insert into a cache. 0 means unlimited (though the cache
	// storage implementation may have its own limit beyond which it will reject insertions).
	max_body_bytes?: uint32
}

// [#not-implemented-hide:]
// Modifies cache key creation by restricting which parts of the URL are included.
#CacheConfig_KeyCreatorParams: {
	"@type": "type.googleapis.com/envoy.config.filter.http.cache.v2alpha.CacheConfig_KeyCreatorParams"
	// If true, exclude the URL scheme from the cache key. Set to true if your origins always
	// produce the same response for http and https requests.
	exclude_scheme?: bool
	// If true, exclude the host from the cache key. Set to true if your origins' responses don't
	// ever depend on host.
	exclude_host?: bool
	// If *query_parameters_included* is nonempty, only query parameters matched
	// by one or more of its matchers are included in the cache key. Any other
	// query params will not affect cache lookup.
	query_parameters_included?: [...route.#QueryParameterMatcher]
	// If *query_parameters_excluded* is nonempty, query parameters matched by one
	// or more of its matchers are excluded from the cache key (even if also
	// matched by *query_parameters_included*), and will not affect cache lookup.
	query_parameters_excluded?: [...route.#QueryParameterMatcher]
}
