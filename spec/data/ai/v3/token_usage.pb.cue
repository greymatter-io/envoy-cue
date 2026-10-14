package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/ai/v3"
)

// Quality of the extraction result.
#TokenUsage_ExtractionStatus: "EXTRACTION_STATUS_UNSPECIFIED" | "COMPLETE" | "PARTIAL" | "FAILED"

TokenUsage_ExtractionStatus_EXTRACTION_STATUS_UNSPECIFIED: "EXTRACTION_STATUS_UNSPECIFIED"
TokenUsage_ExtractionStatus_COMPLETE:                      "COMPLETE"
TokenUsage_ExtractionStatus_PARTIAL:                       "PARTIAL"
TokenUsage_ExtractionStatus_FAILED:                        "FAILED"

// Canonical LLM token usage extracted from a provider response by the
// :ref:`AI Protocol Manager filter <config_http_filters_ai_protocol_manager>`,
// published as typed dynamic metadata under one namespace at a clean end of
// stream.
//
// Counts are normalized onto one *inclusive* contract regardless of wire API:
// “input_tokens“ covers all input consumed (uncached input, cached reads,
// cache writes, and tool-use prompt tokens) and “output_tokens“ covers all
// generated output including reasoning/thought tokens; the detail messages
// are subsets of those canonical values. Every value remains
// provider-reported and is not independently verified by Envoy.
//
// Every count is optional: wire APIs report different subsets, and a
// status-only record (“llm_protocol“, “model“ when captured, and
// “extraction_status: FAILED“) is published when extraction failed
// outright, distinguishing that from a response that supplied no usage
// (which publishes nothing).
// [#next-free-field: 10]
#TokenUsage: {
	"@type": "type.googleapis.com/envoy.data.ai.v3.TokenUsage"
	// The wire API the usage was extracted from. This names an API contract,
	// not a provider identity: any OpenAI-compatible backend reports an OpenAI
	// protocol here.
	llm_protocol?: v3.#LLMProtocol
	// The model reported by the response, when present.
	model?: string
	// Canonical inclusive input token count.
	input_tokens?: uint64
	// Canonical inclusive output token count.
	output_tokens?: uint64
	// Canonical total: ``input_tokens + output_tokens``. Present only when
	// both canonical components are known, so the triple is always internally
	// consistent. Compare against ``provider_total_tokens`` to detect a
	// provider that reports inconsistently or in buckets unknown to the
	// extractor.
	total_tokens?: uint64
	// Canonical input token breakdown.
	input_token_details?: #InputTokenDetails
	// Canonical output token breakdown.
	output_token_details?: #OutputTokenDetails
	// The total token count reported directly by the provider, when it
	// reported one — preserved regardless of whether it agrees with
	// ``total_tokens``.
	provider_total_tokens?: uint64
	// Quality of the extraction result.
	extraction_status?: #TokenUsage_ExtractionStatus
}

// Subsets of :ref:`input_tokens
// <envoy_v3_api_field_data.ai.v3.TokenUsage.input_tokens>`.
#InputTokenDetails: {
	"@type": "type.googleapis.com/envoy.data.ai.v3.InputTokenDetails"
	// Cache-read input tokens.
	cached_tokens?: uint64
	// Cache-creation (cache-write) input tokens.
	cache_creation_tokens?: uint64
	// Tool-use prompt tokens.
	tool_use_tokens?: uint64
}

// Subsets of :ref:`output_tokens
// <envoy_v3_api_field_data.ai.v3.TokenUsage.output_tokens>`.
#OutputTokenDetails: {
	"@type": "type.googleapis.com/envoy.data.ai.v3.OutputTokenDetails"
	// Reasoning or thought tokens.
	reasoning_tokens?: uint64
}
