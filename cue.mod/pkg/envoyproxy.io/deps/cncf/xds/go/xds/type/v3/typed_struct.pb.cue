package v3

import (
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
)

#TypedStruct: {
	"@type":   "type.googleapis.com/github.com.cncf.xds.go.xds.type.v3.TypedStruct"
	type_url?: string
	value?:    structpb.#Struct
}
