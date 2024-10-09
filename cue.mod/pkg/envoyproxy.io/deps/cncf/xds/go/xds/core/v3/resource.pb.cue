package v3

import (
	anypb "envoyproxy.io/deps/protobuf/types/known/anypb"
)

#Resource: {
	"@type":   "type.googleapis.com/github.com.cncf.xds.go.xds.core.v3.Resource"
	name?:     #ResourceName
	version?:  string
	resource?: anypb.#Any
}
