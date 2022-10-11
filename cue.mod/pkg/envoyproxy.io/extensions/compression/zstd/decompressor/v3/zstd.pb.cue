package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#Zstd: {
	"@type": "type.googleapis.com/envoy.extensions.compression.zstd.decompressor.v3.Zstd"
	// Dictionaries for decompression. Zstd offers dictionary compression, which greatly improves
	// efficiency on small files and messages. It is necessary to ensure that the dictionary used for
	// decompression is the same as the compression dictionary. Multiple dictionaries can be set, and the
	// dictionary will be automatically selected for decompression according to the dictionary ID in the
	// source content.
	// Please refer to `zstd manual <https://github.com/facebook/zstd/blob/dev/programs/zstd.1.md#dictionary-builder>`_
	// to train specific dictionaries for decompression.
	dictionaries?: [...v3.#DataSource]
	// Value for decompressor's next output buffer. If not set, defaults to 4096.
	chunk_size?: uint32
}
