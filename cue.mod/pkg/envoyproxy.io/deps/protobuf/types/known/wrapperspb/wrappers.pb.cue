package wrapperspb

// Wrapper message for `double`.
//
// The JSON representation for `DoubleValue` is JSON number.
#DoubleValue: {
	"@type": "type.googleapis.com/google.golang.org.protobuf.types.known.wrapperspb.DoubleValue"
	// The double value.
	value?: float64
}

// Wrapper message for `float`.
//
// The JSON representation for `FloatValue` is JSON number.
#FloatValue: {
	"@type": "type.googleapis.com/google.golang.org.protobuf.types.known.wrapperspb.FloatValue"
	// The float value.
	value?: float32
}

// Wrapper message for `int64`.
//
// The JSON representation for `Int64Value` is JSON string.
#Int64Value: {
	"@type": "type.googleapis.com/google.golang.org.protobuf.types.known.wrapperspb.Int64Value"
	// The int64 value.
	value?: int64
}

// Wrapper message for `uint64`.
//
// The JSON representation for `UInt64Value` is JSON string.
#UInt64Value: {
	"@type": "type.googleapis.com/google.golang.org.protobuf.types.known.wrapperspb.UInt64Value"
	// The uint64 value.
	value?: uint64
}

// Wrapper message for `int32`.
//
// The JSON representation for `Int32Value` is JSON number.
#Int32Value: {
	"@type": "type.googleapis.com/google.golang.org.protobuf.types.known.wrapperspb.Int32Value"
	// The int32 value.
	value?: int32
}

// Wrapper message for `uint32`.
//
// The JSON representation for `UInt32Value` is JSON number.
#UInt32Value: {
	"@type": "type.googleapis.com/google.golang.org.protobuf.types.known.wrapperspb.UInt32Value"
	// The uint32 value.
	value?: uint32
}

// Wrapper message for `bool`.
//
// The JSON representation for `BoolValue` is JSON `true` and `false`.
#BoolValue: {
	"@type": "type.googleapis.com/google.golang.org.protobuf.types.known.wrapperspb.BoolValue"
	// The bool value.
	value?: bool
}

// Wrapper message for `string`.
//
// The JSON representation for `StringValue` is JSON string.
#StringValue: {
	"@type": "type.googleapis.com/google.golang.org.protobuf.types.known.wrapperspb.StringValue"
	// The string value.
	value?: string
}

// Wrapper message for `bytes`.
//
// The JSON representation for `BytesValue` is JSON string.
#BytesValue: {
	"@type": "type.googleapis.com/google.golang.org.protobuf.types.known.wrapperspb.BytesValue"
	// The bytes value.
	value?: bytes
}
