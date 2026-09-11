package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/route/v3"
)

// [#extension: envoy.filters.http.cache_v2]
// [#next-free-field: 8]
#CacheV2Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.cache_v2.v3.CacheV2Config"
	// Config specific to the cache storage implementation. Required unless “disabled“
	// is true.
	// [#extension-category: envoy.http.cache_v2]
	typed_config?: _
	// When true, the cache filter is a no-op filter.
	//
	// Possible use-cases for this include:
	// - Turning a filter on and off with :ref:`ECDS <envoy_v3_api_file_envoy/service/extension/v3/config_discovery.proto>`.
	// [#comment: once route-specific overrides are implemented, they are the more likely use-case.]
	disabled?: bool
	// [#not-implemented-hide:]
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
	key_creator_params?: #CacheV2Config_KeyCreatorParams
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
	// If this is set, requests sent upstream to populate the cache will go to the
	// specified cluster rather than the cluster selected by the vhost and route.
	//
	// If you have actions to be taken by the router filter - either
	// “upstream_http_filters“ or one of the “RouteConfiguration“ actions such as
	// “response_headers_to_add“ - then the cache's side-channel going directly to the
	// routed cluster will bypass these actions. You can set “override_upstream_cluster“
	// to an internal listener which duplicates the relevant “RouteConfiguration“, to
	// replicate the desired behavior on the side-channel upstream request issued by the
	// cache.
	//
	// This is a workaround for implementation constraints which it is hoped will at some
	// point become unnecessary, then unsupported and this field will be removed.
	override_upstream_cluster?: string
}

// [#not-implemented-hide:]
// Modifies cache key creation by restricting which parts of the URL are included.
#CacheV2Config_KeyCreatorParams: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.cache_v2.v3.CacheV2Config_KeyCreatorParams"
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
