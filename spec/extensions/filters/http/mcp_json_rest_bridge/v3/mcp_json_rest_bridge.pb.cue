package v3

// The cache scope of a cacheable MCP result, emitted as the “cacheScope“ result field.
#CacheScope: "CACHE_SCOPE_UNSPECIFIED" | "CACHE_SCOPE_PUBLIC" | "CACHE_SCOPE_PRIVATE"

CacheScope_CACHE_SCOPE_UNSPECIFIED: "CACHE_SCOPE_UNSPECIFIED"
CacheScope_CACHE_SCOPE_PUBLIC:      "CACHE_SCOPE_PUBLIC"
CacheScope_CACHE_SCOPE_PRIVATE:     "CACHE_SCOPE_PRIVATE"

// Where to store parsed MCP request attributes.
#McpJsonRestBridge_RequestStorageMode: "MODE_UNSPECIFIED" | "DYNAMIC_METADATA"

McpJsonRestBridge_RequestStorageMode_MODE_UNSPECIFIED: "MODE_UNSPECIFIED"
McpJsonRestBridge_RequestStorageMode_DYNAMIC_METADATA: "DYNAMIC_METADATA"

// The target HTTP element type to bind to.
#HttpRule_ParameterBinding_Type: "TYPE_UNSPECIFIED" | "HEADER" | "COOKIE"

HttpRule_ParameterBinding_Type_TYPE_UNSPECIFIED: "TYPE_UNSPECIFIED"
HttpRule_ParameterBinding_Type_HEADER:           "HEADER"
HttpRule_ParameterBinding_Type_COOKIE:           "COOKIE"

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
// [#next-free-field: 9]
#McpJsonRestBridge: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.McpJsonRestBridge"
	// General server information.
	server_info?: #ServerInfo
	// Configuration for the MCP tools.
	tool_config?: #ServerToolConfig
	// Maximum size of the request body to buffer for transcoding and validation.
	// If the request body exceeds this size, the request is rejected with ``413 Payload Too Large``.
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
	// When set to ``DYNAMIC_METADATA``, attributes are stored in dynamic metadata
	// using the filter's config name (i.e. the ``name`` field of this filter's entry
	// in the ``http_filters`` list) as the metadata namespace.
	request_storage_mode?: #McpJsonRestBridge_RequestStorageMode
	// If set, extract OpenTelemetry (OTel) trace context from MCP requests and propagate it to
	// request headers. The keys ``traceparent``, ``tracestate``, and ``baggage``
	// will be extracted from ``_meta``.
	// Ref: `Request Meta SEP <https://modelcontextprotocol.io/seps/414-request-meta>`_
	trace_context_extraction?: #TraceContextExtractionOptions
	// When set to true, the filter will not clear the route cache after transcoding.
	// This allows the route to be re-selected based on the updated request path or method.
	disable_clear_route_cache?: bool
	// When set to true, the filter will take no action unless per-route config is available.
	per_route_only?: bool
}

// Options for trace context extraction.
#TraceContextExtractionOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.TraceContextExtractionOptions"
}

// Cache configuration for a locally-generated, cacheable MCP result.
#CacheConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.CacheConfig"
	// How long the result may be reused, emitted as the MCP ``ttlMs`` result field.
	//
	// If not provided: Defaults to 0, meaning clients should revalidate before reusing the result.
	ttl?: string
	// The cache scope of the result.
	//
	// If not provided: Defaults to ``CACHE_SCOPE_PUBLIC``.
	cache_scope?: #CacheScope
}

