package v3

#GrpcJsonTranscoder_UrlUnescapeSpec: "ALL_CHARACTERS_EXCEPT_RESERVED" | "ALL_CHARACTERS_EXCEPT_SLASH" | "ALL_CHARACTERS"

GrpcJsonTranscoder_UrlUnescapeSpec_ALL_CHARACTERS_EXCEPT_RESERVED: "ALL_CHARACTERS_EXCEPT_RESERVED"
GrpcJsonTranscoder_UrlUnescapeSpec_ALL_CHARACTERS_EXCEPT_SLASH:    "ALL_CHARACTERS_EXCEPT_SLASH"
GrpcJsonTranscoder_UrlUnescapeSpec_ALL_CHARACTERS:                 "ALL_CHARACTERS"

// [#next-free-field: 15]
// GrpcJsonTranscoder filter configuration.
// The filter itself can be used per route / per virtual host or on the general level. The most
// specific one is being used for a given route. If the list of services is empty - filter
// is considered to be disabled.
// Note that if specifying the filter per route, first the route is matched, and then transcoding
// filter is applied. It matters when specifying the route configuration and paths to match the
// request - for per-route grpc transcoder configs, the original path should be matched, while
// in other cases, the grpc-like path is expected (the one AFTER the filter is applied).
#GrpcJsonTranscoder: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.grpc_json_transcoder.v3.GrpcJsonTranscoder"
	// Supplies the filename of
	// :ref:`the proto descriptor set <config_grpc_json_generate_proto_descriptor_set>` for the gRPC
	// services.
	proto_descriptor?: string
	// Supplies the binary content of
	// :ref:`the proto descriptor set <config_grpc_json_generate_proto_descriptor_set>` for the gRPC
	// services.
	proto_descriptor_bin?: bytes
	// A list of strings that
	// supplies the fully qualified service names (i.e. "package_name.service_name") that
	// the transcoder will translate. If the service name doesn't exist in ``proto_descriptor``,
	// Envoy will fail at startup. The ``proto_descriptor`` may contain more services than
	// the service names specified here, but they won't be translated.
	//
	// By default, the filter will pass through requests that do not map to any specified services.
	// If the list of services is empty, filter is considered disabled.
	// However, this behavior changes if
	// :ref:`reject_unknown_method <envoy_v3_api_field_extensions.filters.http.grpc_json_transcoder.v3.GrpcJsonTranscoder.RequestValidationOptions.reject_unknown_method>`
	// is enabled.
	services?: [...string]
	// Control options for response JSON. These options are passed directly to
	// `JsonPrintOptions <https://developers.google.com/protocol-buffers/docs/reference/cpp/
	// google.protobuf.util.json_util#JsonPrintOptions>`_.
	print_options?: #GrpcJsonTranscoder_PrintOptions
	// Whether to keep the incoming request route after the outgoing headers have been transformed to
	// the match the upstream gRPC service. Note: This means that routes for gRPC services that are
	// not transcoded cannot be used in combination with ``match_incoming_request_route``.
	match_incoming_request_route?: bool
	// A list of query parameters to be ignored for transcoding method mapping.
	// By default, the transcoder filter will not transcode a request if there are any
	// unknown/invalid query parameters.
	//
	// Example :
	//
	// .. code-block:: proto
	//
	//     service Bookstore {
	//       rpc GetShelf(GetShelfRequest) returns (Shelf) {
	//         option (google.api.http) = {
	//           get: "/shelves/{shelf}"
	//         };
	//       }
	//     }
	//
	//     message GetShelfRequest {
	//       int64 shelf = 1;
	//     }
	//
	//     message Shelf {}
	//
	// The request ``/shelves/100?foo=bar`` will not be mapped to ``GetShelf``` because variable
	// binding for ``foo`` is not defined. Adding ``foo`` to ``ignored_query_parameters`` will allow
	// the same request to be mapped to ``GetShelf``.
	ignored_query_parameters?: [...string]
	// Whether to route methods without the ``google.api.http`` option.
	//
	// Example :
	//
	// .. code-block:: proto
	//
	//     package bookstore;
	//
	//     service Bookstore {
	//       rpc GetShelf(GetShelfRequest) returns (Shelf) {}
	//     }
	//
	//     message GetShelfRequest {
	//       int64 shelf = 1;
	//     }
	//
	//     message Shelf {}
	//
	// The client could ``post`` a json body ``{"shelf": 1234}`` with the path of
	// ``/bookstore.Bookstore/GetShelfRequest`` to call ``GetShelfRequest``.
	auto_mapping?: bool
	// Whether to ignore query parameters that cannot be mapped to a corresponding
	// protobuf field. Use this if you cannot control the query parameters and do
	// not know them beforehand. Otherwise use ``ignored_query_parameters``.
	// Defaults to false.
	ignore_unknown_query_parameters?: bool
	// Whether to convert gRPC status headers to JSON.
	// When trailer indicates a gRPC error and there was no HTTP body, take ``google.rpc.Status``
	// from the ``grpc-status-details-bin`` header and use it as JSON body.
	// If there was no such header, make ``google.rpc.Status`` out of the ``grpc-status`` and
	// ``grpc-message`` headers.
	// The error details types must be present in the ``proto_descriptor``.
	//
	// For example, if an upstream server replies with headers:
	//
	// .. code-block:: none
	//
	//     grpc-status: 5
	//     grpc-status-details-bin:
	//         CAUaMwoqdHlwZS5nb29nbGVhcGlzLmNvbS9nb29nbGUucnBjLlJlcXVlc3RJbmZvEgUKA3ItMQ
	//
	// The ``grpc-status-details-bin`` header contains a base64-encoded protobuf message
	// ``google.rpc.Status``. It will be transcoded into:
	//
	// .. code-block:: none
	//
	//     HTTP/1.1 404 Not Found
	//     content-type: application/json
	//
	//     {"code":5,"details":[{"@type":"type.googleapis.com/google.rpc.RequestInfo","requestId":"r-1"}]}
	//
	// In order to transcode the message, the ``google.rpc.RequestInfo`` type from
	// the ``google/rpc/error_details.proto`` should be included in the configured
	// :ref:`proto descriptor set <config_grpc_json_generate_proto_descriptor_set>`.
	convert_grpc_status?: bool
	// URL unescaping policy.
	// This spec is only applied when extracting variable with multiple segments in the URL path.
	// For example, in case of ``/foo/{x=*}/bar/{y=prefix/*}/{z=**}`` ``x`` variable is single segment and ``y`` and ``z`` are multiple segments.
	// For a path with ``/foo/first/bar/prefix/second/third/fourth``, ``x=first``, ``y=prefix/second``, ``z=third/fourth``.
	// If this setting is not specified, the value defaults to :ref:`ALL_CHARACTERS_EXCEPT_RESERVED<envoy_v3_api_enum_value_extensions.filters.http.grpc_json_transcoder.v3.GrpcJsonTranscoder.UrlUnescapeSpec.ALL_CHARACTERS_EXCEPT_RESERVED>`.
	url_unescape_spec?: #GrpcJsonTranscoder_UrlUnescapeSpec
	// If true, unescape '+' to space when extracting variables in query parameters.
	// This is to support `HTML 2.0 <https://tools.ietf.org/html/rfc1866#section-8.2.1>`_
	query_param_unescape_plus?: bool
	// If true, try to match the custom verb even if it is unregistered. By
	// default, only match when it is registered.
	//
	// According to the http template `syntax <https://github.com/googleapis/googleapis/blob/master/google/api/http.proto#L226-L231>`_,
	// the custom verb is **":" LITERAL** at the end of http template.
	//
	// For a request with ``/foo/bar:baz`` and ``:baz`` is not registered in any url_template, here is the behavior change
	// - if the field is not set, ``:baz`` will not be treated as custom verb, so it will match ``/foo/{x=*}``.
	// - if the field is set, ``:baz`` is treated as custom verb,  so it will NOT match ``/foo/{x=*}`` since the template doesn't use any custom verb.
	match_unregistered_custom_verb?: bool
	// Configure the behavior when handling requests that cannot be transcoded.
	//
	// By default, the transcoder will silently pass through HTTP requests that are malformed.
	// This includes requests with unknown query parameters, unregister paths, etc.
	//
	// Set these options to enable strict HTTP request validation, resulting in the transcoder rejecting
	// such requests with a ``HTTP 4xx``. See each individual option for more details on the validation.
	// gRPC requests will still silently pass through without transcoding.
	//
	// The benefit is a proper error message to the downstream.
	// If the upstream is a gRPC server, it cannot handle the passed-through HTTP requests and will reset
	// the TCP connection. The downstream will then
	// receive a ``HTTP 503 Service Unavailable`` due to the upstream connection reset.
	// This incorrect error message may conflict with other Envoy components, such as retry policies.
	request_validation_options?: #GrpcJsonTranscoder_RequestValidationOptions
	// Proto enum values are supposed to be in upper cases when used in JSON.
	// Set this to true if your JSON request uses non uppercase enum values.
	case_insensitive_enum_parsing?: bool
}

