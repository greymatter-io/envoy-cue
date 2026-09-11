package v3alpha

// [#extension-category: envoy.router.cluster_specifier_plugin]
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.router.cluster_specifier.golang.v3alpha.Config"
	// Globally unique ID for a dynamic library file.
	library_id?: string
	// Path to a dynamic library implementing the
	// :repo:`ClusterSpecifier API <contrib/golang/router/cluster_specifier/source/go/pkg/api.ClusterSpecifier>`
	// interface.
	// [#comment:TODO(wangfakang): Support for downloading libraries from remote repositories.]
	library_path?: string
	// Default cluster.
	//
	// It will be used when the specifier interface return empty string or panic.
	default_cluster?: string
	// Configuration for the Go cluster specifier plugin.
	//
	// .. note::
	//
	//	This configuration is only parsed in the go cluster specifier, and is therefore not validated
	//	by Envoy.
	//
	//	See the :repo:`StreamFilter API <contrib/golang/router/cluster_specifier/source/go/pkg/cluster_specifier/config.go>`
	//	for more information about how the plugin's configuration data can be accessed.
	config?: _
}
