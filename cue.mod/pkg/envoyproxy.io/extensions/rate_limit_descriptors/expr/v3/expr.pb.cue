package v3

import (
	v1alpha1 "envoyproxy.io/deps/genproto/googleapis/api/expr/v1alpha1"
)

// The following descriptor entry is appended with a value computed
// from a symbolic Common Expression Language expression.
// See :ref:`attributes <arch_overview_attributes>` for the set of
// available attributes.
//
// .. code-block:: cpp
//
//   ("<descriptor_key>", "<expression_value>")
#Descriptor: {
	"@type": "type.googleapis.com/envoy.extensions.rate_limit_descriptors.expr.v3.Descriptor"
	// The key to use in the descriptor entry.
	descriptor_key?: string
	// If set to true, Envoy skips the descriptor if the expression evaluates to an error.
	// By default, the rate limit is not applied when an expression produces an error.
	skip_if_error?: bool
	// Expression in a text form, e.g. "connection.requested_server_name".
	text?: string
	// Parsed expression in AST form.
	parsed?: v1alpha1.#Expr
}
