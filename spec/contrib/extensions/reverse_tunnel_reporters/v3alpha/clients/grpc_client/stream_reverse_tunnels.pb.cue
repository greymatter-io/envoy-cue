package grpc_client

import (
	status "envoyproxy.io/envoy-cue/spec/deps/genproto/googleapis/rpc/status"
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Request message sent by Envoy to report reverse tunnel state changes.
// [#next-free-field: 6]
#StreamReverseTunnelsRequest: {
	"@type": "type.googleapis.com/envoy.extensions.reverse_tunnel_reporters.v3alpha.clients.grpc_client.StreamReverseTunnelsRequest"
	// Node identifier for the reporting Envoy instance.
	// This identifies which Envoy instance is sending the report.
	node?: v3.#Node
	// List of reverse tunnels that were established since the last report.
	// Each tunnel represents a new connection from a downstream Envoy.
	added_tunnels?: [...#ReverseTunnel]
	// List of tunnel names that were disconnected since the last report.
	// Only the tunnel name is needed for removal notifications.
	removed_tunnel_names?: [...string]
	// Indicates whether this report contains all active tunnels (true) or
	// only changes since the last report (false). Usually invoked only on server disconnects.
	full_push?: bool
	// Unique nonce for this request to enable proper ACK/NACK handling.
	// Must be non-negative and should increment for each request.
	// This can also be modified to be used for checksum and tracking in the future.
	nonce?: int64
}

// Response message sent by the management server to control reporting behavior.
#StreamReverseTunnelsResponse: {
	"@type": "type.googleapis.com/envoy.extensions.reverse_tunnel_reporters.v3alpha.clients.grpc_client.StreamReverseTunnelsResponse"
	// Node identifier acknowledging which Envoy instance this response is for.
	// Should match the node from the corresponding request.
	node_id?: string
	// Interval at which Envoy should send tunnel state reports.
	// This is used to change the reporting_interval -> no need to repeat the same value.
	report_interval?: string
	// Nonce from the request being acknowledged or rejected.
	// Must match the nonce from the corresponding request.
	request_nonce?: int64
	// Error details if the previous request failed processing.
	// If populated, indicates the request was rejected (NACK).
	// If empty, indicates successful processing (ACK).
	// NACK will terminate the connection -> useful for logging rather than just some disconnect.
	// So basically -> NACK then terminate.
	error_detail?: status.#Status
}

// Represents a single reverse tunnel connection with its metadata.
#ReverseTunnel: {
	"@type": "type.googleapis.com/envoy.extensions.reverse_tunnel_reporters.v3alpha.clients.grpc_client.ReverseTunnel"
	// Unique name to identify this tunnel connection.
	// Must be unique within the reporting Envoy instance.
	// This is also used for the reporting the disconnection with the associated tunnel initiator.
	name?: string
	// Identity information of the tunnel initiator (downstream Envoy).
	// Contains “node_id“, “cluster_id“, and “tenant_id“ for proper identification.
	identity?: #TunnelInitiatorIdentity
	// Timestamp when this tunnel connection was created.
	// Used for ordering events and debugging connection timing issues.
	created_at?: string
}

#TunnelInitiatorIdentity: {
	"@type": "type.googleapis.com/envoy.extensions.reverse_tunnel_reporters.v3alpha.clients.grpc_client.TunnelInitiatorIdentity"
	// Required: Tenant identifier of the initiating Envoy instance.
	tenant_id?: string
	// Required: Cluster identifier of the initiating Envoy instance.
	cluster_id?: string
	// Required: Node identifier of the initiating Envoy instance.
	node_id?: string
}
