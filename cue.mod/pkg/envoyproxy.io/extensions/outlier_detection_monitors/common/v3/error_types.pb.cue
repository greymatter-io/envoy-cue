package v3

import (
	v3 "envoyproxy.io/type/v3"
)

// [#protodoc-title: Outlier detection error buckets]
// Error bucket for HTTP codes.
// [#not-implemented-hide:]
#HttpErrors: {
	"@type": "type.googleapis.com/envoy.extensions.outlier_detection_monitors.common.v3.HttpErrors"
	range?:  v3.#Int32Range
}

// Error bucket for locally originated errors.
// [#not-implemented-hide:]
#LocalOriginErrors: {
	"@type": "type.googleapis.com/envoy.extensions.outlier_detection_monitors.common.v3.LocalOriginErrors"
}

// Error bucket for database errors.
// Sub-parameters may be added later, like malformed response, error on write, etc.
// [#not-implemented-hide:]
#DatabaseErrors: {
	"@type": "type.googleapis.com/envoy.extensions.outlier_detection_monitors.common.v3.DatabaseErrors"
}

// Union of possible error buckets.
// [#not-implemented-hide:]
#ErrorBuckets: {
	"@type": "type.googleapis.com/envoy.extensions.outlier_detection_monitors.common.v3.ErrorBuckets"
	// List of buckets "catching" HTTP codes.
	http_errors?: [...#HttpErrors]
	// List of buckets "catching" locally originated errors.
	local_origin_errors?: [...#LocalOriginErrors]
	// List of buckets "catching" database errors.
	database_errors?: [...#DatabaseErrors]
}
