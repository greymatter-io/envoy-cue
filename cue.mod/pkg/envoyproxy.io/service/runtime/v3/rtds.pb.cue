package v3

import (
	structpb "envoyproxy.io/deps/protobuf/types/known/structpb"
)

// [#not-implemented-hide:] Not configuration. Workaround c++ protobuf issue with importing
// services: https://github.com/google/protobuf/issues/4221
#RtdsDummy: {
	"@type": "type.googleapis.com/envoy.service.runtime.v3.RtdsDummy"
}

// RTDS resource type. This describes a layer in the runtime virtual filesystem.
#Runtime: {
	"@type": "type.googleapis.com/envoy.service.runtime.v3.Runtime"
	// Runtime resource name. This makes the Runtime a self-describing xDS
	// resource.
	name?:  string
	layer?: structpb.#Struct
}
