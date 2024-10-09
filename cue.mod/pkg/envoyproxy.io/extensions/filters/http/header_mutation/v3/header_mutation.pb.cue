package v3

import (
	v3 "envoyproxy.io/config/common/mutation_rules/v3"
)

#Mutations: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.header_mutation.v3.Mutations"
	// The request mutations are applied before the request is forwarded to the upstream cluster.
	request_mutations?: [...v3.#HeaderMutation]
	// The response mutations are applied before the response is sent to the downstream client.
	response_mutations?: [...v3.#HeaderMutation]
}

// Per route configuration for the header mutation filter.
#HeaderMutationPerRoute: {
	"@type":    "type.googleapis.com/envoy.extensions.filters.http.header_mutation.v3.HeaderMutationPerRoute"
	mutations?: #Mutations
}

// Configuration for the header mutation filter. The mutation rules in the filter configuration will
// always be applied first and then the per-route mutation rules, if both are specified.
#HeaderMutation: {
	"@type":    "type.googleapis.com/envoy.extensions.filters.http.header_mutation.v3.HeaderMutation"
	mutations?: #Mutations
	// If per route HeaderMutationPerRoute config is configured at multiple route levels, header mutations
	// at all specified levels are evaluated. By default, the order is from most specific (i.e. route entry level)
	// to least specific (i.e. route configuration level). Later header mutations may override earlier mutations.
	//
	// This order can be reversed by setting this field to true. In other words, most specific level mutation
	// is evaluated last.
	most_specific_header_mutations_wins?: bool
}
