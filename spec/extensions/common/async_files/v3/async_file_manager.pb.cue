package v3

// Configuration to instantiate or select a singleton ``AsyncFileManager``.
#AsyncFileManagerConfig: {
	"@type": "type.googleapis.com/envoy.extensions.common.async_files.v3.AsyncFileManagerConfig"
	// An optional identifier for the manager. An empty string is a valid identifier
	// for a common, default ``AsyncFileManager``.
	//
	// Reusing the same id with different configurations in the same envoy instance
	// is an error.
	id?: string
	// Configuration for a thread-pool based async file manager.
	thread_pool?: #AsyncFileManagerConfig_ThreadPool
}

#AsyncFileManagerConfig_ThreadPool: {
	"@type": "type.googleapis.com/envoy.extensions.common.async_files.v3.AsyncFileManagerConfig_ThreadPool"
	// The number of threads to use. If unset or zero, will default to the number
	// of concurrent threads the hardware supports. This default is subject to
	// change if performance analysis suggests it.
	thread_count?: uint32
}
