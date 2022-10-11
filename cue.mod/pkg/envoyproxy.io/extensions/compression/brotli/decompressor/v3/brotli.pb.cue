package v3

#Brotli: {
	"@type": "type.googleapis.com/envoy.extensions.compression.brotli.decompressor.v3.Brotli"
	// If true, disables "canny" ring buffer allocation strategy.
	// Ring buffer is allocated according to window size, despite the real size of the content.
	disable_ring_buffer_reallocation?: bool
	// Value for decompressor's next output buffer. If not set, defaults to 4096.
	chunk_size?: uint32
}
