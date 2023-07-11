package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// [#next-free-field: 10]
#Compressor: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.Compressor"
	// Minimum response length, in bytes, which will trigger compression. The default value is 30.
	//
	// Deprecated: Do not use.
	content_length?: uint32
	// Set of strings that allows specifying which mime-types yield compression; e.g.,
	// application/json, text/html, etc. When this field is not defined, compression will be applied
	// to the following mime-types: "application/javascript", "application/json",
	// "application/xhtml+xml", "image/svg+xml", "text/css", "text/html", "text/plain", "text/xml"
	// and their synonyms.
	//
	// Deprecated: Do not use.
	content_type?: [...string]
	// If true, disables compression when the response contains an etag header. When it is false, the
	// filter will preserve weak etags and remove the ones that require strong validation.
	//
	// Deprecated: Do not use.
	disable_on_etag_header?: bool
	// If true, removes accept-encoding from the request headers before dispatching it to the upstream
	// so that responses do not get compressed before reaching the filter.
	//
	// .. attention::
	//
	//    To avoid interfering with other compression filters in the same chain use this option in
	//    the filter closest to the upstream.
	//
	// Deprecated: Do not use.
	remove_accept_encoding_header?: bool
	// Runtime flag that controls whether the filter is enabled or not. If set to false, the
	// filter will operate as a pass-through filter. If not specified, defaults to enabled.
	//
	// Deprecated: Do not use.
	runtime_enabled?: v3.#RuntimeFeatureFlag
	// A compressor library to use for compression. Currently only
	// :ref:`envoy.compression.gzip.compressor<envoy_v3_api_msg_extensions.compression.gzip.compressor.v3.Gzip>`
	// is included in Envoy.
	// [#extension-category: envoy.compression.compressor]
	compressor_library?: v3.#TypedExtensionConfig
	// Configuration for request compression. Compression is disabled by default if left empty.
	request_direction_config?: #Compressor_RequestDirectionConfig
	// Configuration for response compression. Compression is enabled by default if left empty.
	//
	// .. attention::
	//
	//    If the field is not empty then the duplicate deprecated fields of the ``Compressor`` message,
	//    such as ``content_length``, ``content_type``, ``disable_on_etag_header``,
	//    ``remove_accept_encoding_header`` and ``runtime_enabled``, are ignored.
	//
	//    Also all the statistics related to response compression will be rooted in
	//    ``<stat_prefix>.compressor.<compressor_library.name>.<compressor_library_stat_prefix>.response.*``
	//    instead of
	//    ``<stat_prefix>.compressor.<compressor_library.name>.<compressor_library_stat_prefix>.*``.
	response_direction_config?: #Compressor_ResponseDirectionConfig
	// If true, chooses this compressor first to do compression when the q-values in `Accept-Encoding` are same.
	// The last compressor which enables choose_first will be chosen if multiple compressor filters in the chain have choose_first as true.
	choose_first?: bool
}

#Compressor_CommonDirectionConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.Compressor_CommonDirectionConfig"
	// Runtime flag that controls whether compression is enabled or not for the direction this
	// common config is put in. If set to false, the filter will operate as a pass-through filter
	// in the chosen direction. If the field is omitted, the filter will be enabled.
	enabled?: v3.#RuntimeFeatureFlag
	// Minimum value of Content-Length header of request or response messages (depending on the direction
	// this common config is put in), in bytes, which will trigger compression. The default value is 30.
	min_content_length?: uint32
	// Set of strings that allows specifying which mime-types yield compression; e.g.,
	// application/json, text/html, etc. When this field is not defined, compression will be applied
	// to the following mime-types: "application/javascript", "application/json",
	// "application/xhtml+xml", "image/svg+xml", "text/css", "text/html", "text/plain", "text/xml"
	// and their synonyms.
	content_type?: [...string]
}

// Configuration for filter behavior on the request direction.
#Compressor_RequestDirectionConfig: {
	"@type":        "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.Compressor_RequestDirectionConfig"
	common_config?: #Compressor_CommonDirectionConfig
}

// Configuration for filter behavior on the response direction.
#Compressor_ResponseDirectionConfig: {
	"@type":        "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.Compressor_ResponseDirectionConfig"
	common_config?: #Compressor_CommonDirectionConfig
	// If true, disables compression when the response contains an etag header. When it is false, the
	// filter will preserve weak etags and remove the ones that require strong validation.
	disable_on_etag_header?: bool
	// If true, removes accept-encoding from the request headers before dispatching it to the upstream
	// so that responses do not get compressed before reaching the filter.
	//
	// .. attention::
	//
	//    To avoid interfering with other compression filters in the same chain use this option in
	//    the filter closest to the upstream.
	remove_accept_encoding_header?: bool
}
