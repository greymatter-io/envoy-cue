package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/core/v3"
)

// Specifies the way to match a string.
// [#next-free-field: 9]
#StringMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.StringMatcher"
	// The input string must match exactly the string specified here.
	//
	// Examples:
	//
	// * “abc“ only matches the value “abc“.
	exact?: string
	// The input string must have the prefix specified here.
	//
	// .. note::
	//
	//	Empty prefix match is not allowed, please use ``safe_regex`` instead.
	//
	// Examples:
	//
	// * “abc“ matches the value “abc.xyz“
	prefix?: string
	// The input string must have the suffix specified here.
	//
	// .. note::
	//
	//	Empty suffix match is not allowed, please use ``safe_regex`` instead.
	//
	// Examples:
	//
	// * “abc“ matches the value “xyz.abc“
	suffix?: string
	// The input string must match the regular expression specified here.
	safe_regex?: #RegexMatcher
	// The input string must have the substring specified here.
	//
	// .. note::
	//
	//	Empty contains match is not allowed, please use ``safe_regex`` instead.
	//
	// Examples:
	//
	// * “abc“ matches the value “xyz.abc.def“
	contains?: string
	// Use an extension as the matcher type.
	// [#extension-category: envoy.string_matcher]
	custom?: v3.#TypedExtensionConfig
	// If “true“, indicates the exact/prefix/suffix/contains matching should be case insensitive. This
	// has no effect for the “safe_regex“ match.
	// For example, the matcher “data“ will match both input string “Data“ and “data“ if this option
	// is set to “true“.
	ignore_case?: bool
}

// Specifies a list of ways to match a string.
#ListStringMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.ListStringMatcher"
	patterns?: [...#StringMatcher]
}
