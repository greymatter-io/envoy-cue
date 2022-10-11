package v2alpha

import (
	_type "envoyproxy.io/type"
	core "envoyproxy.io/api/v2/core"
)

// Admin endpoint uses this wrapper for `/clusters` to display cluster status information.
// See :ref:`/clusters <operations_admin_interface_clusters>` for more information.
#Clusters: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.Clusters"
	// Mapping from cluster name to each cluster's status.
	cluster_statuses?: [...#ClusterStatus]
}

// Details an individual cluster's current status.
// [#next-free-field: 6]
#ClusterStatus: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ClusterStatus"
	// Name of the cluster.
	name?: string
	// Denotes whether this cluster was added via API or configured statically.
	added_via_api?: bool
	// The success rate threshold used in the last interval.
	// If
	// :ref:`outlier_detection.split_external_local_origin_errors<envoy_api_field_cluster.OutlierDetection.split_external_local_origin_errors>`
	// is *false*, all errors: externally and locally generated were used to calculate the threshold.
	// If
	// :ref:`outlier_detection.split_external_local_origin_errors<envoy_api_field_cluster.OutlierDetection.split_external_local_origin_errors>`
	// is *true*, only externally generated errors were used to calculate the threshold.
	// The threshold is used to eject hosts based on their success rate. See
	// :ref:`Cluster outlier detection <arch_overview_outlier_detection>` documentation for details.
	//
	// Note: this field may be omitted in any of the three following cases:
	//
	// 1. There were not enough hosts with enough request volume to proceed with success rate based
	//    outlier ejection.
	// 2. The threshold is computed to be < 0 because a negative value implies that there was no
	//    threshold for that interval.
	// 3. Outlier detection is not enabled for this cluster.
	success_rate_ejection_threshold?: _type.#Percent
	// Mapping from host address to the host's current status.
	host_statuses?: [...#HostStatus]
	// The success rate threshold used in the last interval when only locally originated failures were
	// taken into account and externally originated errors were treated as success.
	// This field should be interpreted only when
	// :ref:`outlier_detection.split_external_local_origin_errors<envoy_api_field_cluster.OutlierDetection.split_external_local_origin_errors>`
	// is *true*. The threshold is used to eject hosts based on their success rate.
	// See :ref:`Cluster outlier detection <arch_overview_outlier_detection>` documentation for
	// details.
	//
	// Note: this field may be omitted in any of the three following cases:
	//
	// 1. There were not enough hosts with enough request volume to proceed with success rate based
	//    outlier ejection.
	// 2. The threshold is computed to be < 0 because a negative value implies that there was no
	//    threshold for that interval.
	// 3. Outlier detection is not enabled for this cluster.
	local_origin_success_rate_ejection_threshold?: _type.#Percent
}

// Current state of a particular host.
// [#next-free-field: 10]
#HostStatus: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.HostStatus"
	// Address of this host.
	address?: core.#Address
	// List of stats specific to this host.
	stats?: [...#SimpleMetric]
	// The host's current health status.
	health_status?: #HostHealthStatus
	// Request success rate for this host over the last calculated interval.
	// If
	// :ref:`outlier_detection.split_external_local_origin_errors<envoy_api_field_cluster.OutlierDetection.split_external_local_origin_errors>`
	// is *false*, all errors: externally and locally generated were used in success rate
	// calculation. If
	// :ref:`outlier_detection.split_external_local_origin_errors<envoy_api_field_cluster.OutlierDetection.split_external_local_origin_errors>`
	// is *true*, only externally generated errors were used in success rate calculation.
	// See :ref:`Cluster outlier detection <arch_overview_outlier_detection>` documentation for
	// details.
	//
	// Note: the message will not be present if host did not have enough request volume to calculate
	// success rate or the cluster did not have enough hosts to run through success rate outlier
	// ejection.
	success_rate?: _type.#Percent
	// The host's weight. If not configured, the value defaults to 1.
	weight?: uint32
	// The hostname of the host, if applicable.
	hostname?: string
	// The host's priority. If not configured, the value defaults to 0 (highest priority).
	priority?: uint32
	// Request success rate for this host over the last calculated
	// interval when only locally originated errors are taken into account and externally originated
	// errors were treated as success.
	// This field should be interpreted only when
	// :ref:`outlier_detection.split_external_local_origin_errors<envoy_api_field_cluster.OutlierDetection.split_external_local_origin_errors>`
	// is *true*.
	// See :ref:`Cluster outlier detection <arch_overview_outlier_detection>` documentation for
	// details.
	//
	// Note: the message will not be present if host did not have enough request volume to calculate
	// success rate or the cluster did not have enough hosts to run through success rate outlier
	// ejection.
	local_origin_success_rate?: _type.#Percent
	// locality of the host.
	locality?: core.#Locality
}

// Health status for a host.
// [#next-free-field: 7]
#HostHealthStatus: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.HostHealthStatus"
	// The host is currently failing active health checks.
	failed_active_health_check?: bool
	// The host is currently considered an outlier and has been ejected.
	failed_outlier_check?: bool
	// The host is currently being marked as degraded through active health checking.
	failed_active_degraded_check?: bool
	// The host has been removed from service discovery, but is being stabilized due to active
	// health checking.
	pending_dynamic_removal?: bool
	// The host has not yet been health checked.
	pending_active_hc?: bool
	// Health status as reported by EDS. Note: only HEALTHY and UNHEALTHY are currently supported
	// here.
	// [#comment:TODO(mrice32): pipe through remaining EDS health status possibilities.]
	eds_health_status?: core.#HealthStatus
}
