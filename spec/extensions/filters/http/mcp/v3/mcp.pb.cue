package v3

// Traffic handling mode for non-MCP traffic.
#Mcp_TrafficMode: "PASS_THROUGH" | "REJECT_NO_MCP"

Mcp_TrafficMode_PASS_THROUGH:  "PASS_THROUGH"
Mcp_TrafficMode_REJECT_NO_MCP: "REJECT_NO_MCP"

// Where to store parsed MCP request attributes.
#Mcp_RequestStorageMode: "MODE_UNSPECIFIED" | "DYNAMIC_METADATA" | "FILTER_STATE" | "DYNAMIC_METADATA_AND_FILTER_STATE"

Mcp_RequestStorageMode_MODE_UNSPECIFIED:                  "MODE_UNSPECIFIED"
Mcp_RequestStorageMode_DYNAMIC_METADATA:                  "DYNAMIC_METADATA"
Mcp_RequestStorageMode_FILTER_STATE:                      "FILTER_STATE"
Mcp_RequestStorageMode_DYNAMIC_METADATA_AND_FILTER_STATE: "DYNAMIC_METADATA_AND_FILTER_STATE"

// This filter will inspect and get attributes from MCP traffic.
// [#next-free-field: 9]
#Mcp: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp.v3.Mcp"
	// Configures how the filter handles non-MCP traffic.
	traffic_mode?: #Mcp_TrafficMode
	// When set to true, the filter will clear the route cache after setting dynamic metadata.
	// This allows the route to be re-selected based on the MCP metadata (e.g., method, params).
	// Defaults to false.
	clear_route_cache?: bool
	// Maximum size of the request body to buffer for JSON-RPC parsing.
	// Only the first “max_request_body_size“ bytes are parsed for MCP attribute extraction.
	//
	// When the body exceeds this limit:
	// - In “PASS_THROUGH“ mode: the request is allowed through with an “is_exceeding_limit“ marker in the dynamic metadata, indicating that the MCP payload was only partially parsed.
	// - In “REJECT_NO_MCP“ mode: the request is rejected with “400 Bad Request“ because the complete root JSON object must fit within the size limit.
	//
	// It defaults to 8KB (8192 bytes) and the maximum allowed value is 10MB (10485760 bytes).
	//
	// Setting it to 0 would disable the limit. It is not recommended to do so in production.
	max_request_body_size?: uint32
	// Parser configuration, this provide the attribute extraction override.
	parser_config?: #ParserConfig
	// Where to store parsed MCP request attributes.
	// Controls whether attributes are written to dynamic metadata, filter state, or both.
	// Default is DYNAMIC_METADATA when unspecified.
	request_storage_mode?: #Mcp_RequestStorageMode
	// If set, extract and validate W3C trace context from the MCP request body
	// (params._meta.traceparent & params._meta.tracestate) and propagate it in HTTP headers
	// “traceparent“ and “tracestate“ (respectively).
	//
	// The traceparent and tracestate fields are validated and propagated according to the spec at
	// “https://www.w3.org/TR/trace-context/“.
	//
	// If unset (default), do not extract or inject trace context.
	propagate_trace_context?: #Mcp_TraceContextPropagationConfig
	// Note that this is independent of “propagate_trace_context“.
	// Also note that if this is set, the downstream request's baggage header will be overwritten if
	// the MCP request body contains a valid baggage field.
	//
	// If unset (default), do not extract or inject baggage.
	propagate_baggage?: #Mcp_BaggagePropagationConfig
	// When true, reject requests that contain duplicate JSON keys at any
	// nesting level. RFC 8259 Section 4 states that names within an object SHOULD be
	// unique. Defaults to false (last-key-wins / last-win).
	reject_duplicate_keys?: bool
}

// Parser configuration with method-specific rules.
// This configuration allows overriding the default attribute extraction behavior for specific MCP methods.
#ParserConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp.v3.ParserConfig"
	// List of rules for classification and extraction.
	// Rules are evaluated in order; the first match wins.
	// If no rule matches, extraction defaults are used and group falls back to built-in classification.
	// Built-in groups: lifecycle, tool, resource, prompt, notification, logging, sampling, completion, unknown.
	methods?: [...#ParserConfig_MethodConfig]
	// The dynamic metadata key where the group name will be stored.
	// If empty, group classification is disabled.
	group_metadata_key?: string
}

// Per-route override configuration for MCP filter
#McpOverride: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp.v3.McpOverride"
	// Optional per-route traffic mode override
	traffic_mode?: #Mcp_TrafficMode
	// Optional per-route max request body size override.
	// When set, this overrides the global max_request_body_size for this route.
	// It defaults to 8KB (8192 bytes) and the maximum allowed value is 10MB (10485760 bytes).
	max_request_body_size?: uint32
}

#Mcp_TraceContextPropagationConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp.v3.Mcp_TraceContextPropagationConfig"
}

#Mcp_BaggagePropagationConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp.v3.Mcp_BaggagePropagationConfig"
}

// A single attribute extraction rule.
#ParserConfig_AttributeExtractionRule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp.v3.ParserConfig_AttributeExtractionRule"
	// JSON path to extract (e.g., "params.name", "params.uri").
	// The path is a dot-separated string representing the location of the field in the JSON payload.
	// For example, "params.name" extracts the "name" field from the "params" object.
	path?: string
}

// Configuration for a specific MCP method.
#ParserConfig_MethodConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp.v3.ParserConfig_MethodConfig"
	// Method name (e.g., "tools/call", "resources/read", "initialize").
	// This matches the "method" field in the JSON-RPC request.
	method?: string
	// The group/category name to assign to this method (e.g., "tool", "lifecycle").
	// This will be emitted to dynamic metadata under the key specified by group_metadata_key.
	// If empty, the built-in group classification is used.
	group?: string
	// Attributes to extract for this method.
	// If empty, only default attributes (jsonrpc, method) are extracted.
	extraction_rules?: [...#ParserConfig_AttributeExtractionRule]
}
