package v3

import (
	v3 "envoyproxy.io/deps/cncf/xds/go/xds/core/v3"
)

#StringMatcher: {
	"@type":      "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.StringMatcher"
	exact?:       string
	prefix?:      string
	suffix?:      string
	safe_regex?:  #RegexMatcher
	contains?:    string
	custom?:      v3.#TypedExtensionConfig
	ignore_case?: bool
}

#ListStringMatcher: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.matcher.v3.ListStringMatcher"
	patterns?: [...#StringMatcher]
}
