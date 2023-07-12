package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/common/tap/v3"
)

// Top level configuration for the tap filter.
#Tap: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.tap.v3.Tap"
	// Common configuration for the HTTP tap filter.
	common_config?: v3.#CommonExtensionConfig
}
