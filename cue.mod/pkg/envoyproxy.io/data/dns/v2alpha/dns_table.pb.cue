package v2alpha

import (
	matcher "envoyproxy.io/type/matcher"
)

// This message contains the configuration for the DNS Filter if populated
// from the control plane
#DnsTable: {
	"@type": "type.googleapis.com/envoy.data.dns.v2alpha.DnsTable"
	// Control how many times envoy makes an attempt to forward a query to
	// an external server
	external_retry_count?: uint32
	// Fully qualified domain names for which Envoy will respond to queries
	virtual_domains?: [...#DnsTable_DnsVirtualDomain]
	// This field serves to help Envoy determine whether it can authoritatively
	// answer a query for a name matching a suffix in this list. If the query
	// name does not match a suffix in this list, Envoy will forward
	// the query to an upstream DNS server
	known_suffixes?: [...matcher.#StringMatcher]
}

// This message contains a list of IP addresses returned for a query for a known name
#DnsTable_AddressList: {
	"@type": "type.googleapis.com/envoy.data.dns.v2alpha.DnsTable_AddressList"
	// This field contains a well formed IP address that is returned
	// in the answer for a name query. The address field can be an
	// IPv4 or IPv6 address. Address family detection is done automatically
	// when Envoy parses the string. Since this field is repeated,
	// Envoy will return one randomly chosen entry from this list in the
	// DNS response. The random index will vary per query so that we prevent
	// clients pinning on a single address for a configured domain
	address?: [...string]
}

// This message type is extensible and can contain a list of addresses
// or dictate some other method for resolving the addresses for an
// endpoint
#DnsTable_DnsEndpoint: {
	"@type":       "type.googleapis.com/envoy.data.dns.v2alpha.DnsTable_DnsEndpoint"
	address_list?: #DnsTable_AddressList
}

#DnsTable_DnsVirtualDomain: {
	"@type": "type.googleapis.com/envoy.data.dns.v2alpha.DnsTable_DnsVirtualDomain"
	// The domain name for which Envoy will respond to query requests
	name?: string
	// The configuration containing the method to determine the address
	// of this endpoint
	endpoint?: #DnsTable_DnsEndpoint
	// Sets the TTL in dns answers from Envoy returned to the client
	answer_ttl?: string
}
