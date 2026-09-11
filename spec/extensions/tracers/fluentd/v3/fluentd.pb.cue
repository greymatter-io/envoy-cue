package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for the Fluentd tracer.
// This tracer extension will send the emitted traces over a TCP connection to an upstream that is accepting
// the Fluentd Forward Protocol as described in: `Fluentd Forward Protocol Specification
// <https://github.com/fluent/fluentd/wiki/Forward-Protocol-Specification-v1>`_.
// [#extension: envoy.tracers.fluentd]
// [#next-free-field: 7]
#FluentdConfig: {
	"@type": "type.googleapis.com/envoy.extensions.tracers.fluentd.v3.FluentdConfig"
	// The upstream cluster to connect to for streaming the Fluentd messages.
	cluster?: string
	// A tag is a string separated with “.“ (e.g. “log.type“) to categorize events.
	// See: https://github.com/fluent/fluentd/wiki/Forward-Protocol-Specification-v1#message-modes
	tag?: string
	// The prefix to use when emitting tracer stats.
	stat_prefix?: string
	// Interval for flushing traces to the TCP stream. Tracer will flush requests every time
	// this interval is elapsed, or when batch size limit is hit, whichever comes first. Defaults to
	// 1 second.
	buffer_flush_interval?: string
	// Soft size limit in bytes for access log entries buffer. The logger will buffer requests until
	// this limit it hit, or every time flush interval is elapsed, whichever comes first. When the buffer
	// limit is hit, the logger will immediately flush the buffer contents. Setting it to zero effectively
	// disables the batching. Defaults to 16384.
	buffer_size_bytes?: uint32
	// Optional retry, in case upstream connection has failed. If this field is not set, the default values will be applied.
	retry_policy?: v3.#RetryPolicy
}
