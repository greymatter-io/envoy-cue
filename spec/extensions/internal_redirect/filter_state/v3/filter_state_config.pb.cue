package v3

// An internal redirect predicate that decides whether to follow a redirect by
// reading a boolean filter-state object set earlier in the request by another
// filter (Lua, ext_proc, “set_filter_state“, a dynamic module, ...).
//
// The predicate reads the filter-state boolean object named “redirect_enabled_key“:
//
// * If the value is “true“: follows the redirect
// * If the value is “false“: does not follow the redirect
// * If the object is absent: “redirect_if_absent“ decides (default: false)
//
// This lets a request-phase filter decide, per request, whether an
// otherwise-enabled internal redirect is actually taken, without changing route
// matching. Rich, request-time logic (tenant, JWT claim, header, time-of-day,
// rollout %) belongs in the filter that *sets* the boolean value; this predicate
// is a thin reader.
// [#extension: envoy.internal_redirect_predicates.filter_state]
#FilterStateConfig: {
	"@type": "type.googleapis.com/envoy.extensions.internal_redirect.filter_state.v3.FilterStateConfig"
	// Name of the filter-state boolean object to read. If true, the redirect is
	// followed; if false, the redirect is skipped. Must be non-empty.
	redirect_enabled_key?: string
	// Whether to follow the redirect when the filter-state object is absent.
	// Defaults to false (do not redirect if the gate wasn't explicitly set),
	// giving an opt-in posture.
	redirect_if_absent?: bool
}
