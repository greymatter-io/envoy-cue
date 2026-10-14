package v3

// Publishes :ref:`RequestInfo <envoy_v3_api_msg_data.ai.v3.RequestInfo>` as typed
// dynamic metadata. On a declared endpoint with a body, it is written before the
// request headers continue, so later HTTP filters see it from their first callback.
#RequestInfo: {
	"@type": "type.googleapis.com/envoy.extensions.http.ai_filters.request_info.v3.RequestInfo"
	// Metadata namespace. Defaults to ``envoy.ai.request_info``.
	metadata_namespace?: string
	// When unset, no estimate is published.
	token_estimation?: #RequestInfo_TokenEstimation
}

// Estimates the input tokens from the size of the request payload, for consumers that must
// budget before the provider reports what it actually charged.
#RequestInfo_TokenEstimation: {
	"@type": "type.googleapis.com/envoy.extensions.http.ai_filters.request_info.v3.RequestInfo_TokenEstimation"
	// Estimated input tokens, as ``ceil(tokens_per_byte * request payload bytes)``. No token
	// spans fewer than one byte, so the ratio cannot exceed 1.0; ``0.5`` is a rough fit for
	// JSON chat payloads.
	tokens_per_byte?: float64
}
