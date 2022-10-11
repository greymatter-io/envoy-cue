package v3

// A connection pool which forwards downstream TCP as TCP or HTTP to upstream,
// based on CONNECT configuration.
// [#extension: envoy.upstreams.tcp.generic]
#GenericConnectionPoolProto: {
	"@type": "type.googleapis.com/envoy.extensions.upstreams.tcp.generic.v3.GenericConnectionPoolProto"
}
