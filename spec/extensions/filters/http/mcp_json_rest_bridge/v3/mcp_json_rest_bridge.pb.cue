package v3

// Where to store parsed MCP request attributes.
#McpJsonRestBridge_RequestStorageMode: "MODE_UNSPECIFIED" | "DYNAMIC_METADATA"

McpJsonRestBridge_RequestStorageMode_MODE_UNSPECIFIED: "MODE_UNSPECIFIED"
McpJsonRestBridge_RequestStorageMode_DYNAMIC_METADATA: "DYNAMIC_METADATA"

// Configuration for the MCP MCP JSON REST Bridge.
//
// This extension translates Model Context Protocol (MCP) JSON-RPC requests into standard JSON-REST
// HTTP requests. This enables existing REST backends to function as MCP servers without native MCP
// support.
//
// Main functionalities:
//
//  1. Transcoding: Converts JSON-RPC request payload to HTTP REST request, and maps JSON response
//     back to JSON-RPC.
//  2. Session negotiation: Handles MCP connection prerequisites.
//
// The core logic transforms "tools/call" request into HTTP request following the “HttpRule“
// specification.
//
// Example 1: GET request with path and query parameters
//
// .. code-block:: text
//
//	tools: {
//	  name: "getResource"
//	  http_rule: {
//	    get: "/v1/projects/{project_id}/resources/{resource_id}"
//	    // body is omitted for GET
//	  }
//	}
//	If tools/call params are:
//	{ "name": "getResource", "arguments": {"project_id": "foo", "resource_id": "res-789", "view": "FULL"} }
//	Translation:
//	- Method: GET
//	- URL: /v1/projects/foo/resources/res-789?view=FULL
//	  (Arguments not matching path templates become query parameters.)
//
// Example 2: POST request with wildcard body
//
// .. code-block:: text
//
//	tools: {
//	  name: "createResource"
//	  http_rule: {
//	    post: "/v1/projects/{project_id}/resources"
//	    body: "*"
//	  }
//	}
//	If tools/call params are:
//	{ "name": "createResource", "arguments": {"project_id": "foo", "resource_id": "res-456", "payload": { "data": "some value" }} }
//	Translation:
//	- Method: POST
//	- URL: /v1/projects/foo/resources
//	- Body: {"resource_id": "res-456", "payload": { "data": "some value" }}
//	  (Arguments not used in the path form the body, as per body: "*".)
//
// Example 3: PUT request with a specific field as body
//
// .. code-block:: text
//
//	tools: {
//	  name: "updateResource"
//	  http_rule: {
//	    put: "/v1/projects/{project_id}"
//	    body: "payload"
//	  }
//	}
//	If tools/call params are:
//	{ "name": "updateResource", "arguments": {"project_id": "foo", "resource_id": "res-456", "payload": { "data": "updated value" }} }
//	Translation:
//	- Method: PUT
//	- URL: /v1/projects/foo?resource_id=res-456
//	- Body: {"data": "updated value"}
//	  (Only the "payload" field from arguments is used as the body. Other arguments not in the
//	  path, like 'resource_id', become query parameters.)
//
// [#next-free-field: 8]
#McpJsonRestBridge: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.McpJsonRestBridge"
	// General server information.
	server_info?: #ServerInfo
	// Configuration for the MCP tools.
	tool_config?: #ServerToolConfig
	// Maximum size of the request body to buffer for transcoding and validation.
	// If the request body exceeds this size, the request is rejected with “413 Payload Too Large“.
	// This limit applies to prevent unbounded buffering.
	//
	// It defaults to 64KB (65536 bytes) as the MCP calls (tools, resources, or prompts)
	// only pass small arguments or identifiers.
	//
	// Setting it to 0 would disable the limit. It is not recommended to do so in production.
	max_request_body_size?: uint32
	// Maximum size of the response body to buffer for transcoding.
	// If the response body exceeds this size, the response is rejected with an appropriate error.
	// This limit applies to prevent unbounded buffering.
	//
	// It defaults to 1MB (1048576 bytes) to prevent transcoding failures on large payloads like
	// file reads, while aligning with Envoy's standard default connection buffer limit.
	//
	// Setting it to 0 would disable the limit. It is not recommended to do so in production.
	max_response_body_size?: uint32
	// Where to store parsed MCP request attributes.
	// Default is not storing anything.
	// When set to “DYNAMIC_METADATA“, attributes are stored in dynamic metadata
	// using the filter's config name (i.e. the “name“ field of this filter's entry
	// in the “http_filters“ list) as the metadata namespace.
	request_storage_mode?: #McpJsonRestBridge_RequestStorageMode
	// If set, extract OpenTelemetry (OTel) trace context from MCP requests and propagate it to
	// request headers. The keys “traceparent“, “tracestate“, and “baggage“
	// will be extracted from “_meta“.
	// Ref: `Request Meta SEP <https://modelcontextprotocol.io/seps/414-request-meta>`_
	trace_context_extraction?: #TraceContextExtractionOptions
	// When set to true, the filter will not clear the route cache after transcoding.
	// This allows the route to be re-selected based on the updated request path or method.
	disable_clear_route_cache?: bool
}

