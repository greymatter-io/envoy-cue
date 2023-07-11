package v3

// [#extension: envoy.key_value.file_based]
// This is configuration to flush a key value store out to disk.
#FileBasedKeyValueStoreConfig: {
	"@type": "type.googleapis.com/envoy.extensions.key_value.file_based.v3.FileBasedKeyValueStoreConfig"
	// The filename to read the keys and values from, and write the keys and
	// values to.
	filename?: string
	// The interval at which the key value store should be flushed to the file.
	flush_interval?: string
	// The maximum number of entries to cache, or 0 to allow for unlimited entries.
	// Defaults to 1000 if not present.
	max_entries?: uint32
}
