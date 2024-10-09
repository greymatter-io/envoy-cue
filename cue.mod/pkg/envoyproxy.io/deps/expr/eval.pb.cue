package expr

import (
	status "envoyproxy.io/deps/genproto/googleapis/rpc/status"
)

#EvalState: {
	"@type": "type.googleapis.com/cel.dev.expr.EvalState"
	values?: [...#ExprValue]
	results?: [...#EvalState_Result]
}

#ExprValue: {
	"@type":  "type.googleapis.com/cel.dev.expr.ExprValue"
	value?:   #Value
	error?:   #ErrorSet
	unknown?: #UnknownSet
}

#ErrorSet: {
	"@type": "type.googleapis.com/cel.dev.expr.ErrorSet"
	errors?: [...status.#Status]
}

#UnknownSet: {
	"@type": "type.googleapis.com/cel.dev.expr.UnknownSet"
	exprs?: [...int64]
}

#EvalState_Result: {
	"@type": "type.googleapis.com/cel.dev.expr.EvalState_Result"
	expr?:   int64
	value?:  int64
}
