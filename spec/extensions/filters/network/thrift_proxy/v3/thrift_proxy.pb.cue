package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/accesslog/v3"
)

// Thrift transport types supported by Envoy.
#TransportType: "AUTO_TRANSPORT" | "FRAMED" | "UNFRAMED" | "HEADER"

TransportType_AUTO_TRANSPORT: "AUTO_TRANSPORT"
TransportType_FRAMED:         "FRAMED"
TransportType_UNFRAMED:       "UNFRAMED"
TransportType_HEADER:         "HEADER"

// Thrift Protocol types supported by Envoy.
#ProtocolType: "AUTO_PROTOCOL" | "BINARY" | "LAX_BINARY" | "COMPACT" | "TWITTER"

ProtocolType_AUTO_PROTOCOL: "AUTO_PROTOCOL"
ProtocolType_BINARY:        "BINARY"
ProtocolType_LAX_BINARY:    "LAX_BINARY"
ProtocolType_COMPACT:       "COMPACT"
ProtocolType_TWITTER:       "TWITTER"

#Trds: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.Trds"
	// Configuration source specifier.
	// In case of ``api_config_source`` only aggregated ``api_type`` is supported.
	config_source?: v3.#ConfigSource
	// The name of the route configuration. This allows to use different route
	// configurations. Tells which route configuration should be fetched from the configuration source.
	// Leave unspecified is also valid and means the unnamed route configuration.
	route_config_name?: string
}

// [#next-free-field: 11]
#ThriftProxy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.ThriftProxy"
	// Supplies the type of transport that the Thrift proxy should use. Defaults to
	// :ref:`AUTO_TRANSPORT<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.TransportType.AUTO_TRANSPORT>`.
	transport?: #TransportType
	// Supplies the type of protocol that the Thrift proxy should use. Defaults to
	// :ref:`AUTO_PROTOCOL<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.ProtocolType.AUTO_PROTOCOL>`.
	protocol?: #ProtocolType
	// The human readable prefix to use when emitting statistics.
	stat_prefix?: string
	// The route table for the connection manager is static and is specified in this property.
	// It is invalid to define both ``route_config`` and ``trds``.
	route_config?: #RouteConfiguration
	// Use xDS to fetch the route configuration. It is invalid to define both ``route_config`` and ``trds``.
	trds?: #Trds
	// A list of individual Thrift filters that make up the filter chain for requests made to the
	// Thrift proxy. Order matters as the filters are processed sequentially. For backwards
	// compatibility, if no thrift_filters are specified, a default Thrift router filter
	// (``envoy.filters.thrift.router``) is used.
	// [#extension-category: envoy.thrift_proxy.filters]
	thrift_filters?: [...#ThriftFilter]
	// If set to true, Envoy will try to skip decode data after metadata in the Thrift message.
	// This mode will only work if the upstream and downstream protocols are the same and the transports
	// are Framed or Header, and the protocol is not Twitter. Otherwise Envoy will
	// fallback to decode the data.
	payload_passthrough?: bool
	// Optional maximum requests for a single downstream connection. If not specified, there is no limit.
	max_requests_per_connection?: uint32
	// Configuration for :ref:`access logs <arch_overview_access_logs>`
	// emitted by Thrift proxy.
	access_log?: [...v31.#AccessLog]
	// If set to true, Envoy will preserve the case of Thrift header keys instead of serializing them to
	// lower case as per the default behavior. Note that NUL, CR and LF characters will also be preserved
	// as mandated by the Thrift spec.
	//
	// More info: https://github.com/apache/thrift/commit/e165fa3c85d00cb984f4d9635ed60909a1266ce1.
	header_keys_preserve_case?: bool
}

// ThriftFilter configures a Thrift filter.
#ThriftFilter: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.ThriftFilter"
	// The name of the filter to instantiate. The name must match a supported
	// filter. The built-in filters are:
	//
	// [#comment:TODO(zuercher): Auto generate the following list]
	// * :ref:`envoy.filters.thrift.router <config_thrift_filters_router>`
	// * :ref:`envoy.filters.thrift.rate_limit <config_thrift_filters_rate_limit>`
	name?:         string
	typed_config?: _
}

// ThriftProtocolOptions specifies Thrift upstream protocol options. This object is used in
// in
// :ref:`typed_extension_protocol_options<envoy_v3_api_field_config.cluster.v3.Cluster.typed_extension_protocol_options>`,
// keyed by the name ``envoy.filters.network.thrift_proxy``.
#ThriftProtocolOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.thrift_proxy.v3.ThriftProtocolOptions"
	// Supplies the type of transport that the Thrift proxy should use for upstream connections.
	// Selecting
	// :ref:`AUTO_TRANSPORT<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.TransportType.AUTO_TRANSPORT>`,
	// which is the default, causes the proxy to use the same transport as the downstream connection.
	transport?: #TransportType
	// Supplies the type of protocol that the Thrift proxy should use for upstream connections.
	// Selecting
	// :ref:`AUTO_PROTOCOL<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.ProtocolType.AUTO_PROTOCOL>`,
	// which is the default, causes the proxy to use the same protocol as the downstream connection.
	protocol?: #ProtocolType
}
