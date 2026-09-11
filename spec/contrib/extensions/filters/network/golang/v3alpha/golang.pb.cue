package v3alpha

// [#next-free-field: 6]
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.golang.v3alpha.Config"
	// Bool “true“ if this filter must be the last filter in a filter chain, “false“ otherwise.
	is_terminal_filter?: bool
	// Globally unique ID for a dynamic library file.
	library_id?: string
	// Path to a dynamic library implementing the
	// :repo:`DownstreamFilter API <contrib/golang/common/go/api.DownstreamFilter>`
	// interface.
	// [#comment:TODO(wangfakang): Support for downloading libraries from remote repositories.]
	library_path?: string
	// Globally unique name of the Go plugin.
	//
	// This name **must** be consistent with the name registered in “network::RegisterNetworkFilterConfigFactory“
	plugin_name?: string
	// Configuration for the Go plugin.
	//
	// .. note::
	//
	//	This configuration is only parsed in the go plugin, and is therefore not validated
	//	by Envoy.
	//
	//	See the :repo:`DownstreamFilter API <contrib/golang/common/go/api/filter.go>`
	//	for more information about how the plugin's configuration data can be accessed.
	plugin_config?: _
}
