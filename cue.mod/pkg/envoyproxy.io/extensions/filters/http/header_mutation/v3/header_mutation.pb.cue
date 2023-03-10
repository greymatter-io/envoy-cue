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

// Per route configuration for the header mutation filter. If this is configured at multiple levels
// (route level, virtual host level, and route table level), only the most specific one will be used.
#HeaderMutationPerRoute: {
	"@type":    "type.googleapis.com/envoy.extensions.filters.http.header_mutation.v3.HeaderMutationPerRoute"
	mutations?: #Mutations
}

// Configuration for the header mutation filter. The mutation rules in the filter configuration will
// always be applied first and then the per-route mutation rules, if both are specified.
#HeaderMutation: {
	"@type":    "type.googleapis.com/envoy.extensions.filters.http.header_mutation.v3.HeaderMutation"
	mutations?: #Mutations
}
