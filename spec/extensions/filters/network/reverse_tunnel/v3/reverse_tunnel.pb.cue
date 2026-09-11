package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Validation configuration for reverse tunnel identifiers.
// Validates the node ID, cluster ID, and tenant ID extracted from reverse tunnel handshake headers
// against expected values specified using format strings.
// [#next-free-field: 6]
#Validation: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.reverse_tunnel.v3.Validation"
	// Format string to extract the expected node identifier for validation.
	// The formatted value is compared against the “x-envoy-reverse-tunnel-node-id“ header
	// from the incoming handshake request. If they do not match, the connection is rejected
	// with HTTP “403 Forbidden“.
	//
	// Supports Envoy's :ref:`command operators <config_access_log_command_operators>`:
	//
	// * “%DYNAMIC_METADATA(namespace:key)%“: Extract expected value from dynamic metadata.
	// * “%FILTER_STATE(key)%“: Extract expected value from filter state.
	// * “%DOWNSTREAM_REMOTE_ADDRESS%“: Use downstream connection IP address.
	// * Plain strings: Use a static expected value.
	//
	// If empty, node ID validation is skipped.
	//
	// Example using dynamic metadata allowlist:
	//
	// .. code-block:: yaml
	//
	//	node_id_format: "%DYNAMIC_METADATA(envoy.reverse_tunnel.allowlist:expected_node_id)%"
	node_id_format?: string
	// Format string to extract the expected cluster identifier for validation.
	// The formatted value is compared against the “x-envoy-reverse-tunnel-cluster-id“ header
	// from the incoming handshake request. If they do not match, the connection is rejected
	// with HTTP “403 Forbidden“.
	//
	// Supports the same :ref:`command operators <config_access_log_command_operators>` as
	// “node_id_format“.
	//
	// If empty, cluster ID validation is skipped.
	//
	// Example using filter state:
	//
	// .. code-block:: yaml
	//
	//	cluster_id_format: "%FILTER_STATE(expected_cluster_id)%"
	cluster_id_format?: string
	// Format string to extract the expected tenant identifier for validation.
	// The formatted value is compared against the “x-envoy-reverse-tunnel-tenant-id“ header
	// from the incoming handshake request. If they do not match, the connection is rejected
	// with HTTP “403 Forbidden“.
	//
	// Supports the same :ref:`command operators <config_access_log_command_operators>` as
	// “node_id_format“.
	//
	// If empty, tenant ID validation is skipped.
	tenant_id_format?: string
	// Whether to emit validation results as dynamic metadata.
	// When enabled, the filter emits metadata under the namespace specified by
	// “dynamic_metadata_namespace“ containing:
	//
	// * “node_id“: The actual node ID from the handshake request.
	// * “cluster_id“: The actual cluster ID from the handshake request.
	// * “tenant_id“: The actual tenant ID from the handshake request.
	// * “validation_result“: Either “allowed“ or “denied“.
	//
	// This metadata can be used by subsequent filters or for access logging.
	// Defaults to “false“.
	emit_dynamic_metadata?: bool
	// Namespace for emitted dynamic metadata when “emit_dynamic_metadata“ is “true“.
	// If not specified, defaults to “envoy.filters.network.reverse_tunnel“.
	dynamic_metadata_namespace?: string
}

// Configuration for the reverse tunnel network filter.
// This filter handles reverse tunnel connection acceptance and rejection by processing
// HTTP requests where required identification values are provided via HTTP headers.
// [#next-free-field: 9]
#ReverseTunnel: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.reverse_tunnel.v3.ReverseTunnel"
	// Ping interval for health checks on established reverse tunnel connections.
	// If not specified, defaults to “2 seconds“.
	ping_interval?: string
	// Whether to automatically close connections after processing reverse tunnel requests.
	//
	// * When set to “true“, connections are closed after acceptance or rejection.
	// * When set to “false“, connections remain open for potential reuse.
	//
	// Defaults to “false“.
	auto_close_connections?: bool
	// HTTP path to match for reverse tunnel requests.
	// If not specified, defaults to “/reverse_connections/request“.
	request_path?: string
	// HTTP method to match for reverse tunnel requests.
	// If not specified (“METHOD_UNSPECIFIED“), this defaults to “GET“.
	request_method?: v3.#RequestMethod
	// Optional validation configuration for node, cluster, and tenant identifiers.
	// If specified, the filter validates the “x-envoy-reverse-tunnel-node-id“,
	// “x-envoy-reverse-tunnel-cluster-id“, and “x-envoy-reverse-tunnel-tenant-id“ headers
	// against expected values extracted using format strings. Requests that fail validation
	// are rejected with HTTP “403 Forbidden“.
	validation?: #Validation
	// Required cluster name for validating reverse tunnel connection initiations.
	// When set, the filter validates that the upstream cluster of the initiator envoy matches this name
	// via “x-envoy-reverse-tunnel-upstream-cluster-name“ header. Connections with mismatched or missing
	// cluster names are rejected with HTTP “400 Bad Request“. When empty, no cluster name validation is performed.
	required_cluster_name?: string
	// Accept the handshake as an HTTP/1.1 “Upgrade“ exchange (“Upgrade: reverse-tunnel“,
	// reply “101“) so HTTP proxies can route the handshake and splice the tunnel
	// afterward. Non-upgrade requests are rejected with “426“. The initiator must set this
	// flag to the same value.
	// Defaults to “false“.
	use_http_upgrade?: bool
	// When true, skip worker-thread rebalancing for accepted reverse tunnel connections.
	// This avoids the cross-worker lock in pickLeastLoadedSocketManager.
	// Default: false (rebalancing enabled).
	skip_rebalancing?: bool
}
