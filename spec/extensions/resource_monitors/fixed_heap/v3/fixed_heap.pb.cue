package v3

// The fixed heap resource monitor reports the Envoy process memory pressure, computed as a
// fraction of currently reserved heap memory divided by a statically configured maximum
// specified in the FixedHeapConfig.
#FixedHeapConfig: {
	"@type":              "type.googleapis.com/envoy.extensions.resource_monitors.fixed_heap.v3.FixedHeapConfig"
	max_heap_size_bytes?: uint64
}
