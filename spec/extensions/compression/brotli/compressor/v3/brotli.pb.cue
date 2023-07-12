package v3

#Brotli_EncoderMode: "DEFAULT" | "GENERIC" | "TEXT" | "FONT"

Brotli_EncoderMode_DEFAULT: "DEFAULT"
Brotli_EncoderMode_GENERIC: "GENERIC"
Brotli_EncoderMode_TEXT:    "TEXT"
Brotli_EncoderMode_FONT:    "FONT"

// [#next-free-field: 7]
#Brotli: {
	"@type": "type.googleapis.com/envoy.extensions.compression.brotli.compressor.v3.Brotli"
	// Value from 0 to 11 that controls the main compression speed-density lever.
	// The higher quality, the slower compression. The default value is 3.
	quality?: uint32
	// A value used to tune encoder for specific input. For more information about modes,
	// please refer to brotli manual: https://brotli.org/encode.html#aa6f
	// This field will be set to "DEFAULT" if not specified.
	encoder_mode?: #Brotli_EncoderMode
	// Value from 10 to 24 that represents the base two logarithmic of the compressor's window size.
	// Larger window results in better compression at the expense of memory usage. The default is 18.
	// For more details about this parameter, please refer to brotli manual:
	// https://brotli.org/encode.html#a9a8
	window_bits?: uint32
	// Value from 16 to 24 that represents the base two logarithmic of the compressor's input block
	// size. Larger input block results in better compression at the expense of memory usage. The
	// default is 24. For more details about this parameter, please refer to brotli manual:
	// https://brotli.org/encode.html#a9a8
	input_block_bits?: uint32
	// Value for compressor's next output buffer. If not set, defaults to 4096.
	chunk_size?: uint32
	// If true, disables "literal context modeling" format feature.
	// This flag is a "decoding-speed vs compression ratio" trade-off.
	disable_literal_context_modeling?: bool
}
