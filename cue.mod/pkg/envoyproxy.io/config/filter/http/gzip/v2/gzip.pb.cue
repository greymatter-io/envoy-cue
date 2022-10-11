package v2

import (
	v2 "envoyproxy.io/config/filter/http/compressor/v2"
)

#Gzip_CompressionStrategy: "DEFAULT" | "FILTERED" | "HUFFMAN" | "RLE"

Gzip_CompressionStrategy_DEFAULT:  "DEFAULT"
Gzip_CompressionStrategy_FILTERED: "FILTERED"
Gzip_CompressionStrategy_HUFFMAN:  "HUFFMAN"
Gzip_CompressionStrategy_RLE:      "RLE"

#Gzip_CompressionLevel_Enum: "DEFAULT" | "BEST" | "SPEED"

Gzip_CompressionLevel_Enum_DEFAULT: "DEFAULT"
Gzip_CompressionLevel_Enum_BEST:    "BEST"
Gzip_CompressionLevel_Enum_SPEED:   "SPEED"

// [#next-free-field: 11]
#Gzip: {
	"@type": "type.googleapis.com/envoy.config.filter.http.gzip.v2.Gzip"
	// Value from 1 to 9 that controls the amount of internal memory used by zlib. Higher values
	// use more memory, but are faster and produce better compression results. The default value is 5.
	memory_level?: uint32
	// Minimum response length, in bytes, which will trigger compression. The default value is 30.
	// .. attention:
	//
	//    **This field is deprecated**. Set the `compressor` field instead.
	//
	// Deprecated: Do not use.
	content_length?: uint32
	// A value used for selecting the zlib compression level. This setting will affect speed and
	// amount of compression applied to the content. "BEST" provides higher compression at the cost of
	// higher latency, "SPEED" provides lower compression with minimum impact on response time.
	// "DEFAULT" provides an optimal result between speed and compression. This field will be set to
	// "DEFAULT" if not specified.
	compression_level?: #Gzip_CompressionLevel_Enum
	// A value used for selecting the zlib compression strategy which is directly related to the
	// characteristics of the content. Most of the time "DEFAULT" will be the best choice, though
	// there are situations which changing this parameter might produce better results. For example,
	// run-length encoding (RLE) is typically used when the content is known for having sequences
	// which same data occurs many consecutive times. For more information about each strategy, please
	// refer to zlib manual.
	compression_strategy?: #Gzip_CompressionStrategy
	// Set of strings that allows specifying which mime-types yield compression; e.g.,
	// application/json, text/html, etc. When this field is not defined, compression will be applied
	// to the following mime-types: "application/javascript", "application/json",
	// "application/xhtml+xml", "image/svg+xml", "text/css", "text/html", "text/plain", "text/xml".
	// .. attention:
	//
	//    **This field is deprecated**. Set the `compressor` field instead.
	//
	// Deprecated: Do not use.
	content_type?: [...string]
	// If true, disables compression when the response contains an etag header. When it is false, the
	// filter will preserve weak etags and remove the ones that require strong validation.
	// .. attention:
	//
	//    **This field is deprecated**. Set the `compressor` field instead.
	//
	// Deprecated: Do not use.
	disable_on_etag_header?: bool
	// If true, removes accept-encoding from the request headers before dispatching it to the upstream
	// so that responses do not get compressed before reaching the filter.
	// .. attention:
	//
	//    **This field is deprecated**. Set the `compressor` field instead.
	//
	// Deprecated: Do not use.
	remove_accept_encoding_header?: bool
	// Value from 9 to 15 that represents the base two logarithmic of the compressor's window size.
	// Larger window results in better compression at the expense of memory usage. The default is 12
	// which will produce a 4096 bytes window. For more details about this parameter, please refer to
	// zlib manual > deflateInit2.
	window_bits?: uint32
	// Set of configuration parameters common for all compression filters. If this field is set then
	// the fields `content_length`, `content_type`, `disable_on_etag_header` and
	// `remove_accept_encoding_header` are ignored.
	compressor?: v2.#Compressor
}

#Gzip_CompressionLevel: {
	"@type": "type.googleapis.com/envoy.config.filter.http.gzip.v2.Gzip_CompressionLevel"
}
