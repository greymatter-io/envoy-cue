package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/type/matcher/v3"
)

// An enum enlisting all the filtering modes supported by this filter.
#ProtoApiScrubberConfig_FilteringMode: "OVERRIDE"

ProtoApiScrubberConfig_FilteringMode_OVERRIDE: "OVERRIDE"

#ProtoApiScrubberConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.proto_api_scrubber.v3.ProtoApiScrubberConfig"
	// The proto descriptor set for the proto services.
	descriptor_set?: #DescriptorSet
	// Contains the restrictions for the supported proto elements.
	restrictions?: #Restrictions
	// Specifies the filtering mode of this filter.
	filtering_mode?: #ProtoApiScrubberConfig_FilteringMode
	// If true, the filter will scrub unknown fields from the protobuf messages.
	scrub_unknown_fields?: bool
}

// Specifies the descriptor set for proto services.
#DescriptorSet: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.proto_api_scrubber.v3.DescriptorSet"
	// It could be passed by a local file through “Datasource.filename“ or
	// embedded in the “Datasource.inline_bytes“.
	data_source?: v3.#DataSource
}

// Contains the restrictions for the methods.
#Restrictions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.proto_api_scrubber.v3.Restrictions"
	// Specifies the method restrictions.
	// Key - Fully qualified method name e.g., “endpoints.examples.bookstore.BookStore/GetShelf“.
	// Value - Method restrictions.
	method_restrictions?: [string]: #MethodRestrictions
	// Specifies the message restrictions.
	// Key - Fully qualified message name e.g., “endpoints.examples.bookstore.Book“.
	// Value - Message restrictions.
	message_restrictions?: [string]: #MessageRestrictions
}

// Contains the method restrictions which include the field level restrictions
// for the request and response fields.
#MethodRestrictions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.proto_api_scrubber.v3.MethodRestrictions"
	// Restrictions that apply to request fields of the method.
	// Key - field mask like path of the field e.g., foo.bar.baz
	// Value - Restrictions map containing the mapping from restriction name to
	// the restriction values.
	request_field_restrictions?: [string]: #RestrictionConfig
	// Restrictions that apply to response fields of the method.
	// Key - field mask like path of the field e.g., foo.bar.baz
	// Value - Restrictions map containing the mapping from restriction name to
	// the restriction values.
	response_field_restrictions?: [string]: #RestrictionConfig
	// Optional restriction that applies to the entire method. If present, this
	// rule takes precedence for the method itself over field-level or
	// message-level rules. The 'matcher' within RestrictionConfig will determine
	// if the method is denied/scrubbed. If the matcher evaluates to true:
	//
	//   - The request is **denied**, and further processing is stopped.
	//   - The implementation should generate an immediate error response
	//     (e.g., an HTTP 403 Forbidden status) and send it to the client.
	method_restriction?: #RestrictionConfig
}

// Contains message-level restrictions.
#MessageRestrictions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.proto_api_scrubber.v3.MessageRestrictions"
	// The core restriction to apply to this message type.
	// The 'matcher' within RestrictionConfig will determine if the message is
	// scrubbed/denied/allowed.
	config?: #RestrictionConfig
	// Restrictions that apply to specific fields within this message type.
	// Key - field mask (e.g. "social_security_number").
	// Value - The restriction configuration for that field.
	field_restrictions?: [string]: #RestrictionConfig
}

// The restriction configuration.
#RestrictionConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.proto_api_scrubber.v3.RestrictionConfig"
	// Matcher tree for matching requests and responses with the configured restrictions.
	matcher?: v31.#Matcher
}
