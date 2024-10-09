package v3

import (
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
)

// Optional configuration options to be used with json_format.
#JsonFormatOptions: {
	"@type": "type.googleapis.com/envoy.config.core.v3.JsonFormatOptions"
	// The output JSON string properties will be sorted.
	sort_properties?: bool
}

// Configuration to use multiple :ref:`command operators <config_access_log_command_operators>`
// to generate a new string in either plain text or JSON format.
// [#next-free-field: 8]
#SubstitutionFormatString: {
	"@type": "type.googleapis.com/envoy.config.core.v3.SubstitutionFormatString"
	// Specify a format with command operators to form a text string.
	// Its details is described in :ref:`format string<config_access_log_format_strings>`.
	//
	// For example, setting “text_format“ like below,
	//
	// .. validated-code-block:: yaml
	//
	//	:type-name: envoy.config.core.v3.SubstitutionFormatString
	//
	//	text_format: "%LOCAL_REPLY_BODY%:%RESPONSE_CODE%:path=%REQ(:path)%\n"
	//
	// generates plain text similar to:
	//
	// .. code-block:: text
	//
	//	upstream connect error:503:path=/foo
	//
	// Deprecated in favor of :ref:`text_format_source <envoy_v3_api_field_config.core.v3.SubstitutionFormatString.text_format_source>`. To migrate text format strings, use the :ref:`inline_string <envoy_v3_api_field_config.core.v3.DataSource.inline_string>` field.
	//
	// Deprecated: Marked as deprecated in envoy/config/core/v3/substitution_format_string.proto.
	text_format?: string
	// Specify a format with command operators to form a JSON string.
	// Its details is described in :ref:`format dictionary<config_access_log_format_dictionaries>`.
	// Values are rendered as strings, numbers, or boolean values as appropriate.
	// Nested JSON objects may be produced by some command operators (e.g. FILTER_STATE or DYNAMIC_METADATA).
	// See the documentation for a specific command operator for details.
	//
	// .. validated-code-block:: yaml
	//
	//	:type-name: envoy.config.core.v3.SubstitutionFormatString
	//
	//	json_format:
	//	  status: "%RESPONSE_CODE%"
	//	  message: "%LOCAL_REPLY_BODY%"
	//
	// The following JSON object would be created:
	//
	// .. code-block:: json
	//
	//	{
	//	  "status": 500,
	//	  "message": "My error message"
	//	}
	json_format?: structpb.#Struct
	// Specify a format with command operators to form a text string.
	// Its details is described in :ref:`format string<config_access_log_format_strings>`.
	//
	// For example, setting “text_format“ like below,
	//
	// .. validated-code-block:: yaml
	//
	//	:type-name: envoy.config.core.v3.SubstitutionFormatString
	//
	//	text_format_source:
	//	  inline_string: "%LOCAL_REPLY_BODY%:%RESPONSE_CODE%:path=%REQ(:path)%\n"
	//
	// generates plain text similar to:
	//
	// .. code-block:: text
	//
	//	upstream connect error:503:path=/foo
	text_format_source?: #DataSource
	// If set to true, when command operators are evaluated to null,
	//
	//   - for “text_format“, the output of the empty operator is changed from “-“ to an
	//     empty string, so that empty values are omitted entirely.
	//   - for “json_format“ the keys with null values are omitted in the output structure.
	omit_empty_values?: bool
	// Specify a “content_type“ field.
	// If this field is not set then “text/plain“ is used for “text_format“ and
	// “application/json“ is used for “json_format“.
	//
	// .. validated-code-block:: yaml
	//
	//	:type-name: envoy.config.core.v3.SubstitutionFormatString
	//
	//	content_type: "text/html; charset=UTF-8"
	content_type?: string
	// Specifies a collection of Formatter plugins that can be called from the access log configuration.
	// See the formatters extensions documentation for details.
	// [#extension-category: envoy.formatter]
	formatters?: [...#TypedExtensionConfig]
	// If json_format is used, the options will be applied to the output JSON string.
	json_format_options?: #JsonFormatOptions
}
