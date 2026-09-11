package expr

// Deprecated: Marked as deprecated in cel/expr/explain.proto.
#Explain: {
	"@type": "type.googleapis.com/cel.dev.expr.Explain"
	values?: [...#Value]
	expr_steps?: [...#Explain_ExprStep]
}

#Explain_ExprStep: {
	"@type":      "type.googleapis.com/cel.dev.expr.Explain_ExprStep"
	id?:          int64
	value_index?: int32
}
