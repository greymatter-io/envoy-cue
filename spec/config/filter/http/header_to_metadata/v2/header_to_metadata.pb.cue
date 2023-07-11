package v2

#Config_ValueType: "STRING" | "NUMBER" | "PROTOBUF_VALUE"

Config_ValueType_STRING:         "STRING"
Config_ValueType_NUMBER:         "NUMBER"
Config_ValueType_PROTOBUF_VALUE: "PROTOBUF_VALUE"

// ValueEncode defines the encoding algorithm.
#Config_ValueEncode: "NONE" | "BASE64"

Config_ValueEncode_NONE:   "NONE"
Config_ValueEncode_BASE64: "BASE64"

#Config: {
	"@type": "type.googleapis.com/envoy.config.filter.http.header_to_metadata.v2.Config"
	// The list of rules to apply to requests.
	request_rules?: [...#Config_Rule]
	// The list of rules to apply to responses.
	response_rules?: [...#Config_Rule]
}

// [#next-free-field: 6]
#Config_KeyValuePair: {
	"@type": "type.googleapis.com/envoy.config.filter.http.header_to_metadata.v2.Config_KeyValuePair"
	// The namespace — if this is empty, the filter's namespace will be used.
	metadata_namespace?: string
	// The key to use within the namespace.
	key?: string
	// The value to pair with the given key.
	//
	// When used for a `on_header_present` case, if value is non-empty it'll be used
	// instead of the header value. If both are empty, no metadata is added.
	//
	// When used for a `on_header_missing` case, a non-empty value must be provided
	// otherwise no metadata is added.
	value?: string
	// The value's type — defaults to string.
	type?: #Config_ValueType
	// How is the value encoded, default is NONE (not encoded).
	// The value will be decoded accordingly before storing to metadata.
	encode?: #Config_ValueEncode
}

// A Rule defines what metadata to apply when a header is present or missing.
#Config_Rule: {
	"@type": "type.googleapis.com/envoy.config.filter.http.header_to_metadata.v2.Config_Rule"
	// The header that triggers this rule — required.
	header?: string
	// If the header is present, apply this metadata KeyValuePair.
	//
	// If the value in the KeyValuePair is non-empty, it'll be used instead
	// of the header value.
	on_header_present?: #Config_KeyValuePair
	// If the header is not present, apply this metadata KeyValuePair.
	//
	// The value in the KeyValuePair must be set, since it'll be used in lieu
	// of the missing header value.
	on_header_missing?: #Config_KeyValuePair
	// Whether or not to remove the header after a rule is applied.
	//
	// This prevents headers from leaking.
	remove?: bool
}
