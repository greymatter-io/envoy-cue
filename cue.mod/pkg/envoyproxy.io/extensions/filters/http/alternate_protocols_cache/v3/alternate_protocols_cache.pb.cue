package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// Configuration for the alternate protocols cache HTTP filter.
// [#extension: envoy.filters.http.alternate_protocols_cache]
#FilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.alternate_protocols_cache.v3.FilterConfig"
	// This field is ignored: the alternate protocols cache filter will use the
	// cache for the cluster the request is routed to.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/http/alternate_protocols_cache/v3/alternate_protocols_cache.proto.
	alternate_protocols_cache_options?: v3.#AlternateProtocolsCacheOptions
}
