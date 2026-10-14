package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/ai/v3"
)

// Validates the request payload against the payload schema of its wire API, and rejects a payload
// that violates it with a 400. Configure it first, so the AI filters after it see the API it
// resolved and only a payload that passed.
#SchemaValidation: {
	"@type": "type.googleapis.com/envoy.extensions.http.ai_filters.schema_validation.v3.SchemaValidation"
	// The wire API for a request that declares none, through either the
	// ``envoy.ai.llm_protocol.request`` filter state object or the route's :ref:`llm_protocol
	// <envoy_v3_api_field_extensions.filters.http.ai_protocol_manager.v3.RequestPerRoute.llm_protocol>`.
	// ``LLM_PROTOCOL_UNSPECIFIED``, the default, detects it from the request path, then the
	// ``anthropic-version`` header, then the payload's shape. A request none of them identifies is
	// forwarded unvalidated.
	default_llm_protocol?: v3.#LLMProtocol
	// Forward a payload that violates its schema instead of rejecting it. It is still counted.
	fail_open?: bool
}
