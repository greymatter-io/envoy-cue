package v3

// A weighted cluster of a :ref:`priority group
// <envoy_v3_api_msg_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroup>`.
#ClusterWeight: {
	"@type": "type.googleapis.com/envoy.extensions.router.cluster_specifiers.priority_group.v3.ClusterWeight"
	// Name of the upstream cluster.
	cluster_name?: string
	// Weight of the cluster relative to the other clusters of the same group.
	weight?: uint32
}

// A named group of weighted clusters. All the clusters of a group are considered to have the
// same priority and the target cluster is selected from the group based on the weights.
#PriorityGroup: {
	"@type": "type.googleapis.com/envoy.extensions.router.cluster_specifiers.priority_group.v3.PriorityGroup"
	// Name of the group. The name is used to reference the group from the :ref:`override metadata
	// <envoy_v3_api_field_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroupClusterSpecifier.override_metadata_namespace>`
	// and should be unique across all the groups of the same cluster specifier. If multiple groups
	// share the same name, then the first one of them is used when the group is referenced by name.
	name?: string
	// The candidate clusters of this group.
	clusters?: [...#ClusterWeight]
}

// Cluster specifier plugin that selects a :ref:`priority group
// <envoy_v3_api_msg_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroup>` based
// on the attempt of the request first, and then selects a cluster from the selected group based
// on the weights of the clusters.
//
// The group is selected by the attempt count of the request: the initial attempt uses the first
// group of the list, the first retry uses the second group, and so on. If the attempt count
// exceeds the number of the available groups, then the last group of the list is used for all
// the remaining attempts.
//
// This plugin must be used together with the :ref:`refresh cluster on retry
// <envoy_v3_api_field_config.route.v3.RetryPolicy.refresh_cluster_on_retry>` option of the retry
// policy to ensure the reselecting of the cluster on every attempt.
//
// See the :ref:`cluster specifier documentation
// <config_http_cluster_specifier_priority_group>` for more details.
//
// Example:
//
// .. validated-code-block:: yaml
//
//	:type-name: envoy.extensions.router.cluster_specifiers.priority_group.v3.PriorityGroupClusterSpecifier
//
//	priority_groups:
//	- name: local
//	  clusters:
//	  - cluster_name: local_primary
//	    weight: 80
//	  - cluster_name: local_secondary
//	    weight: 20
//	- name: remote
//	  clusters:
//	  - cluster_name: remote_primary
//	    weight: 100
//
// With the configuration above, the initial attempt will be routed to “local_primary“ or
// “local_secondary“ (80/20), and the first retry and every attempt after it will be routed to
// “remote_primary“.
#PriorityGroupClusterSpecifier: {
	"@type": "type.googleapis.com/envoy.extensions.router.cluster_specifiers.priority_group.v3.PriorityGroupClusterSpecifier"
	// The list of the priority groups. The order of the groups is the default selection order that
	// is used when the :ref:`override metadata
	// <envoy_v3_api_field_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroupClusterSpecifier.override_metadata_namespace>`
	// is not configured or not available in the request.
	priority_groups?: [...#PriorityGroup]
	// Optional dynamic metadata namespace that is used to override the priority groups on a
	// per-request basis. If this is configured and the dynamic metadata of the request has a value
	// under this namespace, then the priority groups of that value replace the configured
	// :ref:`priority_groups
	// <envoy_v3_api_field_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroupClusterSpecifier.priority_groups>`
	// for the request.
	//
	// The value of the namespace is read from the :ref:`typed dynamic metadata
	// <envoy_v3_api_field_config.core.v3.Metadata.typed_filter_metadata>` first, where it must be a
	// :ref:`PriorityGroupsOverride
	// <envoy_v3_api_msg_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroupsOverride>`
	// message. If the namespace is not present there, then it is read from the :ref:`untyped
	// dynamic metadata <envoy_v3_api_field_config.core.v3.Metadata.filter_metadata>`, where it must
	// be a struct with the same shape as the ``PriorityGroupsOverride`` message.
	//
	// The group of the current attempt is read from the overriding list in the same way as from the
	// configured list: the initial attempt uses the first group, the first retry uses the second
	// group, and so on, and the last group is used once the attempts go past the end of the list.
	//
	// An overriding group whose :ref:`clusters
	// <envoy_v3_api_field_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroup.clusters>`
	// are set replaces the clusters and the weights of the group for the request. Note these
	// clusters are not validated when the configuration is loaded and the request fails with a
	// ``no cluster`` response if the selected cluster does not exist. An overriding group whose
	// clusters are omitted or empty instead selects the configured priority group with the same
	// :ref:`name
	// <envoy_v3_api_field_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroup.name>`
	// and uses the configured clusters and weights of that group.
	//
	// The dynamic metadata is typically set by a filter that runs before the router filter, for
	// example the :ref:`Lua filter <config_http_filters_lua>` or the :ref:`external processing
	// filter <config_http_filters_ext_proc>`.
	//
	// .. note::
	//   The route, and with it the cluster of the initial attempt, is resolved before the HTTP
	//   filter chain runs, so the filter that sets the metadata must also clear the route cache.
	//
	// Example of a matching untyped dynamic metadata value:
	//
	// .. code-block:: yaml
	//
	//   envoy.my_filter:
	//     priority_groups:
	//     - name: remote
	//       clusters:
	//       - cluster_name: remote_primary
	//         weight: 20
	//       - cluster_name: remote_secondary
	//         weight: 80
	//     - name: local
	//
	// With the metadata value above, the initial attempt uses the group ``remote`` with the clusters
	// and the weights of the metadata, and the first retry uses the configured group ``local`` with
	// its configured clusters and weights.
	//
	// If the metadata namespace is missing, cannot be parsed as a ``PriorityGroupsOverride``
	// message, holds no group at all, or the group of the current attempt is not a valid override,
	// then the configured ``priority_groups`` are used instead.
	override_metadata_namespace?: string
	// Specifies the header name that is used to look up the random value passed in the request header.
	// This is used to ensure consistent cluster picking across multiple proxy levels for weighted traffic.
	// If header is not present or invalid, Envoy will fall back to use the internally generated random value.
	// This header is expected to be single-valued header as we only want to have one selected value throughout
	// the process for the consistency. And the value is a unsigned number between 0 and UINT64_MAX.
	header_name?: string
	// When set to true, the :ref:`hash policies
	// <envoy_v3_api_field_config.route.v3.RouteAction.hash_policy>` of the route will be used to
	// generate the random value for weighted cluster selection.
	// This could ensure consistent cluster picking across multiple proxy levels for weighted traffic.
	// If the route has no hash policy or the hash policies can not generate a hash for the request,
	// Envoy will fall back to use the internally generated random value.
	use_hash_policy?: bool
}

