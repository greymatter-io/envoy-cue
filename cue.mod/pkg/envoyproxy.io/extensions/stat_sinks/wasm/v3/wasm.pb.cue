package v3

import (
	v3 "envoyproxy.io/extensions/wasm/v3"
)

#Wasm: {
	"@type": "type.googleapis.com/envoy.extensions.stat_sinks.wasm.v3.Wasm"
	// General Plugin configuration.
	config?: v3.#PluginConfig
}
