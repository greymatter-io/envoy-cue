package v3

import (
	structpb "envoyproxy.io/envoy-cue/spec/deps/protobuf/types/known/structpb"
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// DataProcessedStatus indicates whether the data was modified by the external processor.
#ProcessingResponse_DataProcessedStatus: "UNKNOWN" | "UNMODIFIED" | "MODIFIED"

ProcessingResponse_DataProcessedStatus_UNKNOWN:    "UNKNOWN"
ProcessingResponse_DataProcessedStatus_UNMODIFIED: "UNMODIFIED"
ProcessingResponse_DataProcessedStatus_MODIFIED:   "MODIFIED"

// ConnectionStatus determines what happens to the connection after processing.
#ProcessingResponse_ConnectionStatus: "CONTINUE" | "CLOSE" | "CLOSE_RST"

ProcessingResponse_ConnectionStatus_CONTINUE:  "CONTINUE"
ProcessingResponse_ConnectionStatus_CLOSE:     "CLOSE"
ProcessingResponse_ConnectionStatus_CLOSE_RST: "CLOSE_RST"

// The payload data from network layer
#Data: {
	"@type": "type.googleapis.com/envoy.service.network_ext_proc.v3.Data"
	// The raw payload data
	data?: bytes
	// Indicates whether this is the last data frame in the current direction.
	// The external processor should still respond to this message even
	// if there is no more data expected in this direction.
	end_of_stream?: bool
}

// ProcessingRequest contains data sent from Envoy to the external processing server.
// Each request contains either read data (from client) or write data (to client)
// along with optional metadata.
#ProcessingRequest: {
	"@type": "type.googleapis.com/envoy.service.network_ext_proc.v3.ProcessingRequest"
	// ReadData contains the network data intercepted in the request path (client to server).
	// This is sent to the external processor when data arrives from the downstream client.
	// If this is set, write_data should not be set.
	read_data?: #Data
	// WriteData contains the network data intercepted in the response path (server to client).
	// This is sent to the external processor when data arrives from the upstream server.
	// If this is set, read_data should not be set.
	write_data?: #Data
	// Optional metadata associated with the request.
	// This can include connection properties, filter configuration, and any other
	// contextual information that might be useful for processing decisions.
	//
	// The metadata is not automatically propagated from request to response.
	// The external processor must include any needed metadata in its response.
	metadata?: v3.#Metadata
}

// ProcessingResponse contains the response from the external processing server to Envoy.
// Each response corresponds to a ProcessingRequest and indicates how the network
// traffic should be handled.
// [#next-free-field: 7]
#ProcessingResponse: {
	"@type": "type.googleapis.com/envoy.service.network_ext_proc.v3.ProcessingResponse"
	// The processed ReadData containing potentially modified data for the request path.
	// This should be sent in response to a ProcessingRequest with read_data, and the
	// previous data in ProcessingRequest will be replaced by the new data in Envoy's data plane.
	// If this is set, write_data should not be set.
	read_data?: #Data
	// The processed WriteData containing potentially modified data for the response path.
	// This should be sent in response to a ProcessingRequest with write_data, and the
	// previous data in ProcessingRequest will be replaced by the new data in Envoy's data plane.
	// If this is set, read_data should not be set.
	write_data?: #Data
	// Indicates whether the data was modified or not.
	// This is mandatory and tells Envoy whether to use the original or modified data.
	data_processing_status?: #ProcessingResponse_DataProcessedStatus
	// Optional: Determines the connection behavior after processing.
	// If not specified, CONTINUE is assumed, and the connection proceeds normally.
	// Use CLOSE or CLOSE_RST to terminate the connection based on processing results.
	connection_status?: #ProcessingResponse_ConnectionStatus
	// Optional metadata associated with the request.
	// This can include connection properties, filter configuration, and any other
	// contextual information that might be useful for processing decisions.
	//
	// The metadata is not automatically propagated from request to response.
	// The external processor must include any needed metadata in its response.
	dynamic_metadata?: structpb.#Struct
	// If set to true, Envoy will close the gRPC stream to the external processor
	// after applying this response. Subsequent data will bypass the ext_proc filter
	// as if it were configured in SKIP mode.
	//
	// .. note::
	//
	//	This should only be used when there is a strong protocol guarantee
	//	that no additional data chunks are in-flight on the wire. Because Envoy
	//	immediately drains its local buffer when forwarding bytes to the external
	//	processor, if Envoy has already dispatched subsequent data chunks before this
	//	stream is closed, those in-flight bytes will be permanently lost and not
	//	injected back into the filter chain.
	//
	// This feature is primarily designed for tightly-coupled synchronous protocols,
	// such as reading the ClientHello during a TLS handshake, where the sender
	// naturally halts transmission while awaiting the receiver's response.
	close_stream_to_ext_proc_server?: bool
}
