package v2alpha

import (
	v2 "envoyproxy.io/config/bootstrap/v2"
)

// The :ref:`/config_dump <operations_admin_interface_config_dump>` admin endpoint uses this wrapper
// message to maintain and serve arbitrary configuration information from any component in Envoy.
#ConfigDump: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ConfigDump"
	// This list is serialized and dumped in its entirety at the
	// :ref:`/config_dump <operations_admin_interface_config_dump>` endpoint.
	//
	// The following configurations are currently supported and will be dumped in the order given
	// below:
	//
	// * *bootstrap*: :ref:`BootstrapConfigDump <envoy_api_msg_admin.v2alpha.BootstrapConfigDump>`
	// * *clusters*: :ref:`ClustersConfigDump <envoy_api_msg_admin.v2alpha.ClustersConfigDump>`
	// * *listeners*: :ref:`ListenersConfigDump <envoy_api_msg_admin.v2alpha.ListenersConfigDump>`
	// * *routes*:  :ref:`RoutesConfigDump <envoy_api_msg_admin.v2alpha.RoutesConfigDump>`
	//
	// You can filter output with the resource and mask query parameters.
	// See :ref:`/config_dump?resource={} <operations_admin_interface_config_dump_by_resource>`,
	// :ref:`/config_dump?mask={} <operations_admin_interface_config_dump_by_mask>`,
	// or :ref:`/config_dump?resource={},mask={}
	// <operations_admin_interface_config_dump_by_resource_and_mask>` for more information.
	configs?: _
}

#UpdateFailureState: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.UpdateFailureState"
	// What the component configuration would have been if the update had succeeded.
	failed_configuration?: _
	// Time of the latest failed update attempt.
	last_update_attempt?: string
	// Details about the last failed update attempt.
	details?: string
}

// This message describes the bootstrap configuration that Envoy was started with. This includes
// any CLI overrides that were merged. Bootstrap configuration information can be used to recreate
// the static portions of an Envoy configuration by reusing the output as the bootstrap
// configuration for another Envoy.
#BootstrapConfigDump: {
	"@type":    "type.googleapis.com/envoy.admin.v2alpha.BootstrapConfigDump"
	bootstrap?: v2.#Bootstrap
	// The timestamp when the BootstrapConfig was last updated.
	last_updated?: string
}

