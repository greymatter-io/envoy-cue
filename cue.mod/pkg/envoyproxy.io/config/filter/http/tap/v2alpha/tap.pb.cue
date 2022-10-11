package v2alpha

import (
	v2alpha "envoyproxy.io/config/common/tap/v2alpha"
)

// Top level configuration for the tap filter.
#Tap: {
	"@type": "type.googleapis.com/envoy.config.filter.http.tap.v2alpha.Tap"
	// Common configuration for the HTTP tap filter.
	common_config?: v2alpha.#CommonExtensionConfig
}
