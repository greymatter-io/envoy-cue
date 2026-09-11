package v3

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
}
