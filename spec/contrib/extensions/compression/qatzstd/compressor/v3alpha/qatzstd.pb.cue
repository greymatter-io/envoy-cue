package v3alpha

// Reference to http://facebook.github.io/zstd/zstd_manual.html
#Qatzstd_Strategy: "DEFAULT" | "FAST" | "DFAST" | "GREEDY" | "LAZY" | "LAZY2" | "BTLAZY2" | "BTOPT" | "BTULTRA" | "BTULTRA2"

Qatzstd_Strategy_DEFAULT:  "DEFAULT"
Qatzstd_Strategy_FAST:     "FAST"
Qatzstd_Strategy_DFAST:    "DFAST"
Qatzstd_Strategy_GREEDY:   "GREEDY"
Qatzstd_Strategy_LAZY:     "LAZY"
Qatzstd_Strategy_LAZY2:    "LAZY2"
Qatzstd_Strategy_BTLAZY2:  "BTLAZY2"
Qatzstd_Strategy_BTOPT:    "BTOPT"
Qatzstd_Strategy_BTULTRA:  "BTULTRA"
Qatzstd_Strategy_BTULTRA2: "BTULTRA2"

// [#next-free-field: 8]
#Qatzstd: {
	"@type": "type.googleapis.com/envoy.extensions.compression.qatzstd.compressor.v3alpha.Qatzstd"
	// Set compression parameters according to pre-defined compression level table.
	// Note that exact compression parameters are dynamically determined,
	// depending on both compression level and source content size (when known).
	// Value 0 means default, and default level is 3.
	//
	// Setting a level does not automatically set all other compression parameters
	// to default. Setting this will however eventually dynamically impact the compression
	// parameters which have not been manually set. The manually set
	// ones will 'stick'.
	compression_level?: uint32
	// A 32-bits checksum of content is written at end of frame. If not set, defaults to false.
	enable_checksum?: bool
	// The higher the value of selected strategy, the more complex it is,
	// resulting in stronger and slower compression.
	//
	// Special: value 0 means "use default strategy".
	strategy?: #Qatzstd_Strategy
	// Value for compressor's next output buffer. If not set, defaults to 4096.
	chunk_size?: uint32
	// Enable QAT to accelerate Zstd compression or not. If not set, defaults to false.
	//
	// This is useful in the case that users want to enable QAT for a period of time and disable QAT for another period of time,
	// they don't have to change the config too much or prepare for another config that has software zstd compressor and just changing the value of this filed.
	enable_qat_zstd?: bool
	// Fallback to software for Qatzstd when input size is less than this value.
	// Valid only “enable_qat_zstd“ is “true“. 0 means no fallback at all. If not set, defaults to 4000.
	qat_zstd_fallback_threshold?: uint32
}
