package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#LuaConfig: {
	"@type": "type.googleapis.com/envoy.extensions.router.cluster_specifiers.lua.v3.LuaConfig"
	// The lua code that Envoy will execute to select cluster.
	source_code?: v3.#DataSource
	// Default cluster. It will be used when the lua code execute failure.
	default_cluster?: string
}
