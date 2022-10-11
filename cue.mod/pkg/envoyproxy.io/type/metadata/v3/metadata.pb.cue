package v3

// MetadataKey provides a general interface using ``key`` and ``path`` to retrieve value from
// :ref:`Metadata <envoy_v3_api_msg_config.core.v3.Metadata>`.
//
// For example, for the following Metadata:
//
// .. code-block:: yaml
//
//    filter_metadata:
//      envoy.xxx:
//        prop:
//          foo: bar
//          xyz:
//            hello: envoy
//
// The following MetadataKey will retrieve a string value "bar" from the Metadata.
//
// .. code-block:: yaml
//
//    key: envoy.xxx
//    path:
//    - key: prop
//    - key: foo
//
#MetadataKey: {
	"@type": "type.googleapis.com/envoy.type.metadata.v3.MetadataKey"
	// The key name of Metadata to retrieve the Struct from the metadata.
	// Typically, it represents a builtin subsystem or custom extension.
	key?: string
	// The path to retrieve the Value from the Struct. It can be a prefix or a full path,
	// e.g. ``[prop, xyz]`` for a struct or ``[prop, foo]`` for a string in the example,
	// which depends on the particular scenario.
	//
	// Note: Due to that only the key type segment is supported, the path can not specify a list
	// unless the list is the last segment.
	path?: [...#MetadataKey_PathSegment]
}

// Describes what kind of metadata.
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

// Specifies the segment in a path to retrieve value from Metadata.
// Currently it is only supported to specify the key, i.e. field name, as one segment of a path.
#MetadataKey_PathSegment: {
	"@type": "type.googleapis.com/envoy.type.metadata.v3.MetadataKey_PathSegment"
	// If specified, use the key to retrieve the value in a Struct.
	key?: string
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
