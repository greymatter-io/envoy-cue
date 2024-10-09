package v3

import (
	anypb "envoyproxy.io/deps/protobuf/types/known/anypb"
)

#TypedExtensionConfig: {
	"@type":       "type.googleapis.com/github.com.cncf.xds.go.xds.core.v3.TypedExtensionConfig"
	name?:         string
	typed_config?: anypb.#Any
}
