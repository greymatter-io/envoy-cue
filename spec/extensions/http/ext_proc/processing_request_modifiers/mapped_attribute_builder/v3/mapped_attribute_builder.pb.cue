package v3

// Extension to build custom attributes in the
// :ref:`ProcessingRequest <envoy_v3_api_msg_service.ext_proc.v3.ProcessingRequest>` based on a
// configurable mapping. The native implementation uses the CEL expression as the key, which is
// not always desirable. Using this extension, one can re-map a CEL expression that references
// internal filter state into a more user-friendly key that decouples the value from the underlying
// filter implementation.
//
// If a given CEL expression fails to evaluate, it will not be present in the attributes struct.
//
// If this extension is configured, then the original
// :ref:`ProcessingRequest <envoy_v3_api_msg_service.ext_proc.v3.ProcessingRequest>`'s
// “request_attributes“ are ignored, and all attributes should be explicitly set via this
// extension.
//
// An example configuration may look like so:
//
// .. code-block:: yaml
//
//	mapped_request_attributes:
//	  "request.path": "request.path"
//	  "source.country": "metadata.filter_metadata['com.example.location_filter']['country_code']"
//
// In the above example, the complex “filter_metadata“ expression is evaluated via CEL, and the
// value is stored under the friendlier “source.country“ key. The
// :ref:`ProcessingRequest <envoy_v3_api_msg_service.ext_proc.v3.ProcessingRequest>` would look
// like:
//
// .. code-block:: text
//
//	attributes {
//	  key: "envoy.filters.http.ext_proc"
//	  value {
//	    fields {
//	      key: "request.path"
//	      value {
//	        string_value: "/profile"
//	      }
//	    }
//	    fields {
//	      key: "source.country"
//	      value {
//	        string_value: "US"
//	      }
//	    }
//	  }
//	}
//
// .. note::
//
//	Processing request modifiers are currently in alpha.
#MappedAttributeBuilder: {
	"@type": "type.googleapis.com/envoy.extensions.http.ext_proc.processing_request_modifiers.mapped_attribute_builder.v3.MappedAttributeBuilder"
	// A map of request attributes to set in the
	// :ref:`attributes <envoy_v3_api_field_service.ext_proc.v3.ProcessingRequest.attributes>` struct.
	// The key is the attribute name, and the value is the CEL expression to evaluate. This allows
	// for the re-mapping of attributes, which is not supported by the native attribute building
	// logic.
	mapped_request_attributes?: [string]: string
	// Similar to “mapped_request_attributes“, but for response attributes. The "response"
	// nomenclature here indicates that the attributes, whatever they may be, are sent with a
	// response headers, body, or trailers ext_proc call.
	//
	// If a value contains a request key (e.g., “request.host“), then the attribute would just be
	// sent along in the response. This is useful if a given ext_proc extension is only enabled for
	// response handling (e.g., “RESPONSE_HEADERS“) but the backend wants to access request
	// metadata.
	mapped_response_attributes?: [string]: string
}
