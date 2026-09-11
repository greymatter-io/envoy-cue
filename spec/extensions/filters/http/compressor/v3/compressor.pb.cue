package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// [#next-free-field: 10]
#Compressor: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.Compressor"
	// Minimum response length, in bytes, which will trigger compression. The default value is 30.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/http/compressor/v3/compressor.proto.
	content_length?: uint32
	// Set of strings that allows specifying which mime-types yield compression; e.g.,
	// “application/json“, “text/html“, etc.
	//
	// When this field is not specified, compression will be applied to these following mime-types
	// and their synonyms:
	//
	// * “application/javascript“
	// * “application/json“
	// * “application/xhtml+xml“
	// * “image/svg+xml“
	// * “text/css“
	// * “text/html“
	// * “text/plain“
	// * “text/xml“
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/http/compressor/v3/compressor.proto.
	content_type?: [...string]
	// When this field is “true“, disables compression when the response contains an “ETag“ header.
	// When this field is “false“, the filter will preserve weak “ETag“ values and remove those that
	// require strong validation.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/http/compressor/v3/compressor.proto.
	disable_on_etag_header?: bool
	// When this field is “true“, removes “Accept-Encoding“ from the request headers before dispatching
	// the request to the upstream so that responses do not get compressed before reaching the filter.
	//
	// .. attention::
	//
	//	To avoid interfering with other compression filters in the same chain, use this option in
	//	the filter closest to the upstream.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/http/compressor/v3/compressor.proto.
	remove_accept_encoding_header?: bool
	// Runtime flag that controls whether the filter is enabled. When this field is “false“, the
	// filter will operate as a pass-through filter, unless overridden by “CompressorPerRoute“.
	// If this field is not specified, the filter is enabled by default.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/http/compressor/v3/compressor.proto.
	runtime_enabled?: v3.#RuntimeFeatureFlag
	// A compressor library to use for compression.
	// [#extension-category: envoy.compression.compressor]
	compressor_library?: v3.#TypedExtensionConfig
	// Configuration for request compression. If this field is not specified, request compression is disabled.
	request_direction_config?: #Compressor_RequestDirectionConfig
	// Configuration for response compression. If this field is not specified, response compression is enabled.
	//
	// .. attention::
	//
	//	When this field is set, duplicate deprecated fields of the ``Compressor`` message,
	//	such as ``content_length``, ``content_type``, ``disable_on_etag_header``,
	//	``remove_accept_encoding_header``, and ``runtime_enabled``, are ignored.
	//
	//	Additionally, all statistics related to response compression will be rooted in
	//	``<stat_prefix>.compressor.<compressor_library.name>.<compressor_library_stat_prefix>.response.*``
	//	instead of
	//	``<stat_prefix>.compressor.<compressor_library.name>.<compressor_library_stat_prefix>.*``.
	response_direction_config?: #Compressor_ResponseDirectionConfig
	// When this field is “true“, this compressor is preferred when q-values in “Accept-Encoding“ are equal.
	// If multiple compressor filters set “choose_first“ to “true“, the last one in the filter chain is chosen.
	choose_first?: bool
}

// Per-route overrides of “ResponseDirectionConfig“. Anything added here should be optional,
// to allow overriding arbitrary subsets of configuration. Omitted fields must have no effect.
#ResponseDirectionOverrides: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.ResponseDirectionOverrides"
	// If set, overrides the filter-level
	// :ref:`remove_accept_encoding_header<envoy_v3_api_field_extensions.filters.http.compressor.v3.Compressor.ResponseDirectionConfig.remove_accept_encoding_header>`.
	remove_accept_encoding_header?: bool
}

// Per-route overrides. As per-route overrides are needed, they should be
// added here, mirroring the structure of “Compressor“. All fields should be
// optional, to allow overriding arbitrary subsets of configuration.
#CompressorOverrides: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.CompressorOverrides"
	// If present, response compression is enabled.
	response_direction_config?: #ResponseDirectionOverrides
	// A compressor library to use for compression. If specified, this overrides
	// the filter-level “compressor_library“ configuration for this route.
	compressor_library?: v3.#TypedExtensionConfig
}

#CompressorPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.CompressorPerRoute"
	// If set, the filter will operate as a pass-through filter.
	// Overrides “Compressor.runtime_enabled“ and “CommonDirectionConfig.enabled“.
	disabled?: bool
	// Per-route overrides. Fields set here will override corresponding fields in “Compressor“.
	overrides?: #CompressorOverrides
}

#Compressor_CommonDirectionConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.Compressor_CommonDirectionConfig"
	// Runtime flag that controls whether compression is enabled for the direction this
	// common config is applied to. When this field is “false“, the filter will operate as a
	// pass-through filter in the chosen direction, unless overridden by “CompressorPerRoute“.
	// If this field is not specified, the filter will be enabled.
	enabled?: v3.#RuntimeFeatureFlag
	// Minimum value of the “Content-Length“ header in request or response messages (depending on the
	// direction this common config is applied to), in bytes, that will trigger compression. Defaults to 30.
	min_content_length?: uint32
	// Set of strings that allows specifying which mime-types yield compression; e.g.,
	// “application/json“, “text/html“, etc.
	//
	// When this field is not specified, compression will be applied to these following mime-types
	// and their synonyms:
	//
	// * “application/javascript“
	// * “application/json“
	// * “application/xhtml+xml“
	// * “image/svg+xml“
	// * “text/css“
	// * “text/html“
	// * “text/plain“
	// * “text/xml“
	content_type?: [...string]
}

// Configuration for filter behavior on the request direction.
#Compressor_RequestDirectionConfig: {
	"@type":        "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.Compressor_RequestDirectionConfig"
	common_config?: #Compressor_CommonDirectionConfig
}

// Configuration for filter behavior on the response direction.
// [#next-free-field: 7]
#Compressor_ResponseDirectionConfig: {
	"@type":        "type.googleapis.com/envoy.extensions.filters.http.compressor.v3.Compressor_ResponseDirectionConfig"
	common_config?: #Compressor_CommonDirectionConfig
	// When this field is “true“, disables compression when the response contains an “ETag“ header.
	// When this field is “false“, the filter will preserve weak “ETag“ values and remove those that
	// require strong validation (unless “weaken_etag_on_compress“ is set).
	// When both “disable_on_etag_header“ and “weaken_etag_on_compress“ are “true“,
	// “weaken_etag_on_compress“ takes precedence (compression is applied and the ETag is weakened).
	disable_on_etag_header?: bool
	// When this field is “true“ and the filter compresses a response that contains a strong
	// “ETag“, the filter will weaken the ETag by prepending “W/“ to its value instead of
	// removing it. This allows caching and conditional requests to work while indicating the
	// response body was modified by compression. When “false“ (default), strong ETags are
	// removed when compression is applied. When both “weaken_etag_on_compress“ and
	// “disable_on_etag_header“ are “true“, this field takes precedence so that compression
	// is applied and the ETag is weakened, supporting gradual rollout to clients and servers.
	weaken_etag_on_compress?: bool
	// When this field is “true“, removes “Accept-Encoding“ from the request headers before dispatching
	// the request to the upstream so that responses do not get compressed before reaching the filter.
	//
	// .. attention::
	//
	//	To avoid interfering with other compression filters in the same chain, use this option in
	//	the filter closest to the upstream.
	remove_accept_encoding_header?: bool
	// Set of response codes for which compression is disabled; e.g., 206 Partial Content should not
	// be compressed.
	uncompressible_response_codes?: [...uint32]
	// If true, the filter adds the “x-envoy-compression-status“ response
	// header to indicate whether the compression occurred and, if not, provide
	// the reason why. The header's value format is
	// “<encoder-type>;<status>[;<additional-params>]“, where “<status>“ is
	// “Compressed“ or the reason compression was skipped (e.g.,
	// “ContentLengthTooSmall“). When this field is enabled, the compressor
	// filter alters the order of the compression eligibility checks to report
	// the most valid reason for skipping the compression.
	status_header_enabled?: bool
}
