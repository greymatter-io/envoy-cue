package v3

// Resource status from the view of a xDS client, which tells the synchronization
// status between the xDS client and the xDS server.
#ClientResourceStatus: "UNKNOWN" | "REQUESTED" | "DOES_NOT_EXIST" | "ACKED" | "NACKED"

ClientResourceStatus_UNKNOWN:        "UNKNOWN"
ClientResourceStatus_REQUESTED:      "REQUESTED"
ClientResourceStatus_DOES_NOT_EXIST: "DOES_NOT_EXIST"
ClientResourceStatus_ACKED:          "ACKED"
ClientResourceStatus_NACKED:         "NACKED"

#UpdateFailureState: {
	"@type": "type.googleapis.com/envoy.admin.v3.UpdateFailureState"
	// What the component configuration would have been if the update had succeeded.
	// This field may not be populated by xDS clients due to storage overhead.
	failed_configuration?: _
	// Time of the latest failed update attempt.
	last_update_attempt?: string
	// Details about the last failed update attempt.
	details?: string
	// This is the version of the rejected resource.
	// [#not-implemented-hide:]
	version_info?: string
}

// Envoy's listener manager fills this message with all currently known listeners. Listener
// configuration information can be used to recreate an Envoy configuration by populating all
// listeners as static listeners or by returning them in a LDS response.
#ListenersConfigDump: {
	"@type": "type.googleapis.com/envoy.admin.v3.ListenersConfigDump"
	// This is the :ref:`version_info <envoy_v3_api_field_service.discovery.v3.DiscoveryResponse.version_info>` in the
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
	"@type": "type.googleapis.com/envoy.admin.v3.ClustersConfigDump"
	// This is the :ref:`version_info <envoy_v3_api_field_service.discovery.v3.DiscoveryResponse.version_info>` in the
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
	"@type": "type.googleapis.com/envoy.admin.v3.RoutesConfigDump"
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
	"@type": "type.googleapis.com/envoy.admin.v3.ScopedRoutesConfigDump"
	// The statically loaded scoped route configs.
	inline_scoped_route_configs?: [...#ScopedRoutesConfigDump_InlineScopedRouteConfigs]
	// The dynamically loaded scoped route configs.
	dynamic_scoped_route_configs?: [...#ScopedRoutesConfigDump_DynamicScopedRouteConfigs]
}

// Envoy's admin fill this message with all currently known endpoints. Endpoint
// configuration information can be used to recreate an Envoy configuration by populating all
// endpoints as static endpoints or by returning them in an EDS response.
#EndpointsConfigDump: {
	"@type": "type.googleapis.com/envoy.admin.v3.EndpointsConfigDump"
	// The statically loaded endpoint configs.
	static_endpoint_configs?: [...#EndpointsConfigDump_StaticEndpointConfig]
	// The dynamically loaded endpoint configs.
	dynamic_endpoint_configs?: [...#EndpointsConfigDump_DynamicEndpointConfig]
}

// Describes a statically loaded listener.
#ListenersConfigDump_StaticListener: {
	"@type": "type.googleapis.com/envoy.admin.v3.ListenersConfigDump_StaticListener"
	// The listener config.
	listener?: _
	// The timestamp when the Listener was last successfully updated.
	last_updated?: string
}

#ListenersConfigDump_DynamicListenerState: {
	"@type": "type.googleapis.com/envoy.admin.v3.ListenersConfigDump_DynamicListenerState"
	// This is the per-resource version information. This version is currently taken from the
	// :ref:`version_info <envoy_v3_api_field_service.discovery.v3.DiscoveryResponse.version_info>` field at the time
	// that the listener was loaded. In the future, discrete per-listener versions may be supported
	// by the API.
	version_info?: string
	// The listener config.
	listener?: _
	// The timestamp when the Listener was last successfully updated.
	last_updated?: string
}

// Describes a dynamically loaded listener via the LDS API.
// [#next-free-field: 7]
#ListenersConfigDump_DynamicListener: {
	"@type": "type.googleapis.com/envoy.admin.v3.ListenersConfigDump_DynamicListener"
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
	// The ``error_state`` field contains the rejected version of this particular
	// resource along with the reason and timestamp. For successfully updated or
	// acknowledged resource, this field should be empty.
	error_state?: #UpdateFailureState
	// The client status of this resource.
	// [#not-implemented-hide:]
	client_status?: #ClientResourceStatus
}

// Describes a statically loaded cluster.
#ClustersConfigDump_StaticCluster: {
	"@type": "type.googleapis.com/envoy.admin.v3.ClustersConfigDump_StaticCluster"
	// The cluster config.
	cluster?: _
	// The timestamp when the Cluster was last updated.
	last_updated?: string
}

