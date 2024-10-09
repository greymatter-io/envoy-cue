package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#GrpcFieldExtractionConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.grpc_field_extraction.v3.GrpcFieldExtractionConfig"
	// The proto descriptor set binary for the gRPC services.
	//
	// It could be passed by a local file through “Datasource.filename“ or embedded in the
	// “Datasource.inline_bytes“.
	descriptor_set?: v3.#DataSource
	// Specify the extraction info.
	// The key is the fully qualified gRPC method name.
	// “${package}.${Service}.${Method}“, like
	// “endpoints.examples.bookstore.BookStore.GetShelf“
	//
	// The value is the field extractions for individual gRPC method.
	extractions_by_method?: [string]: #FieldExtractions
}

// This message can be used to support per route config approach later even
// though the Istio doesn't support that so far.
#FieldExtractions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.grpc_field_extraction.v3.FieldExtractions"
	// The field extractions for requests.
	// The key is the field path within the grpc request.
	// For example, we can define “foo.bar.name“ if we want to extract
	// “Request.foo.bar.name“.
	//
	// .. code-block:: proto
	//
	//	message Request {
	//	  Foo foo = 1;
	//	}
	//
	//	message Foo {
	//	  Bar bar = 1;
	//	}
	//
	//	message Bar {
	//	  string name = 1;
	//	}
	request_field_extractions?: [string]: #RequestFieldValueDisposition
}

#RequestFieldValueDisposition: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.grpc_field_extraction.v3.RequestFieldValueDisposition"
	// The dynamic metadata namespace. If empty, "envoy.filters.http.grpc_field_extraction" will be used by default.
	//
	// Unimplemented. Uses "envoy.filters.http.grpc_field_extraction" for now.
	dynamic_metadata?: string
}
