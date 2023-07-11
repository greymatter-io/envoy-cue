package v1alpha1

// Values of intermediate expressions produced when evaluating expression.
// Deprecated, use `EvalState` instead.
//
// Deprecated: Do not use.
#Explain: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Explain"
	// All of the observed values.
	//
	// The field value_index is an index in the values list.
	// Separating values from steps is needed to remove redundant values.
	values?: [...#Value]
	// List of steps.
	//
	// Repeated evaluations of the same expression generate new ExprStep
	// instances. The order of such ExprStep instances matches the order of
	// elements returned by Comprehension.iter_range.
	expr_steps?: [...#Explain_ExprStep]
}

// ID and value index of one step.
#Explain_ExprStep: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Explain_ExprStep"
	// ID of corresponding Expr node.
	id?: int64
	// Index of the value in the values list.
	value_index?: int32
}
