package v3alpha

#Qatzip_HardwareBufferSize: "DEFAULT" | "SZ_4K" | "SZ_8K" | "SZ_32K" | "SZ_64K" | "SZ_128K" | "SZ_512K"

Qatzip_HardwareBufferSize_DEFAULT: "DEFAULT"
Qatzip_HardwareBufferSize_SZ_4K:   "SZ_4K"
Qatzip_HardwareBufferSize_SZ_8K:   "SZ_8K"
Qatzip_HardwareBufferSize_SZ_32K:  "SZ_32K"
Qatzip_HardwareBufferSize_SZ_64K:  "SZ_64K"
Qatzip_HardwareBufferSize_SZ_128K: "SZ_128K"
Qatzip_HardwareBufferSize_SZ_512K: "SZ_512K"

// [#next-free-field: 6]
#Qatzip: {
	"@type": "type.googleapis.com/envoy.extensions.compression.qatzip.compressor.v3alpha.Qatzip"
	// Value from 1 to 9 that controls the main compression speed-density lever.
	// The higher quality, the slower compression. The default value is 1.
	compression_level?: uint32
	// A size of qat hardware buffer. This field will be set to "DEFAULT" if not specified.
	hardware_buffer_size?: #Qatzip_HardwareBufferSize
	// Threshold of compression service’s input size for software failover.
	// If the size of input request less than the threshold, qatzip will route the request to software
	// compressor. The default value is 1024. The maximum value is 512*1024.
	input_size_threshold?: uint32
	// A size of stream buffer. The default value is 128 * 1024. The maximum value is 2*1024*1024 -
	// 5*1024
	stream_buffer_size?: uint32
	// Value for compressor's next output buffer. If not set, defaults to 4096.
	chunk_size?: uint32
}
