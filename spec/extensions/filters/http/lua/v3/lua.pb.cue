package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#Lua: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.lua.v3.Lua"
	// The Lua code that Envoy will execute. This can be a very small script that
	// further loads code from disk if desired. Note that if JSON configuration is used, the code must
	// be properly escaped. YAML configuration may be easier to read since YAML supports multi-line
	// strings so complex scripts can be easily expressed inline in the configuration.
	//
	// This field is deprecated. Please use
	// :ref:`default_source_code <envoy_v3_api_field_extensions.filters.http.lua.v3.Lua.default_source_code>`.
	// Only one of :ref:`inline_code <envoy_v3_api_field_extensions.filters.http.lua.v3.Lua.inline_code>`
	// or :ref:`default_source_code <envoy_v3_api_field_extensions.filters.http.lua.v3.Lua.default_source_code>`
	// can be set for the Lua filter.
	//
	// Deprecated: Do not use.
	inline_code?: string
	// Map of named Lua source codes that can be referenced in :ref:`LuaPerRoute
	// <envoy_v3_api_msg_extensions.filters.http.lua.v3.LuaPerRoute>`. The Lua source codes can be
	// loaded from inline string or local files.
	//
	// Example:
	//
	// .. code-block:: yaml
	//
	//   source_codes:
	//     hello.lua:
	//       inline_string: |
	//         function envoy_on_response(response_handle)
	//           -- Do something.
	//         end
	//     world.lua:
	//       filename: /etc/lua/world.lua
	//
	source_codes?: [string]: v3.#DataSource
	// The default Lua code that Envoy will execute. If no per route config is provided
	// for the request, this Lua code will be applied.
	default_source_code?: v3.#DataSource
	// Optional additional prefix to use when emitting statistics. By default
	// metrics are emitted in *.lua.* namespace. If multiple lua filters are
	// configured in a filter chain, the stats from each filter instance can
	// be emitted using custom stat prefix to distinguish emitted
	// statistics. For example:
	//
	// .. code-block:: yaml
	//
	//   http_filters:
	//     - name: envoy.filters.http.lua
	//       typed_config:
	//         "@type": type.googleapis.com/envoy.extensions.filters.http.lua.v3.Lua
	//         stat_prefix: foo_script # This emits lua.foo_script.errors etc.
	//     - name: envoy.filters.http.lua
	//       typed_config:
	//         "@type": type.googleapis.com/envoy.extensions.filters.http.lua.v3.Lua
	//         stat_prefix: bar_script # This emits lua.bar_script.errors etc.
	//
	stat_prefix?: string
}

#LuaPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.lua.v3.LuaPerRoute"
	// Disable the Lua filter for this particular vhost or route. If disabled is specified in
	// multiple per-filter-configs, the most specific one will be used.
	disabled?: bool
	// A name of a Lua source code stored in
	// :ref:`Lua.source_codes <envoy_v3_api_field_extensions.filters.http.lua.v3.Lua.source_codes>`.
	name?: string
	// A configured per-route Lua source code that can be served by RDS or provided inline.
	source_code?: v3.#DataSource
}
