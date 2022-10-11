package v1

// AnyValue is used to represent any type of attribute value. AnyValue may contain a
// primitive value such as a string or integer or it may contain an arbitrary nested
// object containing arrays, key-value lists and primitives.
#AnyValue: {
	"@type":       "type.googleapis.com/go.opentelemetry.io.proto.otlp.common.v1.AnyValue"
	string_value?: string
	bool_value?:   bool
	int_value?:    int64
	double_value?: float64
	array_value?:  #ArrayValue
	kvlist_value?: #KeyValueList
	bytes_value?:  bytes
}

// ArrayValue is a list of AnyValue messages. We need ArrayValue as a message
// since oneof in AnyValue does not allow repeated fields.
#ArrayValue: {
	"@type": "type.googleapis.com/go.opentelemetry.io.proto.otlp.common.v1.ArrayValue"
	// Array of values. The array may be empty (contain 0 elements).
	values?: [...#AnyValue]
}

// KeyValueList is a list of KeyValue messages. We need KeyValueList as a message
// since `oneof` in AnyValue does not allow repeated fields. Everywhere else where we need
// a list of KeyValue messages (e.g. in Span) we use `repeated KeyValue` directly to
// avoid unnecessary extra wrapping (which slows down the protocol). The 2 approaches
// are semantically equivalent.
#KeyValueList: {
	"@type": "type.googleapis.com/go.opentelemetry.io.proto.otlp.common.v1.KeyValueList"
	// A collection of key/value pairs of key-value pairs. The list may be empty (may
	// contain 0 elements).
	// The keys MUST be unique (it is not allowed to have more than one
	// value with the same key).
	values?: [...#KeyValue]
}

// KeyValue is a key-value pair that is used to store Span attributes, Link
// attributes, etc.
#KeyValue: {
	"@type": "type.googleapis.com/go.opentelemetry.io.proto.otlp.common.v1.KeyValue"
	key?:    string
	value?:  #AnyValue
}

// InstrumentationLibrary is a message representing the instrumentation library information
// such as the fully qualified name and version.
// InstrumentationLibrary is wire-compatible with InstrumentationScope for binary
// Protobuf format.
// This message is deprecated and will be removed on June 15, 2022.
//
// Deprecated: Do not use.
#InstrumentationLibrary: {
	"@type": "type.googleapis.com/go.opentelemetry.io.proto.otlp.common.v1.InstrumentationLibrary"
	// An empty instrumentation library name means the name is unknown.
	name?:    string
	version?: string
}

// InstrumentationScope is a message representing the instrumentation scope information
// such as the fully qualified name and version.
#InstrumentationScope: {
	"@type": "type.googleapis.com/go.opentelemetry.io.proto.otlp.common.v1.InstrumentationScope"
	// An empty instrumentation scope name means the name is unknown.
	name?:    string
	version?: string
}
