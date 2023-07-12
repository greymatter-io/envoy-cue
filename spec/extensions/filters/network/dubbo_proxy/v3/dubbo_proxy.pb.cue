package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Dubbo Protocol types supported by Envoy.
#ProtocolType: "Dubbo"

ProtocolType_Dubbo: "Dubbo"

// Dubbo Serialization types supported by Envoy.
#SerializationType: "Hessian2"

SerializationType_Hessian2: "Hessian2"

#Drds: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dubbo_proxy.v3.Drds"
	// Configuration source specifier.
	// In case of ``api_config_source`` only aggregated ``api_type`` is supported.
	config_source?: v3.#ConfigSource
	// The name of the multiple route configuration. This allows to use different multiple route
	// configurations. Tells which multiple route configuration should be fetched from the configuration
	// source. Leave unspecified is also valid and means the unnamed multiple route configuration.
	route_config_name?: string
}

// [#next-free-field: 8]
#DubboProxy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dubbo_proxy.v3.DubboProxy"
	// The human readable prefix to use when emitting statistics.
	stat_prefix?: string
	// Configure the protocol used.
	protocol_type?: #ProtocolType
	// Configure the serialization protocol used.
	serialization_type?: #SerializationType
	// The route table for the connection manager is static and is specified in this property.
	//
	// .. note::
	//
	//   This field is deprecated. Please use ``drds`` or ``multiple_route_config`` first.
	//
	// Deprecated: Do not use.
	route_config?: [...#RouteConfiguration]
	// Use xDS to fetch the route configuration. It is invalid to define both ``route_config`` and ``drds``.
	drds?:                  #Drds
	multiple_route_config?: #MultipleRouteConfiguration
	// A list of individual Dubbo filters that make up the filter chain for requests made to the
	// Dubbo proxy. Order matters as the filters are processed sequentially. For backwards
	// compatibility, if no dubbo_filters are specified, a default Dubbo router filter
	// (``envoy.filters.dubbo.router``) is used.
	dubbo_filters?: [...#DubboFilter]
}

// DubboFilter configures a Dubbo filter.
#DubboFilter: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.dubbo_proxy.v3.DubboFilter"
	// The name of the filter to instantiate. The name must match a supported
	// filter.
	name?: string
	// Filter specific configuration which depends on the filter being
	// instantiated. See the supported filters for further documentation.
	config?: _
}
