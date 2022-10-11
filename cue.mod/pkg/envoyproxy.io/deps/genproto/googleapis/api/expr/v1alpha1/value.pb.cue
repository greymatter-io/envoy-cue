package v1alpha1

import (
	anypb "envoyproxy.io/deps/protobuf/types/known/anypb"
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
)

// Represents a CEL value.
//
// This is similar to `google.protobuf.Value`, but can represent CEL's full
// range of values.
#Value: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Value"
	// Null value.
	null_value?: structpb.#NullValue
	// Boolean value.
	bool_value?: bool
	// Signed integer value.
	int64_value?: int64
	// Unsigned integer value.
	uint64_value?: uint64
	// Floating point value.
	double_value?: float64
	// UTF-8 string value.
	string_value?: string
	// Byte string value.
	bytes_value?: bytes
	// An enum value.
	enum_value?: #EnumValue
	// The proto message backing an object value.
	object_value?: anypb.#Any
	// Map value.
	map_value?: #MapValue
	// List value.
	list_value?: #ListValue
	// Type value.
	type_value?: string
}

// An enum value.
#EnumValue: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.EnumValue"
	// The fully qualified name of the enum type.
	type?: string
	// The value of the enum.
	value?: int32
}

// A list.
//
// Wrapped in a message so 'not set' and empty can be differentiated, which is
// required for use in a 'oneof'.
#ListValue: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.ListValue"
	// The ordered values in the list.
	values?: [...#Value]
}

// A map.
//
// Wrapped in a message so 'not set' and empty can be differentiated, which is
// required for use in a 'oneof'.
#MapValue: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.MapValue"
	// The set of map entries.
	//
	// CEL has fewer restrictions on keys, so a protobuf map represenation
	// cannot be used.
	entries?: [...#MapValue_Entry]
}

// An entry in the map.
#MapValue_Entry: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.MapValue_Entry"
	// The key.
	//
	// Must be unique with in the map.
	// Currently only boolean, int, uint, and string values can be keys.
	key?: #Value
	// The value.
	value?: #Value
}
