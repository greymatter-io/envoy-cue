package v3alpha

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#TraServiceConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.TraServiceConfig"
	// Specifies the gRPC service that hosts the rate limit service. The client
	// will connect to this cluster when it needs to make rate limit service
	// requests.
	grpc_service?: v3.#GrpcService
	// API version for rate limit transport protocol. This describes the rate limit gRPC endpoint and
	// version of messages used on the wire.
	transport_api_version?: v3.#ApiVersion
	timeout?:               string
}

// [#next-free-field: 7]
#TraServiceRequest: {
	"@type":            "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.TraServiceRequest"
	type?:              string
	create_request?:    #CreateRequest
	update_request?:    #UpdateRequest
	retrieve_request?:  #RetrieveRequest
	delete_request?:    #DeleteRequest
	subscribe_request?: #SubscribeRequest
}

// [#next-free-field: 9]
#TraServiceResponse: {
	"@type":             "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.TraServiceResponse"
	type?:               string
	ret?:                int32
	reason?:             string
	create_response?:    #CreateResponse
	update_response?:    #UpdateResponse
	retrieve_response?:  #RetrieveResponse
	delete_response?:    #DeleteResponse
	subscribe_response?: #SubscribeResponse
}

#CreateRequest: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.CreateRequest"
	data?: [string]:    string
	context?: [string]: string
}

#CreateResponse: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.CreateResponse"
}

#UpdateRequest: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.UpdateRequest"
	data?: [string]:    string
	context?: [string]: string
}

#UpdateResponse: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.UpdateResponse"
}

#RetrieveRequest: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.RetrieveRequest"
	key?:    string
	context?: [string]: string
}

#RetrieveResponse: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.RetrieveResponse"
	data?: [string]: string
}

#DeleteRequest: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.DeleteRequest"
	key?:    string
	context?: [string]: string
}

#DeleteResponse: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.DeleteResponse"
}

#SubscribeRequest: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.SubscribeRequest"
}

#SubscribeResponse: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.tra.v3alpha.SubscribeResponse"
	data?: [string]: string
}
