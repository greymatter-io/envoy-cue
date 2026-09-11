package v3alpha

#RouteConfiguration: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.RouteConfiguration"
	// The name of the route configuration. Reserved for future use in asynchronous route discovery.
	name?: string
	// The list of routes that will be matched, in order, against incoming requests. The first route
	// that matches will be used.
	routes?: [...#Route]
}

#Route: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.Route"
	// Route matching parameters.
	match?: #RouteMatch
	// Route request to some upstream cluster.
	route?: #RouteAction
}

#RouteMatch: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.RouteMatch"
	// The domain from Request URI or Route Header.
	domain?: string
	// The header to get match parameter, default is "Route".
	header?: string
	// The parameter to get domain, default is "host".
	parameter?: string
}

#RouteAction: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.sip_proxy.v3alpha.RouteAction"
	// Indicates a single upstream cluster to which the request should be routed
	// to.
	cluster?: string
}
