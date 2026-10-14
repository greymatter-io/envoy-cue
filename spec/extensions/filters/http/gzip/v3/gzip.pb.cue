package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/filters/http/compressor/v3"
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

// [#next-free-field: 12]
#Gzip: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gzip.v3.Gzip"
	// Value from 1 to 9 that controls the amount of internal memory used by zlib. Higher values
	// use more memory, but are faster and produce better compression results. The default value is 5.
	memory_level?: uint32
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
	// Value from 9 to 15 that represents the base two logarithmic of the compressor's window size.
	// Larger window results in better compression at the expense of memory usage. The default is 12
	// which will produce a 4096 bytes window. For more details about this parameter, please refer to
	// zlib manual > deflateInit2.
	window_bits?: uint32
	// Set of configuration parameters common for all compression filters. You can define
	// ``content_length``, ``content_type`` and other parameters in this field.
	compressor?: v3.#Compressor
	// Value for Zlib's next output buffer. If not set, defaults to 4096.
	// See https://www.zlib.net/manual.html for more details. Also see
	// https://github.com/envoyproxy/envoy/issues/8448 for context on this filter's performance.
	chunk_size?: uint32
}

#Gzip_CompressionLevel: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.gzip.v3.Gzip_CompressionLevel"
}
