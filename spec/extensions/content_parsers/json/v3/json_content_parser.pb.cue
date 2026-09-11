package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/filters/http/json_to_metadata/v3"
)

// Configuration for the JSON content parser.
#JsonContentParser: {
	"@type": "type.googleapis.com/envoy.extensions.content_parsers.json.v3.JsonContentParser"
	// The rules to apply for extracting values from JSON content.
	// Rules are evaluated in order for each content item provided.
	// At least one rule must be specified.
	rules?: [...#JsonContentParser_RuleConfig]
}

// Configuration for a single rule with its processing behavior.
#JsonContentParser_RuleConfig: {
	"@type": "type.googleapis.com/envoy.extensions.content_parsers.json.v3.JsonContentParser_RuleConfig"
	// The json-to-metadata rule to apply for extracting values from JSON content.
	// See :ref:`json_to_metadata rule <envoy_v3_api_msg_extensions.filters.http.json_to_metadata.v3.JsonToMetadata.Rule>`
	// for available configuration options including selectors, on_present, on_missing, on_error actions.
	rule?: v3.#JsonToMetadata_Rule
	// Controls how many times this rule should successfully match before stopping evaluation
	// of this rule for subsequent content items.
	//
	//   - If set to 0 (default): This rule is evaluated against all content items provided.
	//     Later matches may overwrite earlier values (unless
	//     :ref:`preserve_existing_metadata_value <envoy_v3_api_field_extensions.filters.http.json_to_metadata.v3.JsonToMetadata.KeyValuePair.preserve_existing_metadata_value>`
	//     is set in the rule), effectively extracting the LAST occurrence.
	//
	//   - If set to 1: Stop evaluating this rule after the first successful match.
	//     This is useful for extracting values that appear early in the stream
	//     to avoid unnecessary processing of subsequent content.
	//
	//   - If set to N > 1: Reserved for future use (e.g., aggregating multiple values).
	//     Values > 1 are currently rejected to prevent behavioral changes when this feature is implemented.
	//
	// Example use cases:
	//
	//   - Extract model name from early content: “stop_processing_after_matches: 1“
	//     (Stops checking this rule after first match, doesn't process remaining content for this rule)
	//
	//   - Extract token usage from final content: “stop_processing_after_matches: 0“
	//     (Processes all content items, extracts value from the last one that contains it)
	stop_processing_after_matches?: uint32
}
