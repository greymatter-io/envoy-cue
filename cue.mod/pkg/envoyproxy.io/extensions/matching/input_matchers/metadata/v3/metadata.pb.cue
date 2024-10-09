package v3

import (
	v3 "envoyproxy.io/type/matcher/v3"
)

// Metadata matcher for metadata from http matching input data.
#Metadata: {
	"@type": "type.googleapis.com/envoy.extensions.matching.input_matchers.metadata.v3.Metadata"
	// The Metadata is matched if the value retrieved by metadata matching input is matched to this value.
	value?: v3.#ValueMatcher
	// If true, the match result will be inverted.
	invert?: bool
}