// Options for trace context extraction.
#TraceContextExtractionOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.TraceContextExtractionOptions"
}

// Configuration for the server metadata.
#ServerInfo: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.ServerInfo"
	// [#not-implemented-hide:]
	// [#comment:TODO(guoyilin42): Implement supported_protocol_versions]
	// Lists the MCP protocol versions supported by this MCP endpoint.
	//
	//   - If provided: The extension enforces version negotiation according to the MCP specification:
	//     https://modelcontextprotocol.io/specification/2025-11-25/basic/lifecycle#version-negotiation
	//   - If not provided: The extension accepts any version sent by the client during negotiation and
	//     skips validation of the mcp-protocol-version header on subsequent requests.
	//
	// Example values: ["2025-11-25", "2025-06-18"]
	supported_protocol_versions?: [...string]
	// [#not-implemented-hide:]
	// [#comment:TODO(guoyilin42): Implement description]
	// Optional description of the server.
	description?: string
	// The fallback protocol version to use if the client does not provide the “mcp-protocol-version“ header.
	//
	//   - If provided: The extension uses this version as the fallback protocol version.
	//   - If not provided: The extension uses the fallback protocol version defined in the latest MCP
	//     specification. For example, the current latest 2025-11-25 specification designates "2025-03-26"
	//     as the fallback protocol version.
	//     See https://modelcontextprotocol.io/specification/2025-11-25/basic/transports#protocol-version-header
	fallback_protocol_version?: string
}

// Configuration for sending locally-generated responses to tools/list requests.
#ToolsListLocal: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.ToolsListLocal"
}

// Configuration for the MCP tool capability of the server.
// [#next-free-field: 6]
#ServerToolConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.ServerToolConfig"
	// List of MCP tools configurations.
	tools?: [...#ToolConfig]
	// [#not-implemented-hide:]
	// [#comment:TODO(guoyilin42): Implement list_changed]
	// Whether this server supports notifications for changes to the tool list.
	list_changed?: bool
	// Configuration to transcode the tools/list requests to a standard HTTP request. If provided:
	// The extension transcodes the request and forwards it down the filter chain. The response
	// (whether from an upstream backend, a configured “direct_response“, or another extension)
	// MUST be a JSON body strictly matching the MCP “ListToolsResult“ schema. Ref:
	// https://modelcontextprotocol.io/specification/2025-11-25/schema#listtoolsresult
	tool_list_http_rule?: #HttpRule
	// If provided: The extension sends a local response, according to each tool's
	// ToolsListSpecificConfig.
	tool_list_local?: #ToolsListLocal
	// [#not-implemented-hide:]
	// Default server info for tools without specific ones.
	default_server_info?: #McpServerInfo
}

