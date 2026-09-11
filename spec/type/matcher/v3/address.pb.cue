package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/core/v3"
)

// Match an IP against a repeated CIDR range. This matcher is intended to be
// used in other matchers, for example in the filter state matcher to match a
// filter state object as an IP.
#AddressMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.AddressMatcher"
	ranges?: [...v3.#CidrRange]
	// If true, the match result will be inverted. Defaults to false.
	//
	// * If set to false (default), the matcher will return true if the IP matches any of the CIDR ranges.
	// * If set to true, the matcher will return true if the IP does NOT match any of the CIDR ranges.
	invert_match?: bool
}
