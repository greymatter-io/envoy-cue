package v3

import (
	anypb "envoyproxy.io/deps/protobuf/types/known/anypb"
	v3 "envoyproxy.io/type/matcher/v3"
	v31 "envoyproxy.io/config/route/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// [#extension: envoy.filters.http.cache]
// [#next-free-field: 7]
#CacheConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.cache.v3.CacheConfig"
	// Config specific to the cache storage implementation. Required unless “disabled“
	// is true.
	// [#extension-category: envoy.http.cache]
	typed_config?: anypb.#Any
	// When true, the cache filter is a no-op filter.
	//
	// Possible use-cases for this include:
	// - Turning a filter on and off with :ref:`ECDS <envoy_v3_api_file_envoy/service/extension/v3/config_discovery.proto>`.
	// [#comment: once route-specific overrides are implemented, they are the more likely use-case.]
	disabled?: wrapperspb.#BoolValue
	// List of matching rules that defines allowed “Vary“ headers.
	//
	// The “vary“ response header holds a list of header names that affect the
	// contents of a response, as described by
	// https://httpwg.org/specs/rfc7234.html#caching.negotiated.responses.
	//
	// During insertion, “allowed_vary_headers“ acts as a allowlist: if a
	// response's “vary“ header mentions any header names that aren't matched by any rules in
	// “allowed_vary_headers“, that response will not be cached.
	//
	// During lookup, “allowed_vary_headers“ controls what request headers will be
	// sent to the cache storage implementation.
	allowed_vary_headers?: [...v3.#StringMatcher]
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
	// By default, a “cache-control: no-cache“ or “pragma: no-cache“ header in the request
	// causes the cache to validate with its upstream even if the lookup is a hit. Setting this
	// to true will ignore these headers.
	ignore_request_cache_control_header?: bool
}

// [#not-implemented-hide:]
// Modifies cache key creation by restricting which parts of the URL are included.
#CacheConfig_KeyCreatorParams: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.cache.v3.CacheConfig_KeyCreatorParams"
	// If true, exclude the URL scheme from the cache key. Set to true if your origins always
	// produce the same response for http and https requests.
	exclude_scheme?: bool
	// If true, exclude the host from the cache key. Set to true if your origins' responses don't
	// ever depend on host.
	exclude_host?: bool
	// If “query_parameters_included“ is nonempty, only query parameters matched
	// by one or more of its matchers are included in the cache key. Any other
	// query params will not affect cache lookup.
	query_parameters_included?: [...v31.#QueryParameterMatcher]
	// If “query_parameters_excluded“ is nonempty, query parameters matched by one
	// or more of its matchers are excluded from the cache key (even if also
	// matched by “query_parameters_included“), and will not affect cache lookup.
	query_parameters_excluded?: [...v31.#QueryParameterMatcher]
}
