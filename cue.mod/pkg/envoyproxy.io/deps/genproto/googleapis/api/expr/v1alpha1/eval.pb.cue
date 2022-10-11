package v1alpha1

import (
	status "envoyproxy.io/deps/genproto/googleapis/rpc/status"
)

// The state of an evaluation.
//
// Can represent an inital, partial, or completed state of evaluation.
#EvalState: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.EvalState"
	// The unique values referenced in this message.
	values?: [...#ExprValue]
	// An ordered list of results.
	//
	// Tracks the flow of evaluation through the expression.
	// May be sparse.
	results?: [...#EvalState_Result]
}

// The value of an evaluated expression.
#ExprValue: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.ExprValue"
	// A concrete value.
	value?: #Value
	// The set of errors in the critical path of evalution.
	//
	// Only errors in the critical path are included. For example,
	// `(<error1> || true) && <error2>` will only result in `<error2>`,
	// while `<error1> || <error2>` will result in both `<error1>` and
	// `<error2>`.
	//
	// Errors cause by the presence of other errors are not included in the
	// set. For example `<error1>.foo`, `foo(<error1>)`, and `<error1> + 1` will
	// only result in `<error1>`.
	//
	// Multiple errors *might* be included when evaluation could result
	// in different errors. For example `<error1> + <error2>` and
	// `foo(<error1>, <error2>)` may result in `<error1>`, `<error2>` or both.
	// The exact subset of errors included for this case is unspecified and
	// depends on the implementation details of the evaluator.
	error?: #ErrorSet
	// The set of unknowns in the critical path of evaluation.
	//
	// Unknown behaves identically to Error with regards to propagation.
	// Specifically, only unknowns in the critical path are included, unknowns
	// caused by the presence of other unknowns are not included, and multiple
	// unknowns *might* be included included when evaluation could result in
	// different unknowns. For example:
	//
	//     (<unknown[1]> || true) && <unknown[2]> -> <unknown[2]>
	//     <unknown[1]> || <unknown[2]> -> <unknown[1,2]>
	//     <unknown[1]>.foo -> <unknown[1]>
	//     foo(<unknown[1]>) -> <unknown[1]>
	//     <unknown[1]> + <unknown[2]> -> <unknown[1]> or <unknown[2[>
	//
	// Unknown takes precidence over Error in cases where a `Value` can short
	// circuit the result:
	//
	//     <error> || <unknown> -> <unknown>
	//     <error> && <unknown> -> <unknown>
	//
	// Errors take precidence in all other cases:
	//
	//     <unknown> + <error> -> <error>
	//     foo(<unknown>, <error>) -> <error>
	unknown?: #UnknownSet
}

// A set of errors.
//
// The errors included depend on the context. See `ExprValue.error`.
#ErrorSet: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.ErrorSet"
	// The errors in the set.
	errors?: [...status.#Status]
}

// A set of expressions for which the value is unknown.
//
// The unknowns included depend on the context. See `ExprValue.unknown`.
#UnknownSet: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.UnknownSet"
	// The ids of the expressions with unknown values.
	exprs?: [...int64]
}

// A single evalution result.
#EvalState_Result: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.EvalState_Result"
	// The id of the expression this result if for.
	expr?: int64
	// The index in `values` of the resulting value.
	value?: int64
}
