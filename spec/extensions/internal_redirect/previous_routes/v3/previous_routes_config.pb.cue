package v3

// An internal redirect predicate that rejects redirect targets that are pointing
// to a route that has been followed by a previous redirect from the current route.
// [#extension: envoy.internal_redirect_predicates.previous_routes]
#PreviousRoutesConfig: {
	"@type": "type.googleapis.com/envoy.extensions.internal_redirect.previous_routes.v3.PreviousRoutesConfig"
}
