package v3

// Specifies a routing scope, which associates a
// :ref:`Key<envoy_v3_api_msg_config.route.v3.ScopedRouteConfiguration.Key>` to a
// :ref:`envoy_v3_api_msg_config.route.v3.RouteConfiguration`.
// The :ref:`envoy_v3_api_msg_config.route.v3.RouteConfiguration` can be obtained dynamically
// via RDS (:ref:`route_configuration_name<envoy_v3_api_field_config.route.v3.ScopedRouteConfiguration.route_configuration_name>`)
// or specified inline (:ref:`route_configuration<envoy_v3_api_field_config.route.v3.ScopedRouteConfiguration.route_configuration>`).
//
// The HTTP connection manager builds up a table consisting of these Key to
// RouteConfiguration mappings, and looks up the RouteConfiguration to use per
// request according to the algorithm specified in the
// :ref:`scope_key_builder<envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.ScopedRoutes.scope_key_builder>`
// assigned to the HttpConnectionManager.
//
// For example, with the following configurations (in YAML):
//
// HttpConnectionManager config:
//
// .. code::
//
//   ...
//   scoped_routes:
//     name: foo-scoped-routes
//     scope_key_builder:
//       fragments:
//         - header_value_extractor:
//             name: X-Route-Selector
//             element_separator: ,
//             element:
//               separator: =
//               key: vip
//
// ScopedRouteConfiguration resources (specified statically via
// :ref:`scoped_route_configurations_list<envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.ScopedRoutes.scoped_route_configurations_list>`
// or obtained dynamically via SRDS):
//
// .. code::
//
//  (1)
//   name: route-scope1
//   route_configuration_name: route-config1
//   key:
//      fragments:
//        - string_key: 172.10.10.20
//
//  (2)
//   name: route-scope2
//   route_configuration_name: route-config2
//   key:
//     fragments:
//       - string_key: 172.20.20.30
//
// A request from a client such as:
//
// .. code::
//
//     GET / HTTP/1.1
//     Host: foo.com
//     X-Route-Selector: vip=172.10.10.20
//
// would result in the routing table defined by the ``route-config1``
// RouteConfiguration being assigned to the HTTP request/stream.
//
// [#next-free-field: 6]
#ScopedRouteConfiguration: {
	"@type": "type.googleapis.com/envoy.config.route.v3.ScopedRouteConfiguration"
	// Whether the RouteConfiguration should be loaded on demand.
	on_demand?: bool
	// The name assigned to the routing scope.
	name?: string
	// The resource name to use for a :ref:`envoy_v3_api_msg_service.discovery.v3.DiscoveryRequest` to an
	// RDS server to fetch the :ref:`envoy_v3_api_msg_config.route.v3.RouteConfiguration` associated
	// with this scope.
	route_configuration_name?: string
	// The :ref:`envoy_v3_api_msg_config.route.v3.RouteConfiguration` associated with the scope.
	route_configuration?: #RouteConfiguration
	// The key to match against.
	key?: #ScopedRouteConfiguration_Key
}

// Specifies a key which is matched against the output of the
// :ref:`scope_key_builder<envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.ScopedRoutes.scope_key_builder>`
// specified in the HttpConnectionManager. The matching is done per HTTP
// request and is dependent on the order of the fragments contained in the
// Key.
#ScopedRouteConfiguration_Key: {
	"@type": "type.googleapis.com/envoy.config.route.v3.ScopedRouteConfiguration_Key"
	// The ordered set of fragments to match against. The order must match the
	// fragments in the corresponding
	// :ref:`scope_key_builder<envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.ScopedRoutes.scope_key_builder>`.
	fragments?: [...#ScopedRouteConfiguration_Key_Fragment]
}

#ScopedRouteConfiguration_Key_Fragment: {
	"@type": "type.googleapis.com/envoy.config.route.v3.ScopedRouteConfiguration_Key_Fragment"
	// A string to match against.
	string_key?: string
}
