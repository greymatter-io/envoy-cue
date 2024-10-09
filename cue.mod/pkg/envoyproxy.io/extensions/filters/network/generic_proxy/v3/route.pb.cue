package v3

import (
	v3 "envoyproxy.io/deps/cncf/xds/go/xds/type/matcher/v3"
)

#VirtualHost: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.v3.VirtualHost"
	// The name of the virtual host.
	name?: string
	// A list of hosts that will be matched to this virtual host. Wildcard hosts are supported in
	// the suffix or prefix form.
	//
	// Host search order:
	//  1. Exact names: “www.foo.com“.
	//  2. Suffix wildcards: “*.foo.com“ or “*-bar.foo.com“.
	//  3. Prefix wildcards: “foo.*“ or “foo-*“.
	//  4. Special wildcard “*“ matching any host and will be the default virtual host.
	//
	// .. note::
	//
	//	The wildcard will not match the empty string.
	//	e.g. ``*-bar.foo.com`` will match ``baz-bar.foo.com`` but not ``-bar.foo.com``.
	//	The longest wildcards match first.
	//	Only a single virtual host in the entire route configuration can match on ``*``. A domain
	//	must be unique across all virtual hosts or the config will fail to load.
	hosts?: [...string]
	// The match tree to use when resolving route actions for incoming requests.
	routes?: v3.#Matcher
}

// The generic proxy makes use of the xDS matching API for routing configurations.
//
// In the below example, we combine a top level tree matcher with a linear matcher to match
// the incoming requests, and send the matching requests to v1 of the upstream service.
//
// .. code-block:: yaml
//
//	name: example
//	routes:
//	  matcher_tree:
//	    input:
//	      name: request-service
//	      typed_config:
//	        "@type": type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.ServiceMatchInput
//	    exact_match_map:
//	      map:
//	        service_name_0:
//	          matcher:
//	            matcher_list:
//	              matchers:
//	              - predicate:
//	                  and_matcher:
//	                    predicate:
//	                    - single_predicate:
//	                        input:
//	                          name: request-properties
//	                          typed_config:
//	                            "@type": type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.PropertyMatchInput
//	                            property_name: version
//	                        value_match:
//	                          exact: v1
//	                    - single_predicate:
//	                        input:
//	                          name: request-properties
//	                          typed_config:
//	                            "@type": type.googleapis.com/envoy.extensions.filters.network.generic_proxy.matcher.v3.PropertyMatchInput
//	                            property_name: user
//	                        value_match:
//	                          exact: john
//	                on_match:
//	                  action:
//	                    name: route
//	                    typed_config:
//	                      "@type": type.googleapis.com/envoy.extensions.filters.network.generic_proxy.action.v3.routeAction
//	                      cluster: cluster_0
#RouteConfiguration: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.generic_proxy.v3.RouteConfiguration"
	// The name of the route configuration. For example, it might match route_config_name in
	// envoy.extensions.filters.network.generic_proxy.v3.Rds.
	name?: string
	// The match tree to use when resolving route actions for incoming requests.
	// If no any virtual host is configured in the “virtual_hosts“ field or no special wildcard
	// virtual host is configured, the “routes“ field will be used as the default route table.
	// If both the wildcard virtual host and “routes“ are configured, the configuration will fail
	// to load.
	routes?: v3.#Matcher
	// An array of virtual hosts that make up the route table.
	virtual_hosts?: [...#VirtualHost]
}
