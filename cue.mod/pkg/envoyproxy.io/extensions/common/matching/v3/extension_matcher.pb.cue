package v3

import (
	v3 "envoyproxy.io/config/common/matcher/v3"
	v31 "envoyproxy.io/deps/cncf/xds/go/xds/type/matcher/v3"
	v32 "envoyproxy.io/config/core/v3"
)

// Wrapper around an existing extension that provides an associated matcher. This allows
// decorating an existing extension with a matcher, which can be used to match against
// relevant protocol data.
#ExtensionWithMatcher: {
	"@type": "type.googleapis.com/envoy.extensions.common.matching.v3.ExtensionWithMatcher"
	// The associated matcher. This is deprecated in favor of xds_matcher.
	//
	// Deprecated: Do not use.
	matcher?: v3.#Matcher
	// The associated matcher.
	xds_matcher?: v31.#Matcher
	// The underlying extension config.
	extension_config?: v32.#TypedExtensionConfig
}