// Configuration for a tool's entry in tools/list responses.
#ToolsListSpecificConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.ToolsListSpecificConfig"
	// Optional, human-readable name of the tool for display purposes.
	title?: string
	// Human-readable description of functionality.
	description?: string
	// A JSON Schema describing expected parameters, as a serialized JSON string, in the JSON Schema
	// 2020-12 dialect. This should be raw JSON, including the "properties" and "required" keys, but
	// not "type". Tools with no parameters may omit this to signify a tool with no constraints on the
	// parameters object, or set to '"additionalProperties": false' to require empty parameters.
	input_schema?: string
}

#McpServerInfo: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.McpServerInfo"
	// The path to the endpoint hosting this tool.
	path?: string
	// The host hosting this tool.
	host?: string
}

// [#next-free-field: 6]
#ToolConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.ToolConfig"
	// Unique identifier of the tool. Used both for tools/list and tools/call transcoding.
	name?: string
	// The HTTP configuration rules that apply to the normal backend.
	http_rule?: #HttpRule
	// Config for this tool's entry in a local tools/list response. Used when tool_list_local is set
	// in the ServerToolConfig.
	tool_list_config?: #ToolsListSpecificConfig
	// Enables streaming transcoding for unstructured text responses (“content“ field of a result).
	//
	// When enabled, the response body is streamed directly to the client without buffering. Each
	// chunk is JSON escaped as it arrives and wrapped with a pre-built JSON-RPC prefix and suffix.
	//
	// Streaming flow:
	//
	// .. code-block:: text
	//
	//	input:  [chunk1] → [chunk2] → [chunk3]
	//	output: [prefix+escaped_chunk1] → [escaped_chunk2] → [escaped_chunk3+suffix]
	//
	// Disabled by default.
	text_content_streaming_enabled?: bool
	// [#not-implemented-hide:]
	// Path and host of the MCP server that hosts this tool.
	server_info?: [...#McpServerInfo]
}

// Defines the schema of the JSON-RPC to REST mapping. It specifies how the "arguments"
// in a tools/call request are mapped to the URL path, query parameters, and HTTP request body.
//
// Mapping Rules:
//
//  1. Path: Fields defined in the path template (e.g., “/v1/resources/{id}“) are extracted from
//     arguments and placed in the URL.
//  2. Body: Determined by the “body“ field.
//     - If "*": All arguments not used in the path become the HTTP JSON body.
//     - If specify a field: Only that specific argument becomes the HTTP JSON body.
//     - If empty: No body is sent.
//  3. Query: Any leaf arguments not mapped to Path or Body are added as URL query parameters.
//
// [#next-free-field: 7]
#HttpRule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.HttpRule"
	// Determines the HTTP method and the URL path template.
	//
	// Path templating uses curly braces “{}“ to mark a section of the URL path as replaceable.
	// Each template variable MUST correspond to a field in the JSON-RPC "arguments".
	// Use dot-notation to access fields within nested objects (e.g., "user.id" maps the value of the
	// "id" field inside "user").
	//
	// To support backward compatibility with future methods, these are defined as individual fields
	// rather than a "oneof". If multiple fields are present, the one with the highest field number
	// highest priority) is the effective method.
	//
	// Maps to HTTP GET.
	get?: string
	// Maps to HTTP PUT.
	put?: string
	// Maps to HTTP POST.
	post?: string
	// Maps to HTTP DELETE.
	delete?: string
	// Maps to HTTP PATCH.
	patch?: string
	// The name of the request field whose value is mapped to the HTTP request body.
	//
	//   - If "*": All fields not bound by the path template are mapped to the request body.
	//   - If specify a field: This specific field is mapped to the body. Uses dot-notation for nested
	//     fields (e.g., "user.data" maps the value of the "data" field inside "user").
	//   - If omitted: There is no HTTP request body; fields not in the path become query parameters.
	body?: string
}

// Per-route override configuration for the MCP JSON REST Bridge filter.
#McpJsonRestBridgePerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.McpJsonRestBridgePerRoute"
	tool_config?: [...#ServerToolConfig]
}
