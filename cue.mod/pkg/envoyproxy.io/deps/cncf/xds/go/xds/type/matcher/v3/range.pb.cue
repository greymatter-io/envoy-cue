package v3

import (
	v3 "envoyproxy.io/deps/cncf/xds/go/xds/type/v3"
)

#Int64RangeMatcher: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.Int64RangeMatcher"
	range_matchers?: [...#Int64RangeMatcher_RangeMatcher]
}

#Int32RangeMatcher: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.Int32RangeMatcher"
	range_matchers?: [...#Int32RangeMatcher_RangeMatcher]
}

#DoubleRangeMatcher: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.DoubleRangeMatcher"
	range_matchers?: [...#DoubleRangeMatcher_RangeMatcher]
}

#Int64RangeMatcher_RangeMatcher: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.Int64RangeMatcher_RangeMatcher"
	ranges?: [...v3.#Int64Range]
	on_match?: #Matcher_OnMatch
}

#Int32RangeMatcher_RangeMatcher: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.Int32RangeMatcher_RangeMatcher"
	ranges?: [...v3.#Int32Range]
	on_match?: #Matcher_OnMatch
}

#DoubleRangeMatcher_RangeMatcher: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.DoubleRangeMatcher_RangeMatcher"
	ranges?: [...v3.#DoubleRange]
	on_match?: #Matcher_OnMatch
}
