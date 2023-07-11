package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
)

#Config_ValueType: "STRING" | "NUMBER" | "PROTOBUF_VALUE"

Config_ValueType_STRING:         "STRING"
Config_ValueType_NUMBER:         "NUMBER"
Config_ValueType_PROTOBUF_VALUE: "PROTOBUF_VALUE"

// ValueEncode defines the encoding algorithm.
#Config_ValueEncode: "NONE" | "BASE64"

Config_ValueEncode_NONE:   "NONE"
Config_ValueEncode_BASE64: "BASE64"

#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.header_to_metadata.v3.Config"
	// The list of rules to apply to requests.
	request_rules?: [...#Config_Rule]
	// The list of rules to apply to responses.
	response_rules?: [...#Config_Rule]
}

// [#next-free-field: 7]
#Config_KeyValuePair: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.header_to_metadata.v3.Config_KeyValuePair"
	// The namespace — if this is empty, the filter's namespace will be used.
	metadata_namespace?: string
	// The key to use within the namespace.
	key?: string
	// The value to pair with the given key.
	//
	// When used for a
	// :ref:`on_header_present <envoy_v3_api_field_extensions.filters.http.header_to_metadata.v3.Config.Rule.on_header_present>`
	// case, if value is non-empty it'll be used instead of the header value. If both are empty, no metadata is added.
	//
	// When used for a :ref:`on_header_missing <envoy_v3_api_field_extensions.filters.http.header_to_metadata.v3.Config.Rule.on_header_missing>`
	// case, a non-empty value must be provided otherwise no metadata is added.
	value?: string
	// If present, the header's value will be matched and substituted with this. If there is no match or substitution, the header value
	// is used as-is.
	//
	// This is only used for :ref:`on_header_present <envoy_v3_api_field_extensions.filters.http.header_to_metadata.v3.Config.Rule.on_header_present>`.
	//
	// Note: if the ``value`` field is non-empty this field should be empty.
	regex_value_rewrite?: v3.#RegexMatchAndSubstitute
	// The value's type — defaults to string.
	type?: #Config_ValueType
	// How is the value encoded, default is NONE (not encoded).
	// The value will be decoded accordingly before storing to metadata.
	encode?: #Config_ValueEncode
}

// A Rule defines what metadata to apply when a header is present or missing.
// [#next-free-field: 6]
#Config_Rule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.header_to_metadata.v3.Config_Rule"
	// Specifies that a match will be performed on the value of a header or a cookie.
	//
	// The header to be extracted.
	header?: string
	// The cookie to be extracted.
	cookie?: string
	// If the header or cookie is present, apply this metadata KeyValuePair.
	//
	// If the value in the KeyValuePair is non-empty, it'll be used instead
	// of the header or cookie value.
	on_header_present?: #Config_KeyValuePair
	// If the header or cookie is not present, apply this metadata KeyValuePair.
	//
	// The value in the KeyValuePair must be set, since it'll be used in lieu
	// of the missing header or cookie value.
	on_header_missing?: #Config_KeyValuePair
	// Whether or not to remove the header after a rule is applied.
	//
	// This prevents headers from leaking.
	// This field is not supported in case of a cookie.
	remove?: bool
}
