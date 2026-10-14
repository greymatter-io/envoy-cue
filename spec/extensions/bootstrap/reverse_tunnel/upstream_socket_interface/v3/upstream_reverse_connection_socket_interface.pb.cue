package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/accesslog/v3"
)

// Configuration for the upstream reverse connection socket interface.
// [#next-free-field: 8]
#UpstreamReverseConnectionSocketInterface: {
	"@type": "type.googleapis.com/envoy.extensions.bootstrap.reverse_tunnel.upstream_socket_interface.v3.UpstreamReverseConnectionSocketInterface"
	// Stat prefix for upstream reverse connection socket interface stats.
	stat_prefix?: string
	// Number of consecutive ping failures before an idle reverse connection socket is marked dead.
	// Defaults to 3 if unset. Must be at least 1.
	ping_failure_threshold?: uint32
	// Enable detailed per-node and per-cluster statistics.
	// When enabled, emits hidden statistics for individual nodes and clusters.
	// Defaults to false.
	enable_detailed_stats?: bool
	// Optional configuration for a tunnel reporting extension. When provided,
	// the socket interface instantiates a reporter via the configured factory.
	// If unset, no reporting is done.
	reporter_config?: v3.#TypedExtensionConfig
	// Enables tenant-aware isolation for reverse connections. When set to ``true``, the socket
	// interface requires tenant identifiers in addition to node and cluster identifiers and derives
	// composite ``tenant:node`` and ``tenant:cluster`` keys for socket tracking. Identifiers
	// containing the ``:`` delimiter are rejected to avoid ambiguity.
	// Defaults to ``false`` for backwards compatibility.
	enable_tenant_isolation?: bool
	// Access logs emitted for reverse tunnel lifecycle events. Entries are generated for tunnel setup,
	// socket handoff, tunnel close, and post-handoff HTTP/2 keepalive timeout observations.
	access_log?: [...v31.#AccessLog]
	// Maximum number of concurrently accepted reverse connections per node (and per tenant
	// when tenant isolation is enabled). The cap is only consulted for reverse tunnel network
	// filters that opt in via ``enable_connection_limit``; filters that leave it disabled ignore it.
	// The cap is enforced per worker thread, so the effective ceiling is roughly this value
	// multiplied by the number of workers; it is also only approximate when rebalancing is enabled.
	// Defaults to 0; combined with ``enable_connection_limit: true`` a value of 0 rejects all
	// connections, so set a non-zero value whenever a filter enables the limit.
	max_connections_per_node?: uint32
}
