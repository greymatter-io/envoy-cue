package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for the aggregate cluster. See the :ref:`architecture overview
// <arch_overview_aggregate_cluster>` for more information.
// [#extension: envoy.clusters.aggregate]
#ClusterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.aggregate.v3.ClusterConfig"
	// Load balancing clusters in aggregate cluster. Clusters are prioritized based on the order they
	// appear in this list.
	clusters?: [...string]
}

// Configures an aggregate cluster whose
// :ref:`ClusterConfig <envoy_v3_api_msg_extensions.clusters.aggregate.v3.ClusterConfig>`
// is to be fetched from a separate xDS resource.
// [#extension: envoy.clusters.aggregate_resource]
// [#not-implemented-hide:]
#AggregateClusterResource: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.aggregate.v3.AggregateClusterResource"
	// Configuration source specifier for the ClusterConfig resource.
	// Only the aggregated protocol variants are supported; if configured
	// otherwise, the cluster resource will be NACKed.
	config_source?: v3.#ConfigSource
	// The name of the ClusterConfig resource to subscribe to.
	resource_name?: string
}
