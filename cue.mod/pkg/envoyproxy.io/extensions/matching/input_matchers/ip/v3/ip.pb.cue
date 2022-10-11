package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

// This input matcher matches IPv4 or IPv6 addresses against a list of CIDR
// ranges. It returns true if and only if the input IP belongs to at least one
// of these CIDR ranges. Internally, it uses a Level-Compressed trie, as
// described in the paper `IP-address lookup using LC-tries
// <https://www.nada.kth.se/~snilsson/publications/IP-address-lookup-using-LC-tries/>`_
// by S. Nilsson and G. Karlsson. For "big" lists of IPs, this matcher is more
// efficient than multiple single IP matcher, that would have a linear cost.
#Ip: {
	"@type": "type.googleapis.com/envoy.extensions.matching.input_matchers.ip.v3.Ip"
	// Match if the IP belongs to any of these CIDR ranges.
	cidr_ranges?: [...v3.#CidrRange]
	// The human readable prefix to use when emitting statistics for the IP input
	// matcher. Names in the table below are concatenated to this prefix.
	//
	// .. csv-table::
	//    :header: Name, Type, Description
	//    :widths: 1, 1, 2
	//
	//    ip_parsing_failed, Counter, Total number of IP addresses the matcher was unable to parse
	stat_prefix?: string
}