// Envoy's listener manager fills this message with all currently known listeners. Listener
// configuration information can be used to recreate an Envoy configuration by populating all
// listeners as static listeners or by returning them in a LDS response.
#ListenersConfigDump: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ListenersConfigDump"
	// This is the :ref:`version_info <envoy_api_field_DiscoveryResponse.version_info>` in the
	// last processed LDS discovery response. If there are only static bootstrap listeners, this field
	// will be "".
	version_info?: string
	// The statically loaded listener configs.
	static_listeners?: [...#ListenersConfigDump_StaticListener]
	// State for any warming, active, or draining listeners.
	dynamic_listeners?: [...#ListenersConfigDump_DynamicListener]
}

// Envoy's cluster manager fills this message with all currently known clusters. Cluster
// configuration information can be used to recreate an Envoy configuration by populating all
// clusters as static clusters or by returning them in a CDS response.
#ClustersConfigDump: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ClustersConfigDump"
	// This is the :ref:`version_info <envoy_api_field_DiscoveryResponse.version_info>` in the
	// last processed CDS discovery response. If there are only static bootstrap clusters, this field
	// will be "".
	version_info?: string
	// The statically loaded cluster configs.
	static_clusters?: [...#ClustersConfigDump_StaticCluster]
	// The dynamically loaded active clusters. These are clusters that are available to service
	// data plane traffic.
	dynamic_active_clusters?: [...#ClustersConfigDump_DynamicCluster]
	// The dynamically loaded warming clusters. These are clusters that are currently undergoing
	// warming in preparation to service data plane traffic. Note that if attempting to recreate an
	// Envoy configuration from a configuration dump, the warming clusters should generally be
	// discarded.
	dynamic_warming_clusters?: [...#ClustersConfigDump_DynamicCluster]
}

// Envoy's RDS implementation fills this message with all currently loaded routes, as described by
// their RouteConfiguration objects. Static routes that are either defined in the bootstrap configuration
// or defined inline while configuring listeners are separated from those configured dynamically via RDS.
// Route configuration information can be used to recreate an Envoy configuration by populating all routes
// as static routes or by returning them in RDS responses.
#RoutesConfigDump: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.RoutesConfigDump"
	// The statically loaded route configs.
	static_route_configs?: [...#RoutesConfigDump_StaticRouteConfig]
	// The dynamically loaded route configs.
	dynamic_route_configs?: [...#RoutesConfigDump_DynamicRouteConfig]
}

// Envoy's scoped RDS implementation fills this message with all currently loaded route
// configuration scopes (defined via ScopedRouteConfigurationsSet protos). This message lists both
// the scopes defined inline with the higher order object (i.e., the HttpConnectionManager) and the
// dynamically obtained scopes via the SRDS API.
#ScopedRoutesConfigDump: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ScopedRoutesConfigDump"
	// The statically loaded scoped route configs.
	inline_scoped_route_configs?: [...#ScopedRoutesConfigDump_InlineScopedRouteConfigs]
	// The dynamically loaded scoped route configs.
	dynamic_scoped_route_configs?: [...#ScopedRoutesConfigDump_DynamicScopedRouteConfigs]
}

// Envoys SDS implementation fills this message with all secrets fetched dynamically via SDS.
#SecretsConfigDump: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.SecretsConfigDump"
	// The statically loaded secrets.
	static_secrets?: [...#SecretsConfigDump_StaticSecret]
	// The dynamically loaded active secrets. These are secrets that are available to service
	// clusters or listeners.
	dynamic_active_secrets?: [...#SecretsConfigDump_DynamicSecret]
	// The dynamically loaded warming secrets. These are secrets that are currently undergoing
	// warming in preparation to service clusters or listeners.
	dynamic_warming_secrets?: [...#SecretsConfigDump_DynamicSecret]
}

// Describes a statically loaded listener.
#ListenersConfigDump_StaticListener: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ListenersConfigDump_StaticListener"
	// The listener config.
	listener?: _
	// The timestamp when the Listener was last successfully updated.
	last_updated?: string
}

#ListenersConfigDump_DynamicListenerState: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ListenersConfigDump_DynamicListenerState"
	// This is the per-resource version information. This version is currently taken from the
	// :ref:`version_info <envoy_api_field_DiscoveryResponse.version_info>` field at the time
	// that the listener was loaded. In the future, discrete per-listener versions may be supported
	// by the API.
	version_info?: string
	// The listener config.
	listener?: _
	// The timestamp when the Listener was last successfully updated.
	last_updated?: string
}

// Describes a dynamically loaded listener via the LDS API.
// [#next-free-field: 6]
#ListenersConfigDump_DynamicListener: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ListenersConfigDump_DynamicListener"
	// The name or unique id of this listener, pulled from the DynamicListenerState config.
	name?: string
	// The listener state for any active listener by this name.
	// These are listeners that are available to service data plane traffic.
	active_state?: #ListenersConfigDump_DynamicListenerState
	// The listener state for any warming listener by this name.
	// These are listeners that are currently undergoing warming in preparation to service data
	// plane traffic. Note that if attempting to recreate an Envoy configuration from a
	// configuration dump, the warming listeners should generally be discarded.
	warming_state?: #ListenersConfigDump_DynamicListenerState
	// The listener state for any draining listener by this name.
	// These are listeners that are currently undergoing draining in preparation to stop servicing
	// data plane traffic. Note that if attempting to recreate an Envoy configuration from a
	// configuration dump, the draining listeners should generally be discarded.
	draining_state?: #ListenersConfigDump_DynamicListenerState
	// Set if the last update failed, cleared after the next successful update.
	error_state?: #UpdateFailureState
}

// Describes a statically loaded cluster.
#ClustersConfigDump_StaticCluster: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ClustersConfigDump_StaticCluster"
	// The cluster config.
	cluster?: _
	// The timestamp when the Cluster was last updated.
	last_updated?: string
}

// Describes a dynamically loaded cluster via the CDS API.
#ClustersConfigDump_DynamicCluster: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ClustersConfigDump_DynamicCluster"
	// This is the per-resource version information. This version is currently taken from the
	// :ref:`version_info <envoy_api_field_DiscoveryResponse.version_info>` field at the time
	// that the cluster was loaded. In the future, discrete per-cluster versions may be supported by
	// the API.
	version_info?: string
	// The cluster config.
	cluster?: _
	// The timestamp when the Cluster was last updated.
	last_updated?: string
}

#RoutesConfigDump_StaticRouteConfig: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.RoutesConfigDump_StaticRouteConfig"
	// The route config.
	route_config?: _
	// The timestamp when the Route was last updated.
	last_updated?: string
}

#RoutesConfigDump_DynamicRouteConfig: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.RoutesConfigDump_DynamicRouteConfig"
	// This is the per-resource version information. This version is currently taken from the
	// :ref:`version_info <envoy_api_field_DiscoveryResponse.version_info>` field at the time that
	// the route configuration was loaded.
	version_info?: string
	// The route config.
	route_config?: _
	// The timestamp when the Route was last updated.
	last_updated?: string
}

#ScopedRoutesConfigDump_InlineScopedRouteConfigs: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ScopedRoutesConfigDump_InlineScopedRouteConfigs"
	// The name assigned to the scoped route configurations.
	name?: string
	// The scoped route configurations.
	scoped_route_configs?: _
	// The timestamp when the scoped route config set was last updated.
	last_updated?: string
}

#ScopedRoutesConfigDump_DynamicScopedRouteConfigs: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.ScopedRoutesConfigDump_DynamicScopedRouteConfigs"
	// The name assigned to the scoped route configurations.
	name?: string
	// This is the per-resource version information. This version is currently taken from the
	// :ref:`version_info <envoy_api_field_DiscoveryResponse.version_info>` field at the time that
	// the scoped routes configuration was loaded.
	version_info?: string
	// The scoped route configurations.
	scoped_route_configs?: _
	// The timestamp when the scoped route config set was last updated.
	last_updated?: string
}

// DynamicSecret contains secret information fetched via SDS.
#SecretsConfigDump_DynamicSecret: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.SecretsConfigDump_DynamicSecret"
	// The name assigned to the secret.
	name?: string
	// This is the per-resource version information.
	version_info?: string
	// The timestamp when the secret was last updated.
	last_updated?: string
	// The actual secret information.
	// Security sensitive information is redacted (replaced with "[redacted]") for
	// private keys and passwords in TLS certificates.
	secret?: _
}

// StaticSecret specifies statically loaded secret in bootstrap.
#SecretsConfigDump_StaticSecret: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.SecretsConfigDump_StaticSecret"
	// The name assigned to the secret.
	name?: string
	// The timestamp when the secret was last updated.
	last_updated?: string
	// The actual secret information.
	// Security sensitive information is redacted (replaced with "[redacted]") for
	// private keys and passwords in TLS certificates.
	secret?: _
}
