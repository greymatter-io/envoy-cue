package v3

import (
	v3 "envoyproxy.io/type/metadata/v3"
)

// Describes custom tags for the active span.
// [#next-free-field: 6]
#CustomTag: {
	"@type": "type.googleapis.com/envoy.type.tracing.v3.CustomTag"
	// Used to populate the tag name.
	tag?: string
	// A literal custom tag.
	literal?: #CustomTag_Literal
	// An environment custom tag.
	environment?: #CustomTag_Environment
	// A request header custom tag.
	request_header?: #CustomTag_Header
	// A custom tag to obtain tag value from the metadata.
	metadata?: #CustomTag_Metadata
}

// Literal type custom tag with static value for the tag value.
#CustomTag_Literal: {
	"@type": "type.googleapis.com/envoy.type.tracing.v3.CustomTag_Literal"
	// Static literal value to populate the tag value.
	value?: string
}

// Environment type custom tag with environment name and default value.
#CustomTag_Environment: {
	"@type": "type.googleapis.com/envoy.type.tracing.v3.CustomTag_Environment"
	// Environment variable name to obtain the value to populate the tag value.
	name?: string
	// When the environment variable is not found,
	// the tag value will be populated with this default value if specified,
	// otherwise no tag will be populated.
	default_value?: string
}

// Header type custom tag with header name and default value.
#CustomTag_Header: {
	"@type": "type.googleapis.com/envoy.type.tracing.v3.CustomTag_Header"
	// Header name to obtain the value to populate the tag value.
	name?: string
	// When the header does not exist,
	// the tag value will be populated with this default value if specified,
	// otherwise no tag will be populated.
	default_value?: string
}

// Metadata type custom tag using
// :ref:`MetadataKey <envoy_v3_api_msg_type.metadata.v3.MetadataKey>` to retrieve the protobuf value
// from :ref:`Metadata <envoy_v3_api_msg_config.core.v3.Metadata>`, and populate the tag value with
// `the canonical JSON <https://developers.google.com/protocol-buffers/docs/proto3#json>`_
// representation of it.
#CustomTag_Metadata: {
	"@type": "type.googleapis.com/envoy.type.tracing.v3.CustomTag_Metadata"
	// Specify what kind of metadata to obtain tag value from.
	kind?: v3.#MetadataKind
	// Metadata key to define the path to retrieve the tag value.
	metadata_key?: v3.#MetadataKey
	// When no valid metadata is found,
	// the tag value would be populated with this default value if specified,
	// otherwise no tag would be populated.
	default_value?: string
}
