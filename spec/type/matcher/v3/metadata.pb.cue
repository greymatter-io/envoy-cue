package v3

// [#next-major-version: MetadataMatcher should use StructMatcher]
#MetadataMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.MetadataMatcher"
	// The filter name to retrieve the Struct from the Metadata.
	filter?: string
	// The path to retrieve the Value from the Struct.
	path?: [...#MetadataMatcher_PathSegment]
	// The MetadataMatcher is matched if the value retrieved by path is matched to this value.
	value?: #ValueMatcher
	// If true, the match result will be inverted.
	invert?: bool
}

// Specifies the segment in a path to retrieve value from Metadata.
// Note: Currently it's not supported to retrieve a value from a list in Metadata. This means that
// if the segment key refers to a list, it has to be the last segment in a path.
#MetadataMatcher_PathSegment: {
	"@type": "type.googleapis.com/envoy.type.matcher.v3.MetadataMatcher_PathSegment"
	// If specified, use the key to retrieve the value in a Struct.
	key?: string
}
