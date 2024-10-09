package v3

import (
	v3 "envoyproxy.io/extensions/outlier_detection_monitors/common/v3"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// Monitor which counts consecutive errors.
// If number of consecutive errors exceeds the threshold, monitor will report that the host
// is unhealthy.
// [#not-implemented-hide:]
#ConsecutiveErrors: {
	"@type": "type.googleapis.com/envoy.extensions.outlier_detection_monitors.consecutive_errors.v3.ConsecutiveErrors"
	// Monitor name.
	name?: string
	// The number of consecutive errors before ejection occurs.
	threshold?: wrapperspb.#UInt32Value
	// The % chance that a host is actually ejected. Defaults to 100.
	enforcing?: wrapperspb.#UInt32Value
	// Error buckets.
	error_buckets?: v3.#ErrorBuckets
}
