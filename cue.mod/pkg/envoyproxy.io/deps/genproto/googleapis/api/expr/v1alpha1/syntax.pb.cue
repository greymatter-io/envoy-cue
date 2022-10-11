package v1alpha1

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
	timestamppb "envoyproxy.io/deps/protobuf/types/known/timestamppb"
)

// An expression together with source information as returned by the parser.
#ParsedExpr: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.ParsedExpr"
	// The parsed expression.
	expr?: #Expr
	// The source info derived from input that generated the parsed `expr`.
	source_info?: #SourceInfo
}

// An abstract representation of a common expression.
//
// Expressions are abstractly represented as a collection of identifiers,
// select statements, function calls, literals, and comprehensions. All
// operators with the exception of the '.' operator are modelled as function
// calls. This makes it easy to represent new operators into the existing AST.
//
// All references within expressions must resolve to a [Decl][google.api.expr.v1alpha1.Decl] provided at
// type-check for an expression to be valid. A reference may either be a bare
// identifier `name` or a qualified identifier `google.api.name`. References
// may either refer to a value or a function declaration.
//
// For example, the expression `google.api.name.startsWith('expr')` references
// the declaration `google.api.name` within a [Expr.Select][google.api.expr.v1alpha1.Expr.Select] expression, and
// the function declaration `startsWith`.
#Expr: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Expr"
	// Required. An id assigned to this node by the parser which is unique in a
	// given expression tree. This is used to associate type information and other
	// attributes to a node in the parse tree.
	id?: int64
	// A literal expression.
	const_expr?: #Constant
	// An identifier expression.
	ident_expr?: #Expr_Ident
	// A field selection expression, e.g. `request.auth`.
	select_expr?: #Expr_Select
	// A call expression, including calls to predefined functions and operators.
	call_expr?: #Expr_Call
	// A list creation expression.
	list_expr?: #Expr_CreateList
	// A map or message creation expression.
	struct_expr?: #Expr_CreateStruct
	// A comprehension expression.
	comprehension_expr?: #Expr_Comprehension
}

// Represents a primitive literal.
//
// Named 'Constant' here for backwards compatibility.
//
// This is similar as the primitives supported in the well-known type
// `google.protobuf.Value`, but richer so it can represent CEL's full range of
// primitives.
//
// Lists and structs are not included as constants as these aggregate types may
// contain [Expr][google.api.expr.v1alpha1.Expr] elements which require evaluation and are thus not constant.
//
// Examples of literals include: `"hello"`, `b'bytes'`, `1u`, `4.2`, `-2`,
// `true`, `null`.
#Constant: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Constant"
	// null value.
	null_value?: structpb.#NullValue
	// boolean value.
	bool_value?: bool
	// int64 value.
	int64_value?: int64
	// uint64 value.
	uint64_value?: uint64
	// double value.
	double_value?: float64
	// string value.
	string_value?: string
	// bytes value.
	bytes_value?: bytes
	// protobuf.Duration value.
	//
	// Deprecated: duration is no longer considered a builtin cel type.
	//
	// Deprecated: Do not use.
	duration_value?: durationpb.#Duration
	// protobuf.Timestamp value.
	//
	// Deprecated: timestamp is no longer considered a builtin cel type.
	//
	// Deprecated: Do not use.
	timestamp_value?: timestamppb.#Timestamp
}

// Source information collected at parse time.
#SourceInfo: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.SourceInfo"
	// The syntax version of the source, e.g. `cel1`.
	syntax_version?: string
	// The location name. All position information attached to an expression is
	// relative to this location.
	//
	// The location could be a file, UI element, or similar. For example,
	// `acme/app/AnvilPolicy.cel`.
	location?: string
	// Monotonically increasing list of code point offsets where newlines
	// `\n` appear.
	//
	// The line number of a given position is the index `i` where for a given
	// `id` the `line_offsets[i] < id_positions[id] < line_offsets[i+1]`. The
	// column may be derivd from `id_positions[id] - line_offsets[i]`.
	line_offsets?: [...int32]
	// A map from the parse node id (e.g. `Expr.id`) to the code point offset
	// within the source.
	positions?: [int64]: int32
	// A map from the parse node id where a macro replacement was made to the
	// call `Expr` that resulted in a macro expansion.
	//
	// For example, `has(value.field)` is a function call that is replaced by a
	// `test_only` field selection in the AST. Likewise, the call
	// `list.exists(e, e > 10)` translates to a comprehension expression. The key
	// in the map corresponds to the expression id of the expanded macro, and the
	// value is the call `Expr` that was replaced.
	macro_calls?: [int64]: #Expr
}

