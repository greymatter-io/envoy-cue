package v3

import (
	v3 "envoyproxy.io/type/matcher/v3"
)

// Used to match request service of the downstream request. Only applicable if a service provided
// by the application protocol.
// This is deprecated and should be replaced by HostMatchInput. This is kept for backward compatibility.
#ServiceMatchInput: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.ServiceMatchInput"
}

// Used to match request host of the generic downstream request. Only applicable if a host provided
// by the application protocol.
// This is same with the ServiceMatchInput and this should be preferred over ServiceMatchInput.
#HostMatchInput: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.HostMatchInput"
}

// Used to match request path of the generic downstream request. Only applicable if a path provided
// by the application protocol.
#PathMatchInput: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.PathMatchInput"
}

// Used to match request method of the generic downstream request. Only applicable if a method provided
// by the application protocol.
#MethodMatchInput: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.MethodMatchInput"
}

// Used to match an arbitrary property of the generic downstream request.
// These properties are populated by the codecs of application protocols.
#PropertyMatchInput: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.PropertyMatchInput"
	// The property name to match on.
	property_name?: string
}

// Used to match an whole generic downstream request.
#RequestMatchInput: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.RequestMatchInput"
}

// Used to match an arbitrary key-value pair for headers, trailers or properties.
#KeyValueMatchEntry: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.KeyValueMatchEntry"
	// The key name to match on.
	name?: string
	// The key value pattern.
	string_match?: v3.#StringMatcher
}

// Custom matcher to match on the generic downstream request. This is used to match
// multiple fields of the downstream request and avoid complex combinations of
// HostMatchInput, PathMatchInput, MethodMatchInput and PropertyMatchInput.
#RequestMatcher: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.RequestMatcher"
	// Optional host pattern to match on. If not specified, any host will match.
	host?: v3.#StringMatcher
	// Optional path pattern to match on. If not specified, any path will match.
	path?: v3.#StringMatcher
	// Optional method pattern to match on. If not specified, any method will match.
	method?: v3.#StringMatcher
	// Optional arbitrary properties to match on. If not specified, any properties
	// will match. The key is the property name and the value is the property value
	// to match on.
	properties?: [...#KeyValueMatchEntry]
}
