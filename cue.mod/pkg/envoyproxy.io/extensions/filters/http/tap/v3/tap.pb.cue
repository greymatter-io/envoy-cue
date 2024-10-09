package v3

import (
	v3 "envoyproxy.io/extensions/common/tap/v3"
)

// Top level configuration for the tap filter.
#Tap: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.tap.v3.Tap"
	// Common configuration for the HTTP tap filter.
	common_config?: v3.#CommonExtensionConfig
	// Indicates whether HTTP tap filter records the time stamp for request/response headers.
	// Request headers time stamp is stored after receiving request headers.
	// Response headers time stamp is stored after receiving response headers.
	record_headers_received_time?: bool
	// Indicates whether report downstream connection info
	record_downstream_connection?: bool
}
