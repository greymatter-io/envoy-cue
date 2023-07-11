package v3

// Specifies the way to match a string.
// [#next-free-field: 8]
#StringMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.StringMatcher"
	// The input string must match exactly the string specified here.
	//
	// Examples:
	//
	// * ``abc`` only matches the value ``abc``.
	exact?: string
	// The input string must have the prefix specified here.
	// Note: empty prefix is not allowed, please use regex instead.
	//
	// Examples:
	//
	// * ``abc`` matches the value ``abc.xyz``
	prefix?: string
	// The input string must have the suffix specified here.
	// Note: empty prefix is not allowed, please use regex instead.
	//
	// Examples:
	//
	// * ``abc`` matches the value ``xyz.abc``
	suffix?: string
	// The input string must match the regular expression specified here.
	safe_regex?: #RegexMatcher
	// The input string must have the substring specified here.
	// Note: empty contains match is not allowed, please use regex instead.
	//
	// Examples:
	//
	// * ``abc`` matches the value ``xyz.abc.def``
	contains?: string
	// If true, indicates the exact/prefix/suffix/contains matching should be case insensitive. This
	// has no effect for the safe_regex match.
	// For example, the matcher ``data`` will match both input string ``Data`` and ``data`` if set to true.
	ignore_case?: bool
}

// Specifies a list of ways to match a string.
#ListStringMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.ListStringMatcher"
	patterns?: [...#StringMatcher]
}
