package v3

// FilterStateMatcher provides a general interface for matching the filter state objects.
#FilterStateMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.FilterStateMatcher"
	// The filter state key to retrieve the object.
	key?: string
	// Matches the filter state object as a string value.
	string_match?: #StringMatcher
}
