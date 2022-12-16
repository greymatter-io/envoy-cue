package v3

import (
	v3 "envoyproxy.io/config/common/mutation_rules/v3"
)

// This extension allows for early header mutation by the substitution formatter.
#HeaderMutation: {
	"@type": "type.googleapis.com/envoy.extensions.http.early_header_mutation.header_mutation.v3.HeaderMutation"
	mutations?: [...v3.#HeaderMutation]
}
