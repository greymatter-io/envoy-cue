package v3

import (
	v3 "envoyproxy.io/config/rbac/v3"
	v31 "envoyproxy.io/deps/cncf/xds/go/xds/type/matcher/v3"
)

// RBAC filter config.
// [#next-free-field: 6]
#RBAC: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rbac.v3.RBAC"
	// Specify the RBAC rules to be applied globally.
	// If absent, no enforcing RBAC policy will be applied.
	// If present and empty, DENY.
	// If both rules and matcher are configured, rules will be ignored.
	rules?: v3.#RBAC
	// The match tree to use when resolving RBAC action for incoming requests. Requests do not
	// match any matcher will be denied.
	// If absent, no enforcing RBAC matcher will be applied.
	// If present and empty, deny all requests.
	matcher?: v31.#Matcher
	// Shadow rules are not enforced by the filter (i.e., returning a 403)
	// but will emit stats and logs and can be used for rule testing.
	// If absent, no shadow RBAC policy will be applied.
	// If both shadow rules and shadow matcher are configured, shadow rules will be ignored.
	shadow_rules?: v3.#RBAC
	// The match tree to use for emitting stats and logs which can be used for rule testing for
	// incoming requests.
	// If absent, no shadow matcher will be applied.
	shadow_matcher?: v31.#Matcher
	// If specified, shadow rules will emit stats with the given prefix.
	// This is useful to distinguish the stat when there are more than 1 RBAC filter configured with
	// shadow rules.
	shadow_rules_stat_prefix?: string
}

#RBACPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rbac.v3.RBACPerRoute"
	// Override the global configuration of the filter with this new config.
	// If absent, the global RBAC policy will be disabled for this route.
	rbac?: #RBAC
}
