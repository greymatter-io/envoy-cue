package v2alpha

// Proto representation of the statistics collected upon absl::Mutex contention, if Envoy is run
// under :option:`--enable-mutex-tracing`. For more information, see the `absl::Mutex`
// [docs](https://abseil.io/about/design/mutex#extra-features).
//
// *NB*: The wait cycles below are measured by `absl::base_internal::CycleClock`, and may not
// correspond to core clock frequency. For more information, see the `CycleClock`
// [docs](https://github.com/abseil/abseil-cpp/blob/master/absl/base/internal/cycleclock.h).
#MutexStats: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.MutexStats"
	// The number of individual mutex contentions which have occurred since startup.
	num_contentions?: uint64
	// The length of the current contention wait cycle.
	current_wait_cycles?: uint64
	// The lifetime total of all contention wait cycles.
	lifetime_wait_cycles?: uint64
}
