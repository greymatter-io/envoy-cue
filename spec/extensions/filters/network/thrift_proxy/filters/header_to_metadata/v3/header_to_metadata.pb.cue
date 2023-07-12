package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
)

#HeaderToMetadata_ValueType: "STRING" | "NUMBER" | "PROTOBUF_VALUE"

HeaderToMetadata_ValueType_STRING:         "STRING"
HeaderToMetadata_ValueType_NUMBER:         "NUMBER"
HeaderToMetadata_ValueType_PROTOBUF_VALUE: "PROTOBUF_VALUE"

// ValueEncode defines the encoding algorithm.
#HeaderToMetadata_ValueEncode: "NONE" | "BASE64"

HeaderToMetadata_ValueEncode_NONE:   "NONE"
HeaderToMetadata_ValueEncode_BASE64: "BASE64"

#HeaderToMetadata: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.filters.header_to_metadata.v3.HeaderToMetadata"
	// The list of rules to apply to requests.
	request_rules?: [...#HeaderToMetadata_Rule]
}

// [#next-free-field: 7]
#HeaderToMetadata_KeyValuePair: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.filters.header_to_metadata.v3.HeaderToMetadata_KeyValuePair"
	// The namespace — if this is empty, the filter's namespace will be used.
	metadata_namespace?: string
	// The key to use within the namespace.
	key?: string
	// The value to pair with the given key.
	//
	// When used for on_present case, if value is non-empty it'll be used instead
	// of the header value. If both are empty, the header value is used as-is.
	//
	// When used for on_missing case, a non-empty value must be provided.
	value?: string
	// If present, the header's value will be matched and substituted with this.
	// If there is no match or substitution, the header value is used as-is.
	//
	// This is only used for on_present.
	regex_value_rewrite?: v3.#RegexMatchAndSubstitute
	// The value's type — defaults to string.
	type?: #HeaderToMetadata_ValueType
	// How is the value encoded, default is NONE (not encoded).
	// The value will be decoded accordingly before storing to metadata.
	encode?: #HeaderToMetadata_ValueEncode
}

// A Rule defines what metadata to apply when a header is present or missing.
#HeaderToMetadata_Rule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.filters.header_to_metadata.v3.HeaderToMetadata_Rule"
	// Specifies that a match will be performed on the value of a header.
	//
	// The header to be extracted.
	header?: string
	// If the header is present, apply this metadata KeyValuePair.
	//
	// If the value in the KeyValuePair is non-empty, it'll be used instead
	// of the header value.
	on_present?: #HeaderToMetadata_KeyValuePair
	// If the header is not present, apply this metadata KeyValuePair.
	//
	// The value in the KeyValuePair must be set, since it'll be used in lieu
	// of the missing header value.
	on_missing?: #HeaderToMetadata_KeyValuePair
	// Whether or not to remove the header after a rule is applied.
	//
	// This prevents headers from leaking.
	remove?: bool
}
