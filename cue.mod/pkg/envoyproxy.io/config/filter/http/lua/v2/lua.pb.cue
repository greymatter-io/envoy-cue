package v2

#Lua: {
	"@type": "type.googleapis.com/envoy.config.filter.http.lua.v2.Lua"
	// The Lua code that Envoy will execute. This can be a very small script that
	// further loads code from disk if desired. Note that if JSON configuration is used, the code must
	// be properly escaped. YAML configuration may be easier to read since YAML supports multi-line
	// strings so complex scripts can be easily expressed inline in the configuration.
	inline_code?: string
}
