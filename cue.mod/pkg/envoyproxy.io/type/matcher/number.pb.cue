package matcher

import (
	_type "envoyproxy.io/type"
)

// Specifies the way to match a double value.
#DoubleMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.DoubleMatcher"
	// If specified, the input double value must be in the range specified here.
	// Note: The range is using half-open interval semantics [start, end).
	range?: _type.#DoubleRange
	// If specified, the input double value must be equal to the value specified here.
	exact?: float64
}
