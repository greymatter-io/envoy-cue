package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#ProtoMessageExtractionConfig_ExtractMode: "ExtractMode_UNSPECIFIED" | "FIRST_AND_LAST"

ProtoMessageExtractionConfig_ExtractMode_ExtractMode_UNSPECIFIED: "ExtractMode_UNSPECIFIED"
ProtoMessageExtractionConfig_ExtractMode_FIRST_AND_LAST:          "FIRST_AND_LAST"

#MethodExtraction_ExtractDirective: "ExtractDirective_UNSPECIFIED" | "EXTRACT" | "EXTRACT_REDACT"

MethodExtraction_ExtractDirective_ExtractDirective_UNSPECIFIED: "ExtractDirective_UNSPECIFIED"
MethodExtraction_ExtractDirective_EXTRACT:                      "EXTRACT"
MethodExtraction_ExtractDirective_EXTRACT_REDACT:               "EXTRACT_REDACT"

#ProtoMessageExtractionConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.proto_message_extraction.v3.ProtoMessageExtractionConfig"
	// It could be passed by a local file through “Datasource.filename“ or
	// embedded in the “Datasource.inline_bytes“.
	data_source?: v3.#DataSource
	// Unimplemented, the key of proto descriptor TypedMetadata.
	// Among filters depending on the proto descriptor, we can have a
	// TypedMetadata for proto descriptors, so that these filters can share one
	// copy of proto descriptor in memory.
	proto_descriptor_typed_metadata?: string
	mode?:                            #ProtoMessageExtractionConfig_ExtractMode
	// Specify the message extraction info.
	// The key is the fully qualified gRPC method name.
	// “${package}.${Service}.${Method}“, like
	// “endpoints.examples.bookstore.BookStore.GetShelf“
	//
	// The value is the message extraction information for individual gRPC
	// methods.
	extraction_by_method?: [string]: #MethodExtraction
}

// This message can be used to support per route config approach later even
// though the Istio doesn't support that so far.
#MethodExtraction: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.proto_message_extraction.v3.MethodExtraction"
	// The mapping of field path to its ExtractDirective for request messages
	request_extraction_by_field?: [string]: #MethodExtraction_ExtractDirective
	// The mapping of field path to its ExtractDirective for response messages
	response_extraction_by_field?: [string]: #MethodExtraction_ExtractDirective
}
