package v3alpha

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
)

// The meanings are as follows:
//
// :“MERGE_VIRTUALHOST_ROUTER_FILTER“: Pass all configuration into Go plugin.
// :“MERGE_VIRTUALHOST_ROUTER“: Pass merged Virtual host and Router configuration into Go plugin.
// :“OVERRIDE“: Pass merged Virtual host, Router, and plugin configuration into Go plugin.
//
// [#not-implemented-hide:]
#Config_MergePolicy: "MERGE_VIRTUALHOST_ROUTER_FILTER" | "MERGE_VIRTUALHOST_ROUTER" | "OVERRIDE"

Config_MergePolicy_MERGE_VIRTUALHOST_ROUTER_FILTER: "MERGE_VIRTUALHOST_ROUTER_FILTER"
Config_MergePolicy_MERGE_VIRTUALHOST_ROUTER:        "MERGE_VIRTUALHOST_ROUTER"
Config_MergePolicy_OVERRIDE:                        "OVERRIDE"

// [#next-free-field: 7]
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.golang.v3alpha.Config"
	// Globally unique ID for a dynamic library file.
	library_id?: string
	// Path to a dynamic library implementing the
	// :repo:`StreamFilter API <contrib/golang/common/go/api.StreamFilter>`
	// interface.
	// [#comment:TODO(wangfakang): Support for downloading libraries from remote repositories.]
	library_path?: string
	// Globally unique name of the Go plugin.
	//
	// This name **must** be consistent with the name registered in “http::RegisterHttpFilterConfigFactory“,
	// and can be used to associate :ref:`route and virtualHost plugin configuration
	// <envoy_v3_api_field_extensions.filters.http.golang.v3alpha.ConfigsPerRoute.plugins_config>`.
	plugin_name?: string
	// Configuration for the Go plugin.
	//
	// .. note::
	//
	//	This configuration is only parsed in the go plugin, and is therefore not validated
	//	by Envoy.
	//
	//	See the :repo:`StreamFilter API <contrib/golang/common/go/api/filter.go>`
	//	for more information about how the plugin's configuration data can be accessed.
	plugin_config?: _
	// Merge policy for plugin configuration.
	//
	// The Go plugin configuration supports three dimensions:
	//
	// * Virtual host’s :ref:`typed_per_filter_config <envoy_v3_api_field_config.route.v3.VirtualHost.typed_per_filter_config>`
	// * Route’s :ref:`typed_per_filter_config <envoy_v3_api_field_config.route.v3.Route.typed_per_filter_config>`
	// * The filter's :ref:`plugin_config <envoy_v3_api_field_extensions.filters.http.golang.v3alpha.Config.plugin_config>`
	//
	// [#not-implemented-hide:]
	merge_policy?: #Config_MergePolicy
	// Generic secret list available to the plugin.
	// Looks into SDS or static bootstrap configuration.
	//
	// See :repo:`StreamFilter API <contrib/golang/common/go/api/filter.go>`
	// for more information about how to access secrets from Go.
	generic_secrets?: [...v3.#SdsSecretConfig]
}

#RouterPlugin: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.golang.v3alpha.RouterPlugin"
	// [#not-implemented-hide:]
	// Disable the filter for this particular vhost or route.
	// If disabled is specified in multiple per-filter-configs, the most specific one will be used.
	disabled?: bool
	// The config field is used for setting per-route and per-virtualhost plugin config.
	config?: _
}

#ConfigsPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.golang.v3alpha.ConfigsPerRoute"
	// Configuration of the Go plugin at the per-router or per-virtualhost level,
	// keyed on the :ref:`plugin_name <envoy_v3_api_field_extensions.filters.http.golang.v3alpha.Config.plugin_name>`
	// of the Go plugin.
	plugins_config?: [string]: #RouterPlugin
}
