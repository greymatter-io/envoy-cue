package v3

// A list of gRPC methods which can be used as an allowlist, for example.
#GrpcMethodList: {
	"@type": "type.googleapis.com/envoy.config.core.v3.GrpcMethodList"
	services?: [...#GrpcMethodList_Service]
}

#GrpcMethodList_Service: {
	"@type": "type.googleapis.com/envoy.config.core.v3.GrpcMethodList_Service"
	// The name of the gRPC service.
	name?: string
	// The names of the gRPC methods in this service.
	method_names?: [...string]
}