// Configuration for the server metadata.
#ServerInfo: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.ServerInfo"
	// The maximum MCP protocol version supported by this MCP endpoint.
	//
	// Supported values are ``2025-11-25`` and ``2026-07-28``. Versions prior
	// to ``2025-11-25`` are rejected because the filter unconditionally supports features
	// up to ``2025-11-25`` and does not support downgrading below that baseline.
	// If not provided: Defaults to ``2025-11-25``.
	//
	// Example value: "2026-07-28"
	max_supported_protocol_version?: string
	// [#not-implemented-hide:]
	// [#comment:TODO(guoyilin42): Implement description]
	// Optional description of the server.
	description?: string
	// The fallback protocol version to use if the client does not provide the ``mcp-protocol-version`` header.
	//
	// - If provided: The extension uses this version as the fallback protocol version.
	// - If not provided: The extension uses the fallback protocol version defined in the latest MCP
	//   specification. For example, the current latest 2026-07-28 specification designates "2025-03-26"
	//   as the fallback protocol version.
	//   See https://modelcontextprotocol.io/specification/2026-07-28/basic/transports/streamable-http#protocol-version-header
	fallback_protocol_version?: string
	// Cache configuration advertised in locally-generated ``server/discover`` responses.
	//
	// If not provided: the response advertises ``ttlMs: 0`` and ``cacheScope: public``.
	server_discovery_cache_config?: #CacheConfig
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
	// (whether from an upstream backend, a configured ``direct_response``, or another extension)
	// MUST be a JSON body strictly matching the MCP ``ListToolsResult`` schema. Ref:
	// https://modelcontextprotocol.io/specification/2025-11-25/schema#listtoolsresult
	tool_list_http_rule?: #HttpRule
	// If provided: The extension sends a local response, according to each tool's
	// ToolsListSpecificConfig.
	tool_list_local?: #ToolsListLocal
	// Default server info for tools without specific ones. If not provided, a fallback path of '/mcp' will be used.
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
	// Enables streaming transcoding for unstructured text responses (``content`` field of a result).
	//
	// When enabled, the response body is streamed directly to the client without buffering. Each
	// chunk is JSON escaped as it arrives and wrapped with a pre-built JSON-RPC prefix and suffix.
	//
	// For Server-Sent Events (SSE) responses (i.e. ``text/event-stream`` content type), Envoy parses
	// the stream and wraps each extracted complete event payload into a distinct text content item
	// within the JSON-RPC ``content`` array on the fly.
	//
	// Streaming flow:
	//
	// .. code-block:: text
	//
	//   input:  [chunk1] → [chunk2] → [chunk3]
	//   output: [prefix+escaped_chunk1] → [escaped_chunk2] → [escaped_chunk3+suffix]
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
// [#next-free-field: 8]
#HttpRule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.HttpRule"
	// Determines the HTTP method and the URL path template.
	//
	// Path templating uses curly braces ``{}`` to mark a section of the URL path as replaceable.
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
	// - If "*": All fields not bound by the path template are mapped to the request body.
	// - If specify a field: This specific field is mapped to the body. Uses dot-notation for nested
	//   fields (e.g., "user.data" maps the value of the "data" field inside "user").
	// - If omitted: There is no HTTP request body; fields not in the path become query parameters.
	body?: string
	// Bindings to extract values from the 'arguments' object of a tools/call
	// request and inject them as HTTP elements.
	bindings?: [...#HttpRule_ParameterBinding]
}

// Per-route override configuration for the MCP JSON REST Bridge filter.
#McpJsonRestBridgePerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.McpJsonRestBridgePerRoute"
	tool_config?: [...#ServerToolConfig]
}

// Represents a mapping from a request message field to an HTTP element.
// If the specified argument is missing from the tools/call request, the binding is silently
// ignored and the corresponding HTTP element (header or cookie) is not added.
#HttpRule_ParameterBinding: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.mcp_json_rest_bridge.v3.HttpRule_ParameterBinding"
	// The type of the HTTP element to bind to.
	type?: #HttpRule_ParameterBinding_Type
	// The name of the HTTP header (e.g., "X-API-Key", "Authorization") or the
	// name of the cookie (e.g.,"SESSION_ID"). Note: Envoy normalizes the header names to lowercase.
	// The following headers are reserved for Envoy's internal use and cannot be overridden by
	// bindings: ``content-length``, ``transfer-encoding``, ``host``, ``:authority``, ``cookie``,
	// ``accept-encoding``, and any header starting with ``x-envoy-``. Attempting to bind to these
	// will be ignored.
	name?: string
	// Path to the field within the JSON arguments object from a tools/call
	// request. Uses dot-notation for nested fields.
	// E.g. if arguments object is ``{"user":{"auth_token":"foo"}}``, then
	// ``argument_path`` should be "user.auth_token".
	argument_path?: string
}
