package v3

import (
	v3 "envoyproxy.io/type/matcher/v3"
)

// This message contains the configuration for the DNS Filter if populated
// from the control plane
#DnsTable: {
	"@type": "type.googleapis.com/envoy.data.dns.v3.DnsTable"
	// Control how many times Envoy makes an attempt to forward a query to an external DNS server
	external_retry_count?: uint32
	// Fully qualified domain names for which Envoy will respond to DNS queries. By leaving this
	// list empty, Envoy will forward all queries to external resolvers
	virtual_domains?: [...#DnsTable_DnsVirtualDomain]
	// This field is deprecated and no longer used in Envoy. The filter's behavior has changed
	// internally to use a different data structure allowing the filter to determine whether a
	// query is for known domain without the use of this field.
	//
	// This field serves to help Envoy determine whether it can authoritatively answer a query
	// for a name matching a suffix in this list. If the query name does not match a suffix in
	// this list, Envoy will forward the query to an upstream DNS server
	//
	// Deprecated: Do not use.
	known_suffixes?: [...v3.#StringMatcher]
}

// This message contains a list of IP addresses returned for a query for a known name
#DnsTable_AddressList: {
	"@type": "type.googleapis.com/envoy.data.dns.v3.DnsTable_AddressList"
	// This field contains a well formed IP address that is returned in the answer for a
	// name query. The address field can be an IPv4 or IPv6 address. Address family
	// detection is done automatically when Envoy parses the string. Since this field is
	// repeated, Envoy will return as many entries from this list in the DNS response while
	// keeping the response under 512 bytes
	address?: [...string]
}

// Specify the service protocol using a numeric or string value
#DnsTable_DnsServiceProtocol: {
	"@type": "type.googleapis.com/envoy.data.dns.v3.DnsTable_DnsServiceProtocol"
	// Specify the protocol number for the service. Envoy will try to resolve the number to
	// the protocol name. For example, 6 will resolve to "tcp". Refer to:
	// https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml
	// for protocol names and numbers
	number?: uint32
	// Specify the protocol name for the service.
	name?: string
}

// Specify the target for a given DNS service
// [#next-free-field: 6]
#DnsTable_DnsServiceTarget: {
	"@type": "type.googleapis.com/envoy.data.dns.v3.DnsTable_DnsServiceTarget"
	// Use a resolvable hostname as the endpoint for a service.
	host_name?: string
	// Use a cluster name as the endpoint for a service.
	cluster_name?: string
	// The priority of the service record target
	priority?: uint32
	// The weight of the service record target
	weight?: uint32
	// The port to which the service is bound. This value is optional if the target is a
	// cluster. Setting port to zero in this case makes the filter use the port value
	// from the cluster host
	port?: uint32
}

// This message defines a service selection record returned for a service query in a domain
#DnsTable_DnsService: {
	"@type": "type.googleapis.com/envoy.data.dns.v3.DnsTable_DnsService"
	// The name of the service without the protocol or domain name
	service_name?: string
	// The service protocol. This can be specified as a string or the numeric value of the protocol
	protocol?: #DnsTable_DnsServiceProtocol
	// The service entry time to live. This is independent from the DNS Answer record TTL
	ttl?: string
	// The list of targets hosting the service
	targets?: [...#DnsTable_DnsServiceTarget]
}

// Define a list of service records for a given service
#DnsTable_DnsServiceList: {
	"@type": "type.googleapis.com/envoy.data.dns.v3.DnsTable_DnsServiceList"
	services?: [...#DnsTable_DnsService]
}

#DnsTable_DnsEndpoint: {
	"@type": "type.googleapis.com/envoy.data.dns.v3.DnsTable_DnsEndpoint"
	// Define a list of addresses to return for the specified endpoint
	address_list?: #DnsTable_AddressList
	// Define a cluster whose addresses are returned for the specified endpoint
	cluster_name?: string
	// Define a DNS Service List for the specified endpoint
	service_list?: #DnsTable_DnsServiceList
}

#DnsTable_DnsVirtualDomain: {
	"@type": "type.googleapis.com/envoy.data.dns.v3.DnsTable_DnsVirtualDomain"
	// A domain name for which Envoy will respond to query requests
	name?: string
	// The configuration containing the method to determine the address of this endpoint
	endpoint?: #DnsTable_DnsEndpoint
	// Sets the TTL in DNS answers from Envoy returned to the client. The default TTL is 300s
	answer_ttl?: string
}
