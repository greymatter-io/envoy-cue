package v3

import (
	expr "envoyproxy.io/envoy-cue/spec/deps/expr"
	v1alpha1 "envoyproxy.io/envoy-cue/spec/deps/genproto/googleapis/api/expr/v1alpha1"
)

#CelExpression: {
	"@type": "type.googleapis.com/github.com.cncf.xds.go.xds.type.v3.CelExpression"
	// Deprecated: Marked as deprecated in xds/type/v3/cel.proto.
	parsed_expr?: v1alpha1.#ParsedExpr
	// Deprecated: Marked as deprecated in xds/type/v3/cel.proto.
	checked_expr?:     v1alpha1.#CheckedExpr
	cel_expr_parsed?:  expr.#ParsedExpr
	cel_expr_checked?: expr.#CheckedExpr
	cel_expr_string?:  string
}

#CelExtractString: {
	"@type":        "type.googleapis.com/github.com.cncf.xds.go.xds.type.v3.CelExtractString"
	expr_extract?:  #CelExpression
	default_value?: string
}
