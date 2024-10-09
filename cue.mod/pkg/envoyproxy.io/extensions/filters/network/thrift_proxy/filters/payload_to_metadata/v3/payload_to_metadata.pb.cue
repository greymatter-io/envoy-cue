package v3

import (
	v3 "envoyproxy.io/type/matcher/v3"
)

#PayloadToMetadata_ValueType: "STRING" | "NUMBER"

PayloadToMetadata_ValueType_STRING: "STRING"
PayloadToMetadata_ValueType_NUMBER: "NUMBER"

#PayloadToMetadata: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.filters.payload_to_metadata.v3.PayloadToMetadata"
	// The list of rules to apply to requests.
	request_rules?: [...#PayloadToMetadata_Rule]
}

// [#next-free-field: 6]
#PayloadToMetadata_KeyValuePair: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.filters.payload_to_metadata.v3.PayloadToMetadata_KeyValuePair"
	// The namespace — if this is empty, the filter's namespace will be used.
	metadata_namespace?: string
	// The key to use within the namespace.
	key?: string
	// The value to pair with the given key.
	//
	// When used for on_present case, if value is non-empty it'll be used instead
	// of the field value. If both are empty, the field value is used as-is.
	//
	// When used for on_missing case, a non-empty value must be provided.
	value?: string
	// If present, the header's value will be matched and substituted with this.
	// If there is no match or substitution, the field value is used as-is.
	//
	// This is only used for on_present.
	regex_value_rewrite?: v3.#RegexMatchAndSubstitute
	// The value's type — defaults to string.
	type?: #PayloadToMetadata_ValueType
}

// A Rule defines what metadata to apply when a field is present or missing.
// [#next-free-field: 6]
#PayloadToMetadata_Rule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.filters.payload_to_metadata.v3.PayloadToMetadata_Rule"
	// If specified, the route must exactly match the request method name. As a special case,
	// an empty string matches any request method name.
	method_name?: string
	// If specified, the route must have the service name as the request method name prefix.
	// As a special case, an empty string matches any service name. Only relevant when service
	// multiplexing.
	service_name?: string
	// Specifies that a match will be performed on the value of a field.
	field_selector?: #PayloadToMetadata_FieldSelector
	// If the field is present, apply this metadata KeyValuePair.
	on_present?: #PayloadToMetadata_KeyValuePair
	// If the field is missing, apply this metadata KeyValuePair.
	//
	// The value in the KeyValuePair must be set, since it'll be used in lieu
	// of the missing field value.
	on_missing?: #PayloadToMetadata_KeyValuePair
}

#PayloadToMetadata_FieldSelector: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.filters.payload_to_metadata.v3.PayloadToMetadata_FieldSelector"
	// field name to log
	name?: string
	// field id to match
	id?: int32
	// next node of the field selector
	child?: #PayloadToMetadata_FieldSelector
}
