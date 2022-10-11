package v3

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
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
	layer?: _struct.#Struct
}

// RuntimeDiscoveryServiceClient is the client API for RuntimeDiscoveryService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#RuntimeDiscoveryServiceClient: _

#RuntimeDiscoveryService_StreamRuntimeClient: _

#RuntimeDiscoveryService_DeltaRuntimeClient: _

// RuntimeDiscoveryServiceServer is the server API for RuntimeDiscoveryService service.
#RuntimeDiscoveryServiceServer: _

// UnimplementedRuntimeDiscoveryServiceServer can be embedded to have forward compatible implementations.
#UnimplementedRuntimeDiscoveryServiceServer: {
	"@type": "type.googleapis.com/envoy.service.runtime.v3.UnimplementedRuntimeDiscoveryServiceServer"
}

#RuntimeDiscoveryService_StreamRuntimeServer: _

#RuntimeDiscoveryService_DeltaRuntimeServer: _
