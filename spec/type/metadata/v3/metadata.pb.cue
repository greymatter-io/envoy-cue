package v3

// MetadataKey provides a way to retrieve values from
// :ref:`Metadata <envoy_v3_api_msg_config.core.v3.Metadata>` using a “key“ and a “path“.
//
// For example, consider the following Metadata:
//
// .. code-block:: yaml
//
//	filter_metadata:
//	  envoy.xxx:
//	    prop:
//	      foo: bar
//	      xyz:
//	        hello: envoy
//
// The following MetadataKey would retrieve the string value "bar" from the Metadata:
//
// .. code-block:: yaml
//
//	key: envoy.xxx
//	path:
//	- key: prop
//	- key: foo
#MetadataKey: {
	"@type": "type.googleapis.com/envoy.type.metadata.v3.MetadataKey"
	// The key name of the Metadata from which to retrieve the Struct.
	// This typically represents a builtin subsystem or custom extension.
	key?: string
	// The path used to retrieve a specific Value from the Struct.
	// This can be either a prefix or a full path, depending on the use case.
	// For example, ``[{key: prop}, {key: xyz}]`` would retrieve a struct or ``[{key: prop}, {key: foo}]``
	// would retrieve a string in the example above.
	//
	// Path segments support both struct field access (via ``key``) and list element access (via ``index``).
	// For example, to access the first element of a list at ``envoy.filters.http.grpc_field_extraction.tenant_id``,
	// use ``path: [{key: tenant_id}, {index: 0}]``.
	path?: [...#MetadataKey_PathSegment]
}

// Describes different types of metadata sources.
#MetadataKind: {
	"@type": "type.googleapis.com/envoy.type.metadata.v3.MetadataKind"
	// Request kind of metadata.
	request?: #MetadataKind_Request
	// Route kind of metadata.
	route?: #MetadataKind_Route
	// Cluster kind of metadata.
	cluster?: #MetadataKind_Cluster
	// Host kind of metadata.
	host?: #MetadataKind_Host
}

// Specifies a segment in a path for retrieving values from Metadata.
// Supports both key-based segments (field names in a Struct) and index-based
// segments (element access in a ListValue).
#MetadataKey_PathSegment: {
	"@type": "type.googleapis.com/envoy.type.metadata.v3.MetadataKey_PathSegment"
	// If specified, use this key to retrieve the value in a Struct.
	key?: string
	// If specified, use this index to retrieve a value from a ListValue.
	index?: uint32
}

// Represents dynamic metadata associated with the request.
#MetadataKind_Request: {
	"@type": "type.googleapis.com/envoy.type.metadata.v3.MetadataKind_Request"
}

// Represents metadata from :ref:`the route<envoy_v3_api_field_config.route.v3.Route.metadata>`.
#MetadataKind_Route: {
	"@type": "type.googleapis.com/envoy.type.metadata.v3.MetadataKind_Route"
}

// Represents metadata from :ref:`the upstream cluster<envoy_v3_api_field_config.cluster.v3.Cluster.metadata>`.
#MetadataKind_Cluster: {
	"@type": "type.googleapis.com/envoy.type.metadata.v3.MetadataKind_Cluster"
}

// Represents metadata from :ref:`the upstream
// host<envoy_v3_api_field_config.endpoint.v3.LbEndpoint.metadata>`.
#MetadataKind_Host: {
	"@type": "type.googleapis.com/envoy.type.metadata.v3.MetadataKind_Host"
}
