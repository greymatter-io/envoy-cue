package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/accesslog/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for the downstream reverse connection socket interface.
// This interface initiates reverse connections to upstream Envoys and provides
// them as socket connections for downstream requests.
// [#next-free-field: 6]
#DownstreamReverseConnectionSocketInterface: {
	"@type": "type.googleapis.com/envoy.extensions.bootstrap.reverse_tunnel.downstream_socket_interface.v3.DownstreamReverseConnectionSocketInterface"
	// Stat prefix to be used for downstream reverse connection socket interface stats.
	stat_prefix?: string
	// Enable detailed per-host and per-cluster statistics.
	// When enabled, emits hidden statistics for individual hosts and clusters.
	// Defaults to “false“.
	enable_detailed_stats?: bool
	// Optional HTTP handshake configuration. When unset, the initiator envoy uses the defaults
	// provided by “HttpHandshakeConfig“.
	http_handshake?: #DownstreamReverseConnectionSocketInterface_HttpHandshakeConfig
	// Access log configuration for reverse tunnel initiator lifecycle events.
	// Logs are emitted on handshake success, handshake failure, and connection close.
	// Reverse tunnel metadata (“node_id“, “cluster_id“, “tenant_id“, upstream cluster, etc.)
	// is available via “%DYNAMIC_METADATA(envoy.reverse_tunnel.initiator:*)%“ substitutions.
	access_log?: [...v3.#AccessLog]
	// Upper bound on the per-host reconnect backoff. The initiator retries a failed handshake on a
	// deterministic exponential schedule (1s, 2s, 4s, ...) with small upward jitter; this value caps
	// that schedule.
	max_reconnect_backoff?: string
}

// HTTP handshake settings for initiator envoy initiated reverse tunnels.
#DownstreamReverseConnectionSocketInterface_HttpHandshakeConfig: {
	"@type": "type.googleapis.com/envoy.extensions.bootstrap.reverse_tunnel.downstream_socket_interface.v3.DownstreamReverseConnectionSocketInterface_HttpHandshakeConfig"
	// Request path used when issuing the HTTP reverse-connection handshake. Defaults to
	// "/reverse_connections/request".
	request_path?: string
	// Additional headers to include in the HTTP handshake request.
	additional_headers?: [...v31.#HeaderValueOption]
	// Perform the handshake as an HTTP/1.1 “Upgrade“ exchange (“Upgrade: reverse-tunnel“,
	// success on “101“) so HTTP proxies can route the handshake and splice the tunnel
	// afterward. The responder must set this flag to the same value.
	// Defaults to “false“.
	use_http_upgrade?: bool
	// Formatter extensions usable in “additional_headers“ substitution. See the formatter
	// extensions documentation for details. When set, “additional_headers“ values are evaluated
	// as substitution format strings; when empty, the values are sent literally.
	// [#extension-category: envoy.formatter]
	formatters?: [...v31.#TypedExtensionConfig]
}
