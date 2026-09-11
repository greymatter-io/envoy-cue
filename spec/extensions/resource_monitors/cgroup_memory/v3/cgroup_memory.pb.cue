package v3

#CgroupMemoryConfig: {
	"@type": "type.googleapis.com/envoy.extensions.resource_monitors.cgroup_memory.v3.CgroupMemoryConfig"
	// Optional max memory limit in bytes used for memory pressure calculations.
	// If set, this value is used as an upper bound on the memory limit, taking the minimum
	// between this value and the system's cgroup memory limit. If not set, the system's
	// cgroup memory limit is always used.
	max_memory_bytes?: uint64
}
