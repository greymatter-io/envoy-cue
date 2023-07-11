package v2alpha1

// Dubbo Protocol types supported by Envoy.
#ProtocolType: "Dubbo"

ProtocolType_Dubbo: "Dubbo"

// Dubbo Serialization types supported by Envoy.
#SerializationType: "Hessian2"

SerializationType_Hessian2: "Hessian2"

// [#next-free-field: 6]
#DubboProxy: {
	"@type": "type.googleapis.com/envoy.config.filter.network.dubbo_proxy.v2alpha1.DubboProxy"
	// The human readable prefix to use when emitting statistics.
	stat_prefix?: string
	// Configure the protocol used.
	protocol_type?: #ProtocolType
	// Configure the serialization protocol used.
	serialization_type?: #SerializationType
	// The route table for the connection manager is static and is specified in this property.
	route_config?: [...#RouteConfiguration]
	// A list of individual Dubbo filters that make up the filter chain for requests made to the
	// Dubbo proxy. Order matters as the filters are processed sequentially. For backwards
	// compatibility, if no dubbo_filters are specified, a default Dubbo router filter
	// (`envoy.filters.dubbo.router`) is used.
	dubbo_filters?: [...#DubboFilter]
}

// DubboFilter configures a Dubbo filter.
#DubboFilter: {
	"@type": "type.googleapis.com/envoy.config.filter.network.dubbo_proxy.v2alpha1.DubboFilter"
	// The name of the filter to instantiate. The name must match a supported
	// filter.
	name?: string
	// Filter specific configuration which depends on the filter being
	// instantiated. See the supported filters for further documentation.
	config?: _
}
