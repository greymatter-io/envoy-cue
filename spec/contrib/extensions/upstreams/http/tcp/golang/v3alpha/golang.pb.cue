package v3alpha

// [#extension-category: envoy.upstreams]
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.upstreams.http.tcp.golang.v3alpha.Config"
	// Globally unique ID for a dynamic library file.
	library_id?: string
	// Path to a dynamic library implementing the
	// :repo:`HttpTcpBridge API <contrib/golang/common/go/api.HttpTcpBridge>`
	// interface.
	library_path?: string
	// Globally unique name of the Go plugin.
	//
	// This name **must** be consistent with the name registered in “tcp::RegisterHttpTcpBridgeFactoryAndConfigParser“
	plugin_name?: string
	// Configuration for the Go plugin.
	//
	// .. note::
	//
	//	This configuration is only parsed in the Golang plugin, and is therefore not validated
	//	by Envoy.
	//
	//	See the :repo:`HttpTcpBridge API <contrib/golang/common/go/api/filter.go>`
	//	for more information about how the plugin's configuration data can be accessed.
	plugin_config?: _
}