// [#next-free-field: 6]
#GrpcJsonTranscoder_PrintOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.grpc_json_transcoder.v3.GrpcJsonTranscoder_PrintOptions"
	// Whether to add spaces, line breaks and indentation to make the JSON
	// output easy to read. Defaults to false.
	add_whitespace?: bool
	// Whether to always print primitive fields. By default primitive
	// fields with default values will be omitted in JSON output. For
	// example, an int32 field set to 0 will be omitted. Setting this flag to
	// true will override the default behavior and print primitive fields
	// regardless of their values. Defaults to false.
	always_print_primitive_fields?: bool
	// Whether to always print enums as ints. By default they are rendered
	// as strings. Defaults to false.
	always_print_enums_as_ints?: bool
	// Whether to preserve proto field names. By default protobuf will
	// generate JSON field names using the ``json_name`` option, or lower camel case,
	// in that order. Setting this flag will preserve the original field names. Defaults to false.
	preserve_proto_field_names?: bool
	// If true, return all streams as newline-delimited JSON messages instead of as a comma-separated array
	stream_newline_delimited?: bool
}

#GrpcJsonTranscoder_RequestValidationOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.grpc_json_transcoder.v3.GrpcJsonTranscoder_RequestValidationOptions"
	// By default, a request that cannot be mapped to any specified gRPC
	// :ref:`services <envoy_v3_api_field_extensions.filters.http.grpc_json_transcoder.v3.GrpcJsonTranscoder.services>`
	// will pass-through this filter.
	// When set to true, the request will be rejected with a ``HTTP 404 Not Found``.
	reject_unknown_method?: bool
	// By default, a request with query parameters that cannot be mapped to the gRPC request message
	// will pass-through this filter.
	// When set to true, the request will be rejected with a ``HTTP 400 Bad Request``.
	//
	// The fields
	// :ref:`ignore_unknown_query_parameters <envoy_v3_api_field_extensions.filters.http.grpc_json_transcoder.v3.GrpcJsonTranscoder.ignore_unknown_query_parameters>`
	// and
	// :ref:`ignored_query_parameters <envoy_v3_api_field_extensions.filters.http.grpc_json_transcoder.v3.GrpcJsonTranscoder.ignored_query_parameters>`
	// have priority over this strict validation behavior.
	reject_unknown_query_parameters?: bool
	// "id: 456" in the body will override "id=123" in the binding.
	//
	// If this field is set to true, the request will be rejected if the binding
	// value is different from the body value.
	reject_binding_body_field_collisions?: bool
}
