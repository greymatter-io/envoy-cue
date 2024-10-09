package expr

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
	timestamppb "envoyproxy.io/deps/protobuf/types/known/timestamppb"
)

#SourceInfo_Extension_Component: "COMPONENT_UNSPECIFIED" | "COMPONENT_PARSER" | "COMPONENT_TYPE_CHECKER" | "COMPONENT_RUNTIME"

SourceInfo_Extension_Component_COMPONENT_UNSPECIFIED:  "COMPONENT_UNSPECIFIED"
SourceInfo_Extension_Component_COMPONENT_PARSER:       "COMPONENT_PARSER"
SourceInfo_Extension_Component_COMPONENT_TYPE_CHECKER: "COMPONENT_TYPE_CHECKER"
SourceInfo_Extension_Component_COMPONENT_RUNTIME:      "COMPONENT_RUNTIME"

#ParsedExpr: {
	"@type":      "type.googleapis.com/cel.dev.expr.ParsedExpr"
	expr?:        #Expr
	source_info?: #SourceInfo
}

#Expr: {
	"@type":             "type.googleapis.com/cel.dev.expr.Expr"
	id?:                 int64
	const_expr?:         #Constant
	ident_expr?:         #Expr_Ident
	select_expr?:        #Expr_Select
	call_expr?:          #Expr_Call
	list_expr?:          #Expr_CreateList
	struct_expr?:        #Expr_CreateStruct
	comprehension_expr?: #Expr_Comprehension
}

#Constant: {
	"@type":       "type.googleapis.com/cel.dev.expr.Constant"
	null_value?:   structpb.#NullValue
	bool_value?:   bool
	int64_value?:  int64
	uint64_value?: uint64
	double_value?: float64
	string_value?: string
	bytes_value?:  bytes
	// Deprecated: Do not use.
	duration_value?: durationpb.#Duration
	// Deprecated: Do not use.
	timestamp_value?: timestamppb.#Timestamp
}

#SourceInfo: {
	"@type":         "type.googleapis.com/cel.dev.expr.SourceInfo"
	syntax_version?: string
	location?:       string
	line_offsets?: [...int32]
	positions?: [int64]:   int32
	macro_calls?: [int64]: #Expr
	extensions?: [...#SourceInfo_Extension]
}

#Expr_Ident: {
	"@type": "type.googleapis.com/cel.dev.expr.Expr_Ident"
	name?:   string
}

#Expr_Select: {
	"@type":    "type.googleapis.com/cel.dev.expr.Expr_Select"
	operand?:   #Expr
	field?:     string
	test_only?: bool
}

#Expr_Call: {
	"@type":   "type.googleapis.com/cel.dev.expr.Expr_Call"
	target?:   #Expr
	function?: string
	args?: [...#Expr]
}

#Expr_CreateList: {
	"@type": "type.googleapis.com/cel.dev.expr.Expr_CreateList"
	elements?: [...#Expr]
	optional_indices?: [...int32]
}

#Expr_CreateStruct: {
	"@type":       "type.googleapis.com/cel.dev.expr.Expr_CreateStruct"
	message_name?: string
	entries?: [...#Expr_CreateStruct_Entry]
}

#Expr_Comprehension: {
	"@type":         "type.googleapis.com/cel.dev.expr.Expr_Comprehension"
	iter_var?:       string
	iter_range?:     #Expr
	accu_var?:       string
	accu_init?:      #Expr
	loop_condition?: #Expr
	loop_step?:      #Expr
	result?:         #Expr
}

#Expr_CreateStruct_Entry: {
	"@type":         "type.googleapis.com/cel.dev.expr.Expr_CreateStruct_Entry"
	id?:             int64
	field_key?:      string
	map_key?:        #Expr
	value?:          #Expr
	optional_entry?: bool
}

#SourceInfo_Extension: {
	"@type": "type.googleapis.com/cel.dev.expr.SourceInfo_Extension"
	id?:     string
	affected_components?: [...#SourceInfo_Extension_Component]
	version?: #SourceInfo_Extension_Version
}

#SourceInfo_Extension_Version: {
	"@type": "type.googleapis.com/cel.dev.expr.SourceInfo_Extension_Version"
	major?:  int64
	minor?:  int64
}
