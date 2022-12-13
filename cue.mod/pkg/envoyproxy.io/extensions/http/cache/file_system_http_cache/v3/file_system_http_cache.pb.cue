package v3

import (
	v3 "envoyproxy.io/extensions/common/async_files/v3"
)

// Configuration for a cache implementation that caches in the local file system.
//
// By default this cache uses a least-recently-used eviction strategy.
// [#next-free-field: 7]
#FileSystemHttpCacheConfig: {
	"@type": "type.googleapis.com/envoy.extensions.http.cache.file_system_http_cache.v3.FileSystemHttpCacheConfig"
	// Configuration of a manager for how the file system is used asynchronously.
	manager_config?: v3.#AsyncFileManagerConfig
	// Path at which the cache files will be stored.
	//
	// This also doubles as the unique identifier for a cache, so a cache can be shared
	// between different routes, or separate paths can be used to specify separate caches.
	//
	// If the same ``cache_path`` is used in more than one ``CacheConfig``, the rest of the
	// ``FileSystemHttpCacheConfig`` must also match, and will refer to the same cache
	// instance.
	cache_path?: string
	// The maximum size of the cache in bytes - when reached, another entry is removed.
	//
	// This is measured as the sum of file sizes, such that it includes headers, trailers,
	// and metadata, but does not include e.g. file system overhead and block size padding.
	//
	// If unset there is no limit except file system failure.
	//
	// [#not-implemented-hide:]
	max_cache_size_bytes?: uint64
	// The maximum size of a cache entry in bytes - larger responses will not be cached.
	//
	// This is measured as the file size for the cache entry, such that it includes
	// headers, trailers, and metadata.
	//
	// If unset there is no limit.
	//
	// [#not-implemented-hide:]
	max_cache_entry_size_bytes?: uint64
	// The maximum number of cache entries - when reached, another entry is removed.
	//
	// If unset there is no limit.
	//
	// [#not-implemented-hide:]
	max_cache_entry_count?: uint64
	// A number of folders into which to subdivide the cache.
	//
	// Setting this can help with performance in file systems where a large number of inodes
	// in a single branch degrades performance. The optimal value in that case would be
	// ``sqrt(expected_cache_entry_count)``.
	//
	// On file systems that perform well with many inodes, the default value of 1 should be used.
	//
	// [#not-implemented-hide:]
	cache_subdivisions?: uint32
}
