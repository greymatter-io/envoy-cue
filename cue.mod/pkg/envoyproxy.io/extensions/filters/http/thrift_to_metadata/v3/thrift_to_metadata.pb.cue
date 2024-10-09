package v3

import (
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
	v3 "envoyproxy.io/extensions/filters/network/thrift_proxy/v3"
)

#Field: "METHOD_NAME" | "PROTOCOL" | "TRANSPORT" | "HEADER_FLAGS" | "SEQUENCE_ID" | "MESSAGE_TYPE" | "REPLY_TYPE"

Field_METHOD_NAME:  "METHOD_NAME"
Field_PROTOCOL:     "PROTOCOL"
Field_TRANSPORT:    "TRANSPORT"
Field_HEADER_FLAGS: "HEADER_FLAGS"
Field_SEQUENCE_ID:  "SEQUENCE_ID"
Field_MESSAGE_TYPE: "MESSAGE_TYPE"
Field_REPLY_TYPE:   "REPLY_TYPE"

#KeyValuePair: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.thrift_to_metadata.v3.KeyValuePair"
	// The namespace — if this is empty, the filter's namespace will be used.
	metadata_namespace?: string
	// The key to use within the namespace.
	key?: string
	// When used for on_present case, if value is non-empty it'll be used instead
	// of the field value.
	//
	// When used for on_missing case, a non-empty value must be provided.
	value?: structpb.#Value
}

#FieldSelector: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.thrift_to_metadata.v3.FieldSelector"
	// field name to log
	name?: string
	// field id to match
	id?: int32
	// next node of the field selector
	child?: #FieldSelector
}

// [#next-free-field: 6]
#Rule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.thrift_to_metadata.v3.Rule"
	// The field to match on. If set, takes precedence over field_selector.
	field?: #Field
	// Specifies that a match will be performed on the value of a field in the thrift body.
	// If set, the whole http body will be buffered to extract the field value, which
	// may have performance implications.
	//
	// It's a thrift over http version of
	// :ref:`field_selector<envoy_v3_api_field_extensions.filters.network.thrift_proxy.filters.payload_to_metadata.v3.PayloadToMetadata.Rule.field_selector>`.
	//
	// See also `payload-to-metadata <https://www.envoyproxy.io/docs/envoy/latest/configuration/other_protocols/thrift_filters/payload_to_metadata_filter>`_
	// for more reference.
	//
	// Example:
	//
	// .. code-block:: yaml
	//
	//	method_name: foo
	//	field_selector:
	//	  name: info
	//	  id: 2
	//	  child:
	//	    name: version
	//	    id: 1
	//
	// The above yaml will match on value of “info.version“ in the below thrift schema as input of
	// :ref:`on_present<envoy_v3_api_field_extensions.filters.http.thrift_to_metadata.v3.Rule.on_present>` or
	// :ref:`on_missing<envoy_v3_api_field_extensions.filters.http.thrift_to_metadata.v3.Rule.on_missing>`
	// while we are processing “foo“ method. This rule won't be applied to “bar“ method.
	//
	// .. code-block:: thrift
	//
	//	struct Info {
	//	  1: required string version;
	//	}
	//	service Server {
	//	  bool foo(1: i32 id, 2: Info info);
	//	  bool bar(1: i32 id, 2: Info info);
	//	}
	field_selector?: #FieldSelector
	// If specified, :ref:`field_selector<envoy_v3_api_field_extensions.filters.http.thrift_to_metadata.v3.Rule.field_selector>`
	// will be used to extract the field value *only* on the thrift message with method name.
	method_name?: string
	// The key-value pair to set in the *filter metadata* if the field is present
	// in *thrift metadata*.
	//
	// If the value in the KeyValuePair is non-empty, it'll be used instead
	// of field value.
	on_present?: #KeyValuePair
	// The key-value pair to set in the *filter metadata* if the field is missing
	// in *thrift metadata*.
	//
	// The value in the KeyValuePair must be set, since it'll be used in lieu
	// of the missing field value.
	on_missing?: #KeyValuePair
}

// The configuration for transforming thrift metadata into filter metadata.
//
// [#next-free-field: 7]
#ThriftToMetadata: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.thrift_to_metadata.v3.ThriftToMetadata"
	// The list of rules to apply to http request body to extract thrift metadata.
	request_rules?: [...#Rule]
	// The list of rules to apply to http response body to extract thrift metadata.
	response_rules?: [...#Rule]
	// Supplies the type of transport that the Thrift proxy should use. Defaults to
	// :ref:`AUTO_TRANSPORT<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.TransportType.AUTO_TRANSPORT>`.
	transport?: v3.#TransportType
	// Supplies the type of protocol that the Thrift proxy should use. Defaults to
	// :ref:`AUTO_PROTOCOL<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.ProtocolType.AUTO_PROTOCOL>`.
	// Note that :ref:`LAX_BINARY<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.ProtocolType.LAX_BINARY>`
	// is not distinguished by :ref:`AUTO_PROTOCOL<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.ProtocolType.AUTO_PROTOCOL>`,
	// which is the same with :ref:`thrift_proxy network filter <envoy_v3_api_msg_extensions.filters.network.thrift_proxy.v3.ThriftProxy>`.
	// Note that :ref:`TWITTER<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.ProtocolType.TWITTER>` is
	// not supported due to deprecation in envoy.
	protocol?: v3.#ProtocolType
	// Allowed content-type for thrift payload to filter metadata transformation.
	// Default to “{"application/x-thrift"}“.
	//
	// Set “allow_empty_content_type“ if empty/missing content-type header
	// is allowed.
	allow_content_types?: [...string]
	// Allowed empty content-type for thrift payload to filter metadata transformation.
	// Default to false.
	allow_empty_content_type?: bool
}

// Thrift to metadata configuration on a per-route basis, which overrides the global configuration for
// request rules and responses rules.
#ThriftToMetadataPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.thrift_to_metadata.v3.ThriftToMetadataPerRoute"
	// The list of rules to apply to http request body to extract thrift metadata.
	request_rules?: [...#Rule]
	// The list of rules to apply to http response body to extract thrift metadata.
	response_rules?: [...#Rule]
}
