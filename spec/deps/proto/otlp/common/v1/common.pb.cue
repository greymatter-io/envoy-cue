package v1

// Represents any type of attribute value. AnyValue may contain a
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
	// Reference to the string value in ProfilesDictionary.string_table.
	//
	// Note: This is currently used exclusively in the Profiling signal.
	// Implementers of OTLP receivers for signals other than Profiling should
	// treat the presence of this value as a non-fatal issue.
	// Log an error or warning indicating an unexpected field intended for the
	// Profiling signal and process the data as if this value were absent or
	// empty, ignoring its semantic content for the non-Profiling signal.
	//
	// Status: [Development]
	string_value_strindex?: int32
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
	//
	// The keys MUST be unique (it is not allowed to have more than one
	// value with the same key).
	// The behavior of software that receives duplicated keys can be unpredictable.
	values?: [...#KeyValue]
}

// Represents a key-value pair that is used to store Span attributes, Link
// attributes, etc.
#KeyValue: {
	"@type": "type.googleapis.com/go.opentelemetry.io.proto.otlp.common.v1.KeyValue"
	// The key name of the pair.
	// key_ref MUST NOT be set if key is used.
	key?: string
	// The value of the pair.
	value?: #AnyValue
	// Reference to the string key in ProfilesDictionary.string_table.
	// key MUST NOT be set if key_strindex is used.
	//
	// Note: This is currently used exclusively in the Profiling signal.
	// Implementers of OTLP receivers for signals other than Profiling should
	// treat the presence of this key as a non-fatal issue.
	// Log an error or warning indicating an unexpected field intended for the
	// Profiling signal and process the data as if this value were absent or
	// empty, ignoring its semantic content for the non-Profiling signal.
	//
	// Status: [Development]
	key_strindex?: int32
}

// InstrumentationScope is a message representing the instrumentation scope information
// such as the fully qualified name and version.
#InstrumentationScope: {
	"@type": "type.googleapis.com/go.opentelemetry.io.proto.otlp.common.v1.InstrumentationScope"
	// A name denoting the Instrumentation scope.
	// An empty instrumentation scope name means the name is unknown.
	name?: string
	// Defines the version of the instrumentation scope.
	// An empty instrumentation scope version means the version is unknown.
	version?: string
	// Additional attributes that describe the scope. [Optional].
	// Attribute keys MUST be unique (it is not allowed to have more than one
	// attribute with the same key).
	// The behavior of software that receives duplicated keys can be unpredictable.
	attributes?: [...#KeyValue]
	// The number of attributes that were discarded. Attributes
	// can be discarded because their keys are too long or because there are too many
	// attributes. If this value is 0, then no attributes were dropped.
	dropped_attributes_count?: uint32
}

// A reference to an Entity.
// Entity represents an object of interest associated with produced telemetry: e.g spans, metrics, profiles, or logs.
//
// Status: [Development]
#EntityRef: {
	"@type": "type.googleapis.com/go.opentelemetry.io.proto.otlp.common.v1.EntityRef"
	// The Schema URL, if known. This is the identifier of the Schema that the entity data
	// is recorded in. To learn more about Schema URL see
	// https://opentelemetry.io/docs/specs/otel/schemas/#schema-url
	//
	// This schema_url applies to the data in this message and to the Resource attributes
	// referenced by id_keys and description_keys.
	// TODO: discuss if we are happy with this somewhat complicated definition of what
	// the schema_url applies to.
	//
	// This field obsoletes the schema_url field in ResourceMetrics/ResourceSpans/ResourceLogs.
	schema_url?: string
	// Defines the type of the entity. MUST not change during the lifetime of the entity.
	// For example: "service" or "host". This field is required and MUST not be empty
	// for valid entities.
	type?: string
	// Attribute Keys that identify the entity.
	// MUST not change during the lifetime of the entity. The Id must contain at least one attribute.
	// These keys MUST exist in the containing {message}.attributes.
	id_keys?: [...string]
	// Descriptive (non-identifying) attribute keys of the entity.
	// MAY change over the lifetime of the entity. MAY be empty.
	// These attribute keys are not part of entity's identity.
	// These keys MUST exist in the containing {message}.attributes.
	description_keys?: [...string]
}