// A specific position in source.
#SourcePosition: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.SourcePosition"
	// The soucre location name (e.g. file name).
	location?: string
	// The UTF-8 code unit offset.
	offset?: int32
	// The 1-based index of the starting line in the source text
	// where the issue occurs, or 0 if unknown.
	line?: int32
	// The 0-based index of the starting position within the line of source text
	// where the issue occurs.  Only meaningful if line is nonzero.
	column?: int32
}

// An identifier expression. e.g. `request`.
#Expr_Ident: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Expr_Ident"
	// Required. Holds a single, unqualified identifier, possibly preceded by a
	// '.'.
	//
	// Qualified names are represented by the [Expr.Select][google.api.expr.v1alpha1.Expr.Select] expression.
	name?: string
}

// A field selection expression. e.g. `request.auth`.
#Expr_Select: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Expr_Select"
	// Required. The target of the selection expression.
	//
	// For example, in the select expression `request.auth`, the `request`
	// portion of the expression is the `operand`.
	operand?: #Expr
	// Required. The name of the field to select.
	//
	// For example, in the select expression `request.auth`, the `auth` portion
	// of the expression would be the `field`.
	field?: string
	// Whether the select is to be interpreted as a field presence test.
	//
	// This results from the macro `has(request.auth)`.
	test_only?: bool
}

// A call expression, including calls to predefined functions and operators.
//
// For example, `value == 10`, `size(map_value)`.
#Expr_Call: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Expr_Call"
	// The target of an method call-style expression. For example, `x` in
	// `x.f()`.
	target?: #Expr
	// Required. The name of the function or method being called.
	function?: string
	// The arguments.
	args?: [...#Expr]
}

// A list creation expression.
//
// Lists may either be homogenous, e.g. `[1, 2, 3]`, or heterogeneous, e.g.
// `dyn([1, 'hello', 2.0])`
#Expr_CreateList: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Expr_CreateList"
	// The elements part of the list.
	elements?: [...#Expr]
}

// A map or message creation expression.
//
// Maps are constructed as `{'key_name': 'value'}`. Message construction is
// similar, but prefixed with a type name and composed of field ids:
// `types.MyType{field_id: 'value'}`.
#Expr_CreateStruct: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Expr_CreateStruct"
	// The type name of the message to be created, empty when creating map
	// literals.
	message_name?: string
	// The entries in the creation expression.
	entries?: [...#Expr_CreateStruct_Entry]
}

// A comprehension expression applied to a list or map.
//
// Comprehensions are not part of the core syntax, but enabled with macros.
// A macro matches a specific call signature within a parsed AST and replaces
// the call with an alternate AST block. Macro expansion happens at parse
// time.
//
// The following macros are supported within CEL:
//
// Aggregate type macros may be applied to all elements in a list or all keys
// in a map:
//
// *  `all`, `exists`, `exists_one` -  test a predicate expression against
//    the inputs and return `true` if the predicate is satisfied for all,
//    any, or only one value `list.all(x, x < 10)`.
// *  `filter` - test a predicate expression against the inputs and return
//    the subset of elements which satisfy the predicate:
//    `payments.filter(p, p > 1000)`.
// *  `map` - apply an expression to all elements in the input and return the
//    output aggregate type: `[1, 2, 3].map(i, i * i)`.
//
// The `has(m.x)` macro tests whether the property `x` is present in struct
// `m`. The semantics of this macro depend on the type of `m`. For proto2
// messages `has(m.x)` is defined as 'defined, but not set`. For proto3, the
// macro tests whether the property is set to its default. For map and struct
// types, the macro tests whether the property `x` is defined on `m`.
#Expr_Comprehension: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Expr_Comprehension"
	// The name of the iteration variable.
	iter_var?: string
	// The range over which var iterates.
	iter_range?: #Expr
	// The name of the variable used for accumulation of the result.
	accu_var?: string
	// The initial value of the accumulator.
	accu_init?: #Expr
	// An expression which can contain iter_var and accu_var.
	//
	// Returns false when the result has been computed and may be used as
	// a hint to short-circuit the remainder of the comprehension.
	loop_condition?: #Expr
	// An expression which can contain iter_var and accu_var.
	//
	// Computes the next value of accu_var.
	loop_step?: #Expr
	// An expression which can contain accu_var.
	//
	// Computes the result.
	result?: #Expr
}

// Represents an entry.
#Expr_CreateStruct_Entry: {
	"@type": "type.googleapis.com/google.golang.org.genproto.googleapis.api.expr.v1alpha1.Expr_CreateStruct_Entry"
	// Required. An id assigned to this node by the parser which is unique
	// in a given expression tree. This is used to associate type
	// information and other attributes to the node.
	id?: int64
	// The field key for a message creator statement.
	field_key?: string
	// The key expression for a map creation statement.
	map_key?: #Expr
	// Required. The value assigned to the key.
	value?: #Expr
}
