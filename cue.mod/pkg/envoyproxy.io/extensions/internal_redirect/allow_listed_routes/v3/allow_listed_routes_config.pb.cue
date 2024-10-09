package v3

// An internal redirect predicate that accepts only explicitly allowed target routes.
// [#extension: envoy.internal_redirect_predicates.allow_listed_routes]
#AllowListedRoutesConfig: {
	"@type": "type.googleapis.com/envoy.extensions.internal_redirect.allow_listed_routes.v3.AllowListedRoutesConfig"
	// The list of routes that's allowed as redirect target by this predicate,
	// identified by the route's :ref:`name <envoy_v3_api_field_config.route.v3.Route.route>`.
	// Empty route names are not allowed.
	allowed_route_names?: [...string]
}
