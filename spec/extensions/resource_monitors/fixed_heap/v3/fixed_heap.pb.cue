package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// The fixed heap resource monitor reports the Envoy process memory pressure, computed as a
// fraction of currently reserved heap memory divided by a statically configured maximum
// specified in the FixedHeapConfig.
#FixedHeapConfig: {
	"@type": "type.googleapis.com/envoy.extensions.resource_monitors.fixed_heap.v3.FixedHeapConfig"
	// Static value for max heap size in bytes set at startup.
	// Exactly one of max_heap_size_bytes or max_heap_size_bytes_runtime must be set.
	// If set, the expected value must be greater than “0“, otherwise validation will fail.
	max_heap_size_bytes?: uint64
	// Runtime overlay for max heap size in bytes. When set, the value can be overridden
	// at runtime during startup or later without restart.
	// Exactly one of max_heap_size_bytes or max_heap_size_bytes_runtime must be set.
	// If set, the expected value must be greater than “0“, otherwise validation will fail.
	max_heap_size_bytes_runtime?: v3.#RuntimeUInt64
}
