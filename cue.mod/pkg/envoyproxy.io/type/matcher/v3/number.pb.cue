package v3

import (
	v3 "envoyproxy.io/type/v3"
)

// Specifies the way to match a double value.
#DoubleMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.DoubleMatcher"
	// If specified, the input double value must be in the range specified here.
	// Note: The range is using half-open interval semantics [start, end).
	range?: v3.#DoubleRange
	// If specified, the input double value must be equal to the value specified here.
	exact?: float64
}
