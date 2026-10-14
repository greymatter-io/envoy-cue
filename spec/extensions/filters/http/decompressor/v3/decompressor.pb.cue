package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#Decompressor: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.decompressor.v3.Decompressor"
	// A decompressor library to use for both request and response decompression. Currently only
	// :ref:`envoy.compression.gzip.compressor<envoy_v3_api_msg_extensions.compression.gzip.decompressor.v3.Gzip>`
	// is included in Envoy.
	// [#extension-category: envoy.compression.decompressor]
	decompressor_library?: v3.#TypedExtensionConfig
	// Configuration for request decompression. Decompression is enabled by default if left empty.
	request_direction_config?: #Decompressor_RequestDirectionConfig
	// Configuration for response decompression. Decompression is enabled by default if left empty.
	response_direction_config?: #Decompressor_ResponseDirectionConfig
}

// Common configuration for filter behavior on both the request and response direction.
#Decompressor_CommonDirectionConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.decompressor.v3.Decompressor_CommonDirectionConfig"
	// Runtime flag that controls whether the filter is enabled for decompression or not. If set to false, the
	// filter will operate as a pass-through filter. If the message is unspecified, the filter will be enabled.
	enabled?: v3.#RuntimeFeatureFlag
	// If set to true, will decompress response even if a ``no-transform`` cache control header is set.
	ignore_no_transform_header?: bool
}

// Configuration for filter behavior on the request direction.
#Decompressor_RequestDirectionConfig: {
	"@type":        "type.googleapis.com/envoy.extensions.filters.http.decompressor.v3.Decompressor_RequestDirectionConfig"
	common_config?: #Decompressor_CommonDirectionConfig
	// If set to true, and response decompression is enabled, the filter modifies the Accept-Encoding
	// request header by appending the decompressor_library's encoding. Defaults to true.
	advertise_accept_encoding?: bool
}

// Configuration for filter behavior on the response direction.
#Decompressor_ResponseDirectionConfig: {
	"@type":        "type.googleapis.com/envoy.extensions.filters.http.decompressor.v3.Decompressor_ResponseDirectionConfig"
	common_config?: #Decompressor_CommonDirectionConfig
}
