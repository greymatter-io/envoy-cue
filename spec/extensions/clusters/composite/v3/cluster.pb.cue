package v3

// Configuration for the composite cluster. See the :ref:`architecture overview
// <arch_overview_composite_cluster>` for more information. This cluster type enables retry-aware
// cluster selection, allowing different retry attempts to automatically target
// different upstream clusters. Unlike the standard aggregate cluster which uses
// health-based selection, the composite cluster uses the retry attempt count to
// deterministically select which sub-cluster to route to.
//
// When retry attempts exceed the number of configured clusters, requests will fail with no
// host available.
//
// Example configuration:
//
// .. code-block:: yaml
//
//	name: composite_cluster
//	connect_timeout: 0.25s
//	lb_policy: CLUSTER_PROVIDED
//	cluster_type:
//	  name: envoy.clusters.composite
//	  typed_config:
//	    "@type": type.googleapis.com/envoy.extensions.clusters.composite.v3.ClusterConfig
//	    clusters:
//	    - name: primary_cluster
//	    - name: secondary_cluster
//	    - name: fallback_cluster
//
// [#extension: envoy.clusters.composite]
#ClusterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.composite.v3.ClusterConfig"
	// List of clusters to use for request routing. The first cluster is used for the
	// initial request (attempt 1), the second cluster for the first retry (attempt 2),
	// and so on. Must contain at least one cluster. When retry attempts exceed the number
	// of configured clusters, requests will fail with no host available.
	clusters?: [...#ClusterConfig_ClusterEntry]
}

// Configuration for an individual cluster entry.
#ClusterConfig_ClusterEntry: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.composite.v3.ClusterConfig_ClusterEntry"
	// Name of the cluster. This cluster must be defined elsewhere in the configuration.
	name?: string
}
