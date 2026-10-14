package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
)

// Configuration for the MCP multi cluster. See the :ref:`architecture overview
// <arch_overview_mcp_multicluster>` for more information. This cluster type allows aggregation of
// multiple clusters into one, providing metadata with the list of aggregated clusters.
// Use the “attemptCount“ property of the request “StreamInfo“ object to select host in a specific subcluster.
// If the “attemptCount“ value is greater than the number of aggregated clusters, the host selection will fail.
//
// The primary purpose of this cluster extension is to provide the list of servers for the MCP router
// configured for tool and resource aggregation. For details of how tools and resource are aggregated see
// :ref:`MCP router documentation<config_http_filters_mcp_router>`.
//
// Example configuration:
//
// .. code-block:: yaml
//
//	name: mcp_multicluster
//	connect_timeout: 0.25s
//	lb_policy: CLUSTER_PROVIDED
//	cluster_type:
//	  name: envoy.clusters.mcp_multicluster
//	  typed_config:
//	    "@type": type.googleapis.com/envoy.extensions.clusters.mcp_multicluster.v3.ClusterConfig
//	    servers:
//	    - name: build_tools
//	      mcp_cluster:
//	        cluster: build_tools
//	    - name: review_tools
//	       mcp_cluster:
//	         cluster: review_tools
//	         host_rewrite_literal: "mcp.review_tools.acme.com"
//
// [#extension: envoy.clusters.mcp_multicluster]
#ClusterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.mcp_multicluster.v3.ClusterConfig"
	// A list of remote MCP servers.
	// Based on the MCP multi cluster configuration the MCP router aggregates capabilities, tools and resources from remote MCP servers
	// and presents itself as single MCP server to the client. All remote MCP servers are sent the same capabilities
	// that the client presented to Envoy. MCP router prefixes tool names and resource path with the server name to resolve
	// naming collisions.
	servers?: [...#ClusterConfig_McpBackend]
}

// Cluster-based backend configuration.
#ClusterConfig_McpCluster: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.mcp_multicluster.v3.ClusterConfig_McpCluster"
	// Cluster name to route requests to.
	cluster?: string
	// Path to use for MCP requests. Defaults to "/mcp".
	path?: string
	// Request timeout.
	// If not set, uses cluster's timeout configuration.
	timeout?: string
	// Indicates that during forwarding, the host header will be swapped with
	// this value.
	host_rewrite_literal?: string
}

// Specifies which downstream request headers are allowed to be forwarded to an MCP
// backend. Modeled after
// :ref:`ext_proc's HeaderForwardingRules <envoy_v3_api_msg_extensions.filters.http.ext_proc.v3.ExternalProcessor>`,
// but MCP-local and secure-by-default: unlike ext_proc, an unset/empty policy
// forwards nothing rather than everything, because MCP requires audience-bound
// tokens and prohibits implicit token passthrough between a client and a backend it
// did not authenticate to.
//
// Evaluation order per header:
//
//  1. If the header matches “disallowed_headers“, it is never forwarded — this
//     takes precedence over everything below, including “forward_all“.
//  2. Otherwise, if “forward_all“ is true, the header is forwarded.
//  3. Otherwise, if the header matches “allowed_headers“, it is forwarded.
//  4. Otherwise, the header is not forwarded.
//
// This does not cover header *mutation* or credential injection, which remain a
// separate concern from this policy.
#ClusterConfig_HeaderForwarding: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.mcp_multicluster.v3.ClusterConfig_HeaderForwarding"
	// If true, forward all downstream request headers to this backend (subject to
	// ``disallowed_headers`` above), matching the legacy forward-everything behavior.
	// Defaults to false. Users relying on the legacy behavior must set this explicitly.
	forward_all?: bool
	// If set, specifically allow any header in this list to be forwarded. Ignored for a
	// header that also matches ``disallowed_headers``, and redundant (but harmless) for
	// any header covered by ``forward_all``.
	allowed_headers?: v3.#ListStringMatcher
	// If set, specifically disallow any header in this list from being forwarded. This
	// takes precedence over both ``forward_all`` and ``allowed_headers``.
	disallowed_headers?: v3.#ListStringMatcher
}

// Specification of the MCP server.
#ClusterConfig_McpBackend: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.mcp_multicluster.v3.ClusterConfig_McpBackend"
	// Unique name for this backend. Used for:
	// - Tool name prefixing (e.g., "time__get_current_time")
	// - Session ID composition
	// - Logging and error messages.
	// Default will be the cluster name if not specified.
	name?: string
	// Backend target specification.
	mcp_cluster?: #ClusterConfig_McpCluster
	// Controls which downstream request headers are forwarded to this backend.
	// If not set, no downstream-controlled headers are forwarded beyond those the
	// router itself must synthesize (e.g. ``content-type``, ``accept``, the session
	// header) — in particular, a client's ``authorization`` header is NOT forwarded
	// by default. Router-owned, framing, session, and hop-by-hop headers are never
	// affected by this policy; they are handled separately and can never be forwarded
	// via this mechanism.
	header_forwarding?: #ClusterConfig_HeaderForwarding
}
