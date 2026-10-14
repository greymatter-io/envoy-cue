package v3

// Specifies the way to match a path on HTTP request.
#PathMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.PathMatcher"
	// The ``path`` must match the URL path portion of the :path header. The query and fragment
	// string (if present) are removed in the URL path portion.
	// For example, the path ``/data`` will match the ``:path`` header ``/data#fragment?param=value``.
	path?: #StringMatcher
}
