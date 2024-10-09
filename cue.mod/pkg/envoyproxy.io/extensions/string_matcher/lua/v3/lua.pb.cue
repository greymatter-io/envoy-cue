package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#Lua: {
	"@type": "type.googleapis.com/envoy.extensions.string_matcher.lua.v3.Lua"
	// The Lua code that Envoy will execute
	source_code?: v3.#DataSource
}