// The value of the :ref:`override metadata
// <envoy_v3_api_field_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroupClusterSpecifier.override_metadata_namespace>`
// that replaces the configured :ref:`priority_groups
// <envoy_v3_api_field_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroupClusterSpecifier.priority_groups>`
// for a single request.
//
// This message is never part of the cluster specifier configuration, so it is not checked by the
// proto validation rules. A value that cannot be used, or a single group of it that cannot be
// used, is ignored and the configured priority groups are used instead.
#PriorityGroupsOverride: {
	"@type": "type.googleapis.com/envoy.extensions.router.cluster_specifiers.priority_group.v3.PriorityGroupsOverride"
	// The ordered list of the overriding priority groups. The initial attempt of the request uses
	// the first group, the first retry uses the second group, and so on. Once the attempts go past
	// the end of the list, the last group is used for all the remaining attempts.
	//
	// Unlike a configured :ref:`priority group
	// <envoy_v3_api_msg_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroup>`, an
	// overriding group may omit its :ref:`clusters
	// <envoy_v3_api_field_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroup.clusters>`
	// to reuse the clusters and the weights of the configured group with the same :ref:`name
	// <envoy_v3_api_field_extensions.router.cluster_specifiers.priority_group.v3.PriorityGroup.name>`.
	// An empty list means that there is no override at all.
	priority_groups?: [...#PriorityGroup]
}
