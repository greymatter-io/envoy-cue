package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// The runtime fraction matchers computes a hash from the input and matches if runtime feature is enabled
// for the the resulting hash. Every time the input is considered for a match, its hash must fall within
// the percentage of matches indicated by this field. For a fraction N/D, a number is computed as a hash
// of the input on a field in the range [0,D). If the number is less than or equal to the value of the
// numerator N, the matcher evaluates to true. A runtime_fraction input matcher can be used to gradually
// roll out matcher changes without requiring full code or configuration deployments.
// Note that distribution of matching results is only as good as one of the input.
#RuntimeFraction: {
	"@type": "type.googleapis.com/envoy.extensions.matching.input_matchers.runtime_fraction.v3.RuntimeFraction"
	// Match the input against the given runtime key. The specified default value is used if key is not
	// present in the runtime configuration.
	runtime_fraction?: v3.#RuntimeFractionalPercent
	// Optional seed passed through the hash function. This allows using additional information when computing
	// the hash value: by changing the seed value, a potentially different outcome can be achieved for the same input.
	seed?: uint64
}
