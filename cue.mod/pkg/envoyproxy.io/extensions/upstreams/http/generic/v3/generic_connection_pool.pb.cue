package v3

// A connection pool which forwards downstream HTTP as TCP or HTTP to upstream,
// based on CONNECT configuration.
// [#extension: envoy.upstreams.http.generic]
#GenericConnectionPoolProto: {
	"@type": "type.googleapis.com/envoy.extensions.upstreams.http.generic.v3.GenericConnectionPoolProto"
}
