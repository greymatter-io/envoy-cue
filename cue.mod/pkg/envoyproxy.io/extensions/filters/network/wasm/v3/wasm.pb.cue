package v3

import (
	v3 "envoyproxy.io/extensions/wasm/v3"
)

#Wasm: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.wasm.v3.Wasm"
	// General Plugin configuration.
	config?: v3.#PluginConfig
}
