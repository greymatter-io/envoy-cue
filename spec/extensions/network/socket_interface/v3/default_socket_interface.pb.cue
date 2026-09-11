package v3

// Configuration for the default socket interface that relies on OS-dependent syscalls to create
// sockets.
#DefaultSocketInterface: {
	"@type": "type.googleapis.com/envoy.extensions.network.socket_interface.v3.DefaultSocketInterface"
	// Options for “io_uring“-based socket I/O. “io_uring“ is only supported on Linux with
	// kernel version 5.11 or later. On unsupported platforms, Envoy falls back to the default
	// socket API.
	//
	// .. note::
	//
	//	If not set, ``io_uring`` will not be enabled and the standard epoll-based I/O path
	//	is used.
	io_uring_options?: #IoUringOptions
}

// Configuration for “io_uring“-based asynchronous I/O.
//
// Each worker thread creates its own “io_uring“ instance during initialization. Operations
// are submitted to the submission queue (SQ) and completions are reaped from the completion
// queue (CQ) via an eventfd integrated with the worker's event loop.
//
// .. warning::
//
//	``io_uring`` support is experimental and its performance characteristics depend heavily on
//	the kernel version.
//
// [#next-free-field: 8]
#IoUringOptions: {
	"@type": "type.googleapis.com/envoy.extensions.network.socket_interface.v3.IoUringOptions"
	// The number of entries in the “io_uring“ submission queue (SQ). Each in-flight I/O
	// operation requires one SQE. The completion queue (CQ) is sized at “2x“ this value
	// to provide overflow headroom. If not specified, defaults to 1000.
	io_uring_size?: uint32
	// Enables “io_uring“ submission queue polling (“SQPOLL“). When enabled, a dedicated
	// kernel thread polls the SQ for new entries, eliminating the “io_uring_enter()“ syscall
	// on submission. This may reduce latency at the cost of increased CPU usage.
	// If not specified, defaults to false.
	enable_submission_queue_polling?: bool
	// The starting size in bytes of the buffer for each “readv“-based “io_uring“ read. Envoy
	// grows the next read up to 16 times this size while reads keep filling the buffer and resets it
	// otherwise, so large transfers use fewer reads. When “enable_multishot_receive“ is set, this
	// is also the size of each kernel-provided buffer. If not specified, defaults to 8192.
	read_buffer_size?: uint32
	// The timeout in milliseconds to wait for pending write operations to complete when closing
	// a socket. “io_uring“ writes are asynchronous. If the remote peer stops reading, a write
	// may never complete. After this timeout, pending writes are canceled and the socket is
	// closed. If not specified, defaults to 1000.
	write_timeout_ms?: uint32
	// The high watermark in bytes for the write buffer. When the amount of pending write data
	// exceeds this threshold, the socket stops accepting new writes from the connection so that
	// backpressure propagates to the upper layers. If not specified, defaults to 131072 (128 KiB).
	// When set, the value must be at least 4096 (4 KiB).
	write_high_watermark_bytes?: uint32
	// The low watermark in bytes for the write buffer. After the buffer has exceeded
	// “write_high_watermark_bytes“ and writes were paused, the socket resumes accepting writes
	// once the pending write data drops to or below this value.
	// If not specified, defaults to 16384 (16 KiB).
	// When set, the value must be at least 1024 (1 KiB).
	//
	// .. note::
	//
	//	This value must be less than ``write_high_watermark_bytes``. If misconfigured, it is
	//	clamped to ``write_high_watermark_bytes / 2``.
	write_low_watermark_bytes?: uint32
	// Enables “multishot“ reads backed by a kernel-provided buffer ring. A single “recv“ is armed
	// per socket and the kernel keeps delivering data as it arrives without a new submission per
	// read, which reduces event loop wakeups and read submissions for read-heavy workloads. The ring
	// holds “io_uring_size“ buffers rounded up to a power of two and capped at 4096, each
	// “read_buffer_size“ bytes, so each worker thread uses up to that buffer count times
	// “read_buffer_size“ bytes for the pool. Requires Linux kernel 6.0 or later. On older kernels,
	// Envoy falls back to “readv“-based reads. If not specified, defaults to false.
	enable_multishot_receive?: bool
}
