package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/type/v3"
)

#CelMatcher: {
	"@type":      "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.CelMatcher"
	expr_match?:  v3.#CelExpression
	description?: string
}
