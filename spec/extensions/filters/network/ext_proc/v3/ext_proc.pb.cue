package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Defines how traffic should be handled by the external processor.
#ProcessingMode_DataSendMode: "STREAMED" | "SKIP"

ProcessingMode_DataSendMode_STREAMED: "STREAMED"
ProcessingMode_DataSendMode_SKIP:     "SKIP"

// The Network External Processing filter allows an external service to process raw TCP/UDP traffic
// in a flexible way using a bidirectional gRPC stream. Unlike the HTTP External Processing filter,
// this filter operates at the L4 (transport) layer, giving access to raw network traffic.
//
// The filter communicates with an external gRPC service that can:
//
// 1. Inspect traffic in both directions
// 2. Modify the network traffic
// 3. Control connection lifecycle (continue, close, or reset)
//
// By using the filter's processing mode, you can selectively choose which data
// directions to process (read, write or both), allowing for efficient processing.
// [#next-free-field: 7]
#NetworkExternalProcessor: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.ext_proc.v3.NetworkExternalProcessor"
	// The gRPC service that will process network traffic.
	// This service must implement the NetworkExternalProcessor service
	// defined in the proto file /envoy/service/network_ext_proc/v3/external_processor.proto.
	grpc_service?: v3.#GrpcService
	// By default, if the gRPC stream cannot be established, or if it is closed
	// prematurely with an error, the filter will fail, leading to the close of connection.
	// With this parameter set to true, however, then if the gRPC stream is prematurely closed
	// or could not be opened, processing continues without error.
	failure_mode_allow?: bool
	// Options for controlling processing behavior.
	processing_mode?: #ProcessingMode
	// Specifies the timeout for each individual message sent on the stream and
	// when the filter is running in synchronous mode. Whenever
	// the proxy sends a message on the stream that requires a response, it will
	// reset this timer, and will stop processing and return an error (subject
	// to the processing mode) if the timer expires. Default is 200 ms.
	message_timeout?: string
	stat_prefix?:     string
	// Options related to the sending and receiving of dynamic metadata.
	metadata_options?: #MetadataOptions
}

// Options for controlling processing behavior.
// Filter will reject the config if both read and write are SKIP mode.
#ProcessingMode: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.ext_proc.v3.ProcessingMode"
	// Controls whether inbound (read) data from the client is sent to the external processor.
	// Default: STREAMED
	process_read?: #ProcessingMode_DataSendMode
	// Controls whether outbound (write) data to the client is sent to the external processor.
	// Default: STREAMED
	process_write?: #ProcessingMode_DataSendMode
}

// The MetadataOptions structure defines options for sending dynamic metadata. Specifically,
// which namespaces to send to the server.
#MetadataOptions: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.ext_proc.v3.MetadataOptions"
	// Describes which typed or untyped dynamic metadata namespaces to forward to
	// the external processing server.
	forwarding_namespaces?: #MetadataOptions_MetadataNamespaces
	// Describes which typed or untyped dynamic metadata namespaces to receive
	// from the external processing server.
	// Since the server returns untyped dynamic metadata, this configuration acts
	// as a allowlist. Only metadata namespaces explicitly listed here will be
	// ingested by Envoy from the server's response.
	// Receiving of typed metadata is not supported.
	// Set to empty or leave unset to disallow writing any received dynamic metadata.
	receiving_namespaces?: #MetadataOptions_MetadataNamespaces
}

#MetadataOptions_MetadataNamespaces: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.ext_proc.v3.MetadataOptions_MetadataNamespaces"
	// Specifies a list of metadata namespaces whose values, if present,
	// will be passed to the ext_proc service as an opaque *protobuf::Struct*.
	untyped?: [...string]
	// Specifies a list of metadata namespaces whose values, if present,
	// will be passed to the ext_proc service as a *protobuf::Any*. This allows
	// envoy and the external processing server to share the protobuf message
	// definition for safe parsing.
	typed?: [...string]
}
