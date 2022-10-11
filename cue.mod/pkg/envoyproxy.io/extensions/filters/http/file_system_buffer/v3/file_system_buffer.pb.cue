package v3

import (
	v3 "envoyproxy.io/extensions/common/async_files/v3"
)

// The behavior of the filter for a stream.
// [#next-free-field: 6]
#BufferBehavior: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_system_buffer.v3.BufferBehavior"
	// Don't inject ``content-length`` header.
	// Output immediately, buffer only if output is slower than input.
	stream_when_possible?: #BufferBehavior_StreamWhenPossible
	// Never buffer, do nothing.
	bypass?: #BufferBehavior_Bypass
	// If ``content-length`` is not present, buffer the entire input,
	// inject ``content-length`` header, then output.
	// If ``content-length`` is already present, act like ``stream_when_possible``.
	inject_content_length_if_necessary?: #BufferBehavior_InjectContentLengthIfNecessary
	// Always buffer the entire input, and inject ``content-length``,
	// overwriting any provided content-length header.
	fully_buffer_and_always_inject_content_length?: #BufferBehavior_FullyBufferAndAlwaysInjectContentLength
	// Always buffer the entire input, do not modify ``content-length``.
	fully_buffer?: #BufferBehavior_FullyBuffer
}

// The configuration for one direction of the filter behavior.
#StreamConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_system_buffer.v3.StreamConfig"
	// Whether to bypass / stream / fully buffer / etc.
	// If unset in route, vhost and listener config, the default is ``stream_when_possible``.
	behavior?: #BufferBehavior
	// The amount stored in the memory buffer before buffering to disk.
	// If unset in route, vhost and listener config, defaults to a hardcoded value of 1MiB
	memory_buffer_bytes_limit?: uint64
	// The maximum storage (excluding memory) to be buffered in this filter.
	// If unset in route, vhost and listener config, defaults to a hardcoded value of 32MiB
	storage_buffer_bytes_limit?: uint64
	// The maximum amount that can be queued for writing to storage, above which the
	// source is requested to pause. If unset, defaults to the same value as
	// ``memory_buffer_bytes_limit``.
	//
	// For example, assuming the recipient is not consuming data at all, if
	// ``memory_buffer_bytes_limit`` was 32MiB, and ``storage_buffer_queue_high_watermark_bytes``
	// was 64MiB, and the filesystem is backed up so writes are not occurring promptly,
	// then:
	//
	// * Any request less than 32MiB will eventually pass through without ever attempting
	//   to write to disk.
	// * Any request with over 32MiB buffered will start trying to write to disk.
	//   If it reaches (32+64)MiB buffered in memory (write to disk isn't keeping up), a high
	//   watermark signal is sent to the source.
	// * Any stream whose total size exceeds
	//   ``memory_buffer_bytes_limit + storage_buffer_bytes_limit`` will provoke an error.
	//   (Note, if the recipient *is* consuming data then it is possible for such an
	//   oversized request to pass through the buffer filter, provided the recipient
	//   isn't consuming data too slowly.)
	//
	// The low watermark signal is sent when the memory buffer is at size
	// ``memory_buffer_bytes_limit + (storage_buffer_queue_high_watermark_bytes / 2)``.
	storage_buffer_queue_high_watermark_bytes?: uint64
}

// A :ref:`file system buffer <config_http_filters_file_system_buffer>` filter configuration.
//
// Route-specific configs override only the fields they explicitly include; unset
// fields inherit from the vhost or listener-level config, or, if never set,
// and not required, use a default value.
#FileSystemBufferFilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_system_buffer.v3.FileSystemBufferFilterConfig"
	// A configuration for an AsyncFileManager.
	//
	// If unset in route, vhost and listener, and the behavior is not ``bypass``
	// in both directions, an Internal Server Error response will be sent.
	manager_config?: v3.#AsyncFileManagerConfig
	// An optional path to which the unlinked files should be written - this may
	// determine which physical storage device will be used.
	//
	// If unset in route, vhost and listener, will use the environment variable
	// ``TMPDIR``, or, if that's also unset, will use ``/tmp``.
	storage_buffer_path?: string
	// Optional configuration for how to buffer (or not) requests.
	// If unset in route, vhost and listener, ``StreamConfig`` default values will be used
	// (with behavior ``stream_when_possible``)
	request?: #StreamConfig
	// Optional configuration for how to buffer (or not) responses.
	// If unset in route, vhost and listener, ``StreamConfig`` default values will be used
	// (with behavior ``stream_when_possible``)
	response?: #StreamConfig
}

#BufferBehavior_StreamWhenPossible: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_system_buffer.v3.BufferBehavior_StreamWhenPossible"
}

#BufferBehavior_Bypass: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_system_buffer.v3.BufferBehavior_Bypass"
}

#BufferBehavior_InjectContentLengthIfNecessary: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_system_buffer.v3.BufferBehavior_InjectContentLengthIfNecessary"
}

#BufferBehavior_FullyBufferAndAlwaysInjectContentLength: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_system_buffer.v3.BufferBehavior_FullyBufferAndAlwaysInjectContentLength"
}

#BufferBehavior_FullyBuffer: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.file_system_buffer.v3.BufferBehavior_FullyBuffer"
}
