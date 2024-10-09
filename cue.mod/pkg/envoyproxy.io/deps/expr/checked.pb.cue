package expr

import (
	emptypb "envoyproxy.io/deps/protobuf/types/known/emptypb"
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
)

#Type_PrimitiveType: "PRIMITIVE_TYPE_UNSPECIFIED" | "BOOL" | "INT64" | "UINT64" | "DOUBLE" | "STRING" | "BYTES"

Type_PrimitiveType_PRIMITIVE_TYPE_UNSPECIFIED: "PRIMITIVE_TYPE_UNSPECIFIED"
Type_PrimitiveType_BOOL:                       "BOOL"
Type_PrimitiveType_INT64:                      "INT64"
Type_PrimitiveType_UINT64:                     "UINT64"
Type_PrimitiveType_DOUBLE:                     "DOUBLE"
Type_PrimitiveType_STRING:                     "STRING"
Type_PrimitiveType_BYTES:                      "BYTES"

#Type_WellKnownType: "WELL_KNOWN_TYPE_UNSPECIFIED" | "ANY" | "TIMESTAMP" | "DURATION"

Type_WellKnownType_WELL_KNOWN_TYPE_UNSPECIFIED: "WELL_KNOWN_TYPE_UNSPECIFIED"
Type_WellKnownType_ANY:                         "ANY"
Type_WellKnownType_TIMESTAMP:                   "TIMESTAMP"
Type_WellKnownType_DURATION:                    "DURATION"

#CheckedExpr: {
	"@type": "type.googleapis.com/cel.dev.expr.CheckedExpr"
	reference_map?: [int64]: #Reference
	type_map?: [int64]:      #Type
	source_info?:  #SourceInfo
	expr_version?: string
	expr?:         #Expr
}

#Type: {
	"@type":        "type.googleapis.com/cel.dev.expr.Type"
	dyn?:           emptypb.#Empty
	null?:          structpb.#NullValue
	primitive?:     #Type_PrimitiveType
	wrapper?:       #Type_PrimitiveType
	well_known?:    #Type_WellKnownType
	list_type?:     #Type_ListType
	map_type?:      #Type_MapType
	function?:      #Type_FunctionType
	message_type?:  string
	type_param?:    string
	type?:          #Type
	error?:         emptypb.#Empty
	abstract_type?: #Type_AbstractType
}

#Decl: {
	"@type":   "type.googleapis.com/cel.dev.expr.Decl"
	name?:     string
	ident?:    #Decl_IdentDecl
	function?: #Decl_FunctionDecl
}

#Reference: {
	"@type": "type.googleapis.com/cel.dev.expr.Reference"
	name?:   string
	overload_id?: [...string]
	value?: #Constant
}

#Type_ListType: {
	"@type":    "type.googleapis.com/cel.dev.expr.Type_ListType"
	elem_type?: #Type
}

#Type_MapType: {
	"@type":     "type.googleapis.com/cel.dev.expr.Type_MapType"
	key_type?:   #Type
	value_type?: #Type
}

#Type_FunctionType: {
	"@type":      "type.googleapis.com/cel.dev.expr.Type_FunctionType"
	result_type?: #Type
	arg_types?: [...#Type]
}

#Type_AbstractType: {
	"@type": "type.googleapis.com/cel.dev.expr.Type_AbstractType"
	name?:   string
	parameter_types?: [...#Type]
}

#Decl_IdentDecl: {
	"@type": "type.googleapis.com/cel.dev.expr.Decl_IdentDecl"
	type?:   #Type
	value?:  #Constant
	doc?:    string
}

#Decl_FunctionDecl: {
	"@type": "type.googleapis.com/cel.dev.expr.Decl_FunctionDecl"
	overloads?: [...#Decl_FunctionDecl_Overload]
}

#Decl_FunctionDecl_Overload: {
	"@type":      "type.googleapis.com/cel.dev.expr.Decl_FunctionDecl_Overload"
	overload_id?: string
	params?: [...#Type]
	type_params?: [...string]
	result_type?:          #Type
	is_instance_function?: bool
	doc?:                  string
}
