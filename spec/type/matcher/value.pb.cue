package matcher

// Specifies the way to match a ProtobufWkt::Value. Primitive values and ListValue are supported.
// StructValue is not supported and is always not matched.
// [#next-free-field: 7]
#ValueMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.ValueMatcher"
	// If specified, a match occurs if and only if the target value is a NullValue.
	null_match?: #ValueMatcher_NullMatch
	// If specified, a match occurs if and only if the target value is a double value and is
	// matched to this field.
	double_match?: #DoubleMatcher
	// If specified, a match occurs if and only if the target value is a string value and is
	// matched to this field.
	string_match?: #StringMatcher
	// If specified, a match occurs if and only if the target value is a bool value and is equal
	// to this field.
	bool_match?: bool
	// If specified, value match will be performed based on whether the path is referring to a
	// valid primitive value in the metadata. If the path is referring to a non-primitive value,
	// the result is always not matched.
	present_match?: bool
	// If specified, a match occurs if and only if the target value is a list value and
	// is matched to this field.
	list_match?: #ListMatcher
}

// Specifies the way to match a list value.
#ListMatcher: {
	"@type": "type.googleapis.com/envoy.type.matcher.ListMatcher"
	// If specified, at least one of the values in the list must match the value specified.
	one_of?: #ValueMatcher
}

// NullMatch is an empty message to specify a null value.
#ValueMatcher_NullMatch: {
	"@type": "type.googleapis.com/envoy.type.matcher.ValueMatcher_NullMatch"
}
