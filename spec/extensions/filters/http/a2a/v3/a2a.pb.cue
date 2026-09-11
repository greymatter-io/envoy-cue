package v3

// Traffic handling mode for non-A2A traffic.
#A2A_TrafficMode: "PASS_THROUGH" | "REJECT"

A2A_TrafficMode_PASS_THROUGH: "PASS_THROUGH"
A2A_TrafficMode_REJECT:       "REJECT"

// Where to store parsed A2A message attributes.
#A2A_StorageMode: "NONE" | "DYNAMIC_METADATA" | "FILTER_STATE" | "DYNAMIC_METADATA_AND_FILTER_STATE"

A2A_StorageMode_NONE:                              "NONE"
A2A_StorageMode_DYNAMIC_METADATA:                  "DYNAMIC_METADATA"
A2A_StorageMode_FILTER_STATE:                      "FILTER_STATE"
A2A_StorageMode_DYNAMIC_METADATA_AND_FILTER_STATE: "DYNAMIC_METADATA_AND_FILTER_STATE"

// This filter will inspect and get attributes from A2A traffic.
// [#next-free-field: 6]
#A2A: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.a2a.v3.A2A"
	// Configures how the filter handles non-A2A traffic.
	traffic_mode?: #A2A_TrafficMode
	// Maximum size of the request body to buffer for JSON-RPC validation.
	// If the request body exceeds this size, the request is rejected with “413
	// Payload Too Large“. This limit applies to both “REJECT“ and
	// “PASS_THROUGH“ modes to prevent unbounded buffering.
	//
	// It defaults to 8KB (8192 bytes) and the maximum allowed value is 10MB
	// (10485760 bytes).
	//
	// Setting it to 0 would disable the limit. It is not recommended to do so in
	// production.
	max_request_body_size?: uint32
	// Customized configuration for A2A parser.
	parser_config?: #ParserConfig
	// Where to store parsed A2A message attributes.
	// Controls whether attributes are written to dynamic metadata, filter state, or both.
	// Default is no storage.
	storage_mode?: #A2A_StorageMode
}

#MethodParsingConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.a2a.v3.MethodParsingConfig"
	// The group/category name to assign to this method (e.g., "tasks", "message").
	// If provided, this overrides any built-in classification for the method.
	// This will be emitted to dynamic metadata under the key specified by “group_metadata_key“.
	group?: string
	// List of attributes to extract for this method, specified by their JSON paths (e.g., "params.name").
	paths?: [...string]
}

#ParserConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.a2a.v3.ParserConfig"
	// Method-specific overrides for grouping and attribute extraction.
	// If a method is not specified in method_configs, or if 'group' is empty in its config,
	// its group will be determined by built-in classification based on method prefix
	// (e.g., "message" for "message/send") and default extraction rules will be applied for that method.
	method_configs?: [string]: #MethodParsingConfig
	// Attributes that should always be extracted regardless of the method.
	// Specified by their JSON paths (e.g., "params.id").
	always_extract_attributes?: [...string]
	// The dynamic metadata key under which the method's group name will be stored
	// (e.g., "a2a_group"). If this key is empty, group information will not be
	// added to dynamic metadata.
	group_metadata_key?: string
}
