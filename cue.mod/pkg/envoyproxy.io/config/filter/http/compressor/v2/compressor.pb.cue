package v2

import (
	core "envoyproxy.io/api/v2/core"
)

// [#next-free-field: 6]
#Compressor: {
	"@type": "type.googleapis.com/envoy.config.filter.http.compressor.v2.Compressor"
	// Minimum response length, in bytes, which will trigger compression. The default value is 30.
	content_length?: uint32
	// Set of strings that allows specifying which mime-types yield compression; e.g.,
	// application/json, text/html, etc. When this field is not defined, compression will be applied
	// to the following mime-types: "application/javascript", "application/json",
	// "application/xhtml+xml", "image/svg+xml", "text/css", "text/html", "text/plain", "text/xml"
	// and their synonyms.
	content_type?: [...string]
	// If true, disables compression when the response contains an etag header. When it is false, the
	// filter will preserve weak etags and remove the ones that require strong validation.
	disable_on_etag_header?: bool
	// If true, removes accept-encoding from the request headers before dispatching it to the upstream
	// so that responses do not get compressed before reaching the filter.
	// .. attention:
	//
	//    To avoid interfering with other compression filters in the same chain use this option in
	//    the filter closest to the upstream.
	remove_accept_encoding_header?: bool
	// Runtime flag that controls whether the filter is enabled or not. If set to false, the
	// filter will operate as a pass-through filter. If not specified, defaults to enabled.
	runtime_enabled?: core.#RuntimeFeatureFlag
}
