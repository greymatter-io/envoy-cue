package v3alpha

import (
	v3alpha "envoyproxy.io/envoy-cue/spec/contrib/extensions/filters/network/sip_proxy/tra/v3alpha"
)

#SipProxy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.SipProxy"
	// The human readable prefix to use when emitting statistics.
	stat_prefix?: string
	// The route table for the connection manager is static and is specified in this property.
	route_config?: #RouteConfiguration
	// A list of individual Sip filters that make up the filter chain for requests made to the
	// Sip proxy. Order matters as the filters are processed sequentially. For backwards
	// compatibility, if no sip_filters are specified, a default Sip router filter
	// (“envoy.filters.sip.router“) is used.
	// [#extension-category: envoy.sip_proxy.filters]
	sip_filters?: [...#SipFilter]
	settings?: #SipProxy_SipSettings
}

// SipFilter configures a Sip filter.
#SipFilter: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.SipFilter"
	// The name of the filter to instantiate. The name must match a supported
	// filter. The built-in filters are:
	name?:         string
	typed_config?: _
}

// SipProtocolOptions specifies Sip upstream protocol options. This object is used in
// :ref:`typed_extension_protocol_options<envoy_v3_api_field_config.cluster.v3.Cluster.typed_extension_protocol_options>`,
// keyed by the name “envoy.filters.network.sip_proxy“.
#SipProtocolOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.SipProtocolOptions"
	// All sip messages in one dialog should go to the same endpoint.
	session_affinity?: bool
	// The Register with Authorization header should go to the same endpoint which send out the 401 Unauthorized.
	registration_affinity?: bool
	// Customized affinity
	customized_affinity?: #CustomizedAffinity
}

// For affinity
#CustomizedAffinity: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.CustomizedAffinity"
	// Affinity rules to conclude the upstream endpoint
	entries?: [...#CustomizedAffinityEntry]
	// Configures whether load balance should be stopped or continued after affinity handling.
	stop_load_balance?: bool
}

// [#next-free-field: 6]
#CustomizedAffinityEntry: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.CustomizedAffinityEntry"
	// The header name to match, e.g. "From", if not specified, default is "Route"
	header?: string
	// Affinity key for TRA query/subscribe, e.g. "lskpmc", if key_name is "text" means use the header content as key.
	key_name?: string
	// Whether subscribe to TRA is required
	subscribe?: bool
	// Whether query to TRA is required
	query?: bool
	// Local cache
	cache?: #Cache
}

#Cache: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.Cache"
	// Affinity local cache item max number
	max_cache_item?: int32
	// Whether query result can be added to local cache
	add_query_to_cache?: bool
}

// Local Service
#LocalService: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.LocalService"
	// The domain need to matched
	domain?: string
	// The parameter to get domain
	parameter?: string
}

#SipProxy_SipSettings: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.SipProxy_SipSettings"
	// transaction timeout timer [Timer B] unit is milliseconds, default value 64*T1.
	//
	// # Session Initiation Protocol (SIP) timer summary
	//
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer   | Default value           | Section  | Meaning                                                                      |
	// +=========+=========================+==========+==============================================================================+
	// | T1      | 500 ms                  | 17.1.1.1 | Round-trip time (RTT) estimate                                               |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | T2      | 4 sec                   | 17.1.2.2 | Maximum re-transmission interval for non-INVITE requests and INVITE responses|
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | T4      | 5 sec                   | 17.1.2.2 | Maximum duration that a message can remain in the network                    |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer A | initially T1            | 17.1.1.2 | INVITE request re-transmission interval, for UDP only                        |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer B | 64*T1                   | 17.1.1.2 | INVITE transaction timeout timer                                             |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer D | > 32 sec. for UDP       | 17.1.1.2 | Wait time for response re-transmissions                                      |
	// |         | 0 sec. for TCP and SCTP |          |                                                                              |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer E | initially T1            | 17.1.2.2 | Non-INVITE request re-transmission interval, UDP only                        |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer F | 64*T1                   | 17.1.2.2 | Non-INVITE transaction timeout timer                                         |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer G | initially T1            | 17.2.1   | INVITE response re-transmission interval                                     |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer H | 64*T1                   | 17.2.1   | Wait time for ACK receipt                                                    |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer I | T4 for UDP              | 17.2.1   | Wait time for ACK re-transmissions                                           |
	// |         | 0 sec. for TCP and SCTP |          |                                                                              |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer J | 64*T1 for UDP           | 17.2.2   | Wait time for re-transmissions of non-INVITE requests                        |
	// |         | 0 sec. for TCP and SCTP |          |                                                                              |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	// | Timer K | T4 for UDP              | 17.1.2.2 | Wait time for response re-transmissions                                      |
	// |         | 0 sec. for TCP and SCTP |          |                                                                              |
	// +---------+-------------------------+----------+------------------------------------------------------------------------------+
	transaction_timeout?: string
	// The service to match for ep insert
	local_services?: [...#LocalService]
	tra_service_config?: v3alpha.#TraServiceConfig
	// Whether via header is operated, including add via for request and pop via for response
	// False: sip service proxy
	// True:  sip load balancer
	operate_via?: bool
}
