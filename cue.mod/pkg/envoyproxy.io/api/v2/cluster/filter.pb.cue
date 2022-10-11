package cluster

#Filter: {
	"@type": "type.googleapis.com/envoy.api.v2.cluster.Filter"
	// The name of the filter to instantiate. The name must match a
	// :ref:`supported filter <config_network_filters>`.
	name?: string
	// Filter specific configuration which depends on the filter being
	// instantiated. See the supported filters for further documentation.
	typed_config?: _
}
