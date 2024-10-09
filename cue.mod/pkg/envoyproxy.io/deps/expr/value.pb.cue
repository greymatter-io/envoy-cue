package expr

import (
	anypb "envoyproxy.io/deps/protobuf/types/known/anypb"
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
)

#Value: {
	"@type":       "type.googleapis.com/cel.dev.expr.Value"
	null_value?:   structpb.#NullValue
	bool_value?:   bool
	int64_value?:  int64
	uint64_value?: uint64
	double_value?: float64
	string_value?: string
	bytes_value?:  bytes
	enum_value?:   #EnumValue
	object_value?: anypb.#Any
	map_value?:    #MapValue
	list_value?:   #ListValue
	type_value?:   string
}

#EnumValue: {
	"@type": "type.googleapis.com/cel.dev.expr.EnumValue"
	type?:   string
	value?:  int32
}

#ListValue: {
	"@type": "type.googleapis.com/cel.dev.expr.ListValue"
	values?: [...#Value]
}

#MapValue: {
	"@type": "type.googleapis.com/cel.dev.expr.MapValue"
	entries?: [...#MapValue_Entry]
}

#MapValue_Entry: {
	"@type": "type.googleapis.com/cel.dev.expr.MapValue_Entry"
	key?:    #Value
	value?:  #Value
}