// Describes a dynamically loaded cluster via the CDS API.
// [#next-free-field: 6]
#ClustersConfigDump_DynamicCluster: {
	"@type": "type.googleapis.com/envoy.admin.v3.ClustersConfigDump_DynamicCluster"
	// This is the per-resource version information. This version is currently taken from the
	// :ref:`version_info <envoy_v3_api_field_service.discovery.v3.DiscoveryResponse.version_info>` field at the time
	// that the cluster was loaded. In the future, discrete per-cluster versions may be supported by
	// the API.
	version_info?: string
	// The cluster config.
	cluster?: _
	// The timestamp when the Cluster was last updated.
	last_updated?: string
	// Set if the last update failed, cleared after the next successful update.
	// The ``error_state`` field contains the rejected version of this particular
	// resource along with the reason and timestamp. For successfully updated or
	// acknowledged resource, this field should be empty.
	// [#not-implemented-hide:]
	error_state?: #UpdateFailureState
	// The client status of this resource.
	// [#not-implemented-hide:]
	client_status?: #ClientResourceStatus
}

#RoutesConfigDump_StaticRouteConfig: {
	"@type": "type.googleapis.com/envoy.admin.v3.RoutesConfigDump_StaticRouteConfig"
	// The route config.
	route_config?: _
	// The timestamp when the Route was last updated.
	last_updated?: string
}

// [#next-free-field: 6]
#RoutesConfigDump_DynamicRouteConfig: {
	"@type": "type.googleapis.com/envoy.admin.v3.RoutesConfigDump_DynamicRouteConfig"
	// This is the per-resource version information. This version is currently taken from the
	// :ref:`version_info <envoy_v3_api_field_service.discovery.v3.DiscoveryResponse.version_info>` field at the time that
	// the route configuration was loaded.
	version_info?: string
	// The route config.
	route_config?: _
	// The timestamp when the Route was last updated.
	last_updated?: string
	// Set if the last update failed, cleared after the next successful update.
	// The ``error_state`` field contains the rejected version of this particular
	// resource along with the reason and timestamp. For successfully updated or
	// acknowledged resource, this field should be empty.
	// [#not-implemented-hide:]
	error_state?: #UpdateFailureState
	// The client status of this resource.
	// [#not-implemented-hide:]
	client_status?: #ClientResourceStatus
}

#ScopedRoutesConfigDump_InlineScopedRouteConfigs: {
	"@type": "type.googleapis.com/envoy.admin.v3.ScopedRoutesConfigDump_InlineScopedRouteConfigs"
	// The name assigned to the scoped route configurations.
	name?: string
	// The scoped route configurations.
	scoped_route_configs?: _
	// The timestamp when the scoped route config set was last updated.
	last_updated?: string
}

// [#next-free-field: 7]
#ScopedRoutesConfigDump_DynamicScopedRouteConfigs: {
	"@type": "type.googleapis.com/envoy.admin.v3.ScopedRoutesConfigDump_DynamicScopedRouteConfigs"
	// The name assigned to the scoped route configurations.
	name?: string
	// This is the per-resource version information. This version is currently taken from the
	// :ref:`version_info <envoy_v3_api_field_service.discovery.v3.DiscoveryResponse.version_info>` field at the time that
	// the scoped routes configuration was loaded.
	version_info?: string
	// The scoped route configurations.
	scoped_route_configs?: _
	// The timestamp when the scoped route config set was last updated.
	last_updated?: string
	// Set if the last update failed, cleared after the next successful update.
	// The ``error_state`` field contains the rejected version of this particular
	// resource along with the reason and timestamp. For successfully updated or
	// acknowledged resource, this field should be empty.
	// [#not-implemented-hide:]
	error_state?: #UpdateFailureState
	// The client status of this resource.
	// [#not-implemented-hide:]
	client_status?: #ClientResourceStatus
}

#EndpointsConfigDump_StaticEndpointConfig: {
	"@type": "type.googleapis.com/envoy.admin.v3.EndpointsConfigDump_StaticEndpointConfig"
	// The endpoint config.
	endpoint_config?: _
	// [#not-implemented-hide:] The timestamp when the Endpoint was last updated.
	last_updated?: string
}

// [#next-free-field: 6]
#EndpointsConfigDump_DynamicEndpointConfig: {
	"@type": "type.googleapis.com/envoy.admin.v3.EndpointsConfigDump_DynamicEndpointConfig"
	// [#not-implemented-hide:] This is the per-resource version information. This version is currently taken from the
	// :ref:`version_info <envoy_v3_api_field_service.discovery.v3.DiscoveryResponse.version_info>` field at the time that
	// the endpoint configuration was loaded.
	version_info?: string
	// The endpoint config.
	endpoint_config?: _
	// [#not-implemented-hide:] The timestamp when the Endpoint was last updated.
	last_updated?: string
	// Set if the last update failed, cleared after the next successful update.
	// The ``error_state`` field contains the rejected version of this particular
	// resource along with the reason and timestamp. For successfully updated or
	// acknowledged resource, this field should be empty.
	// [#not-implemented-hide:]
	error_state?: #UpdateFailureState
	// The client status of this resource.
	// [#not-implemented-hide:]
	client_status?: #ClientResourceStatus
}
