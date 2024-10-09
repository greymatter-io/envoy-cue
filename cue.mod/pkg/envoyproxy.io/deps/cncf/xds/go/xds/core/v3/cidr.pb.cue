package v3

import (
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

#CidrRange: {
	"@type":         "type.googleapis.com/github.com.cncf.xds.go.xds.core.v3.CidrRange"
	address_prefix?: string
	prefix_len?:     wrapperspb.#UInt32Value
}
