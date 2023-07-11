package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/filters/network/thrift_proxy/v3"
)

#Thrift: {
	"@type": "type.googleapis.com/envoy.extensions.health_checkers.thrift.v3.Thrift"
	// Specifies the method name that will be set on each health check request dispatched to an upstream host.
	// Note that method name is case sensitive.
	method_name?: string
	// Configures the transport type to be used with the health checks. Note that
	// :ref:`AUTO_TRANSPORT<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.TransportType.AUTO_TRANSPORT>`
	// is not supported, and we don't honor :ref:`ThriftProtocolOptions<envoy_v3_api_msg_extensions.filters.network.thrift_proxy.v3.ThriftProtocolOptions>`
	// since it's possible to set to :ref:`AUTO_TRANSPORT<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.TransportType.AUTO_TRANSPORT>`.
	// [#extension-category: envoy.filters.network]
	transport?: v3.#TransportType
	// Configures the protocol type to be used with the health checks. Note that
	// :ref:`AUTO_PROTOCOL<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.ProtocolType.AUTO_PROTOCOL>`
	// and :ref:`TWITTER<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.ProtocolType.TWITTER>`
	// are not supported, and we don't honor :ref:`ThriftProtocolOptions<envoy_v3_api_msg_extensions.filters.network.thrift_proxy.v3.ThriftProtocolOptions>`
	// since it's possible to set to :ref:`AUTO_PROTOCOL<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.ProtocolType.AUTO_PROTOCOL>`
	// or :ref:`TWITTER<envoy_v3_api_enum_value_extensions.filters.network.thrift_proxy.v3.ProtocolType.TWITTER>`.
	protocol?: v3.#ProtocolType
}
