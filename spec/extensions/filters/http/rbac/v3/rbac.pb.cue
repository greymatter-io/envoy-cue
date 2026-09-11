package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/rbac/v3"
	v31 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/type/matcher/v3"
)

// RBAC filter config.
// [#next-free-field: 8]
#RBAC: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rbac.v3.RBAC"
	// The primary RBAC policy which will be applied globally, to all the incoming requests.
	//
	// * If absent, no RBAC enforcement occurs.
	// * If set but empty, all requests are denied.
	//
	// .. note::
	//
	//	When both ``rules`` and ``matcher`` are configured, ``rules`` will be ignored.
	rules?: v3.#RBAC
	// If specified, rules will emit stats with the given prefix.
	// This is useful for distinguishing metrics when multiple RBAC filters are configured.
	rules_stat_prefix?: string
	// Match tree for evaluating RBAC actions on incoming requests. Requests not matching any matcher will be denied.
	//
	// * If absent, no RBAC enforcement occurs.
	// * If set but empty, all requests are denied.
	matcher?: v31.#Matcher
	// Shadow policy for testing RBAC rules without enforcing them. These rules generate stats and logs but do not deny
	// requests. If absent, no shadow RBAC policy will be applied.
	//
	// .. note::
	//
	//	When both ``shadow_rules`` and ``shadow_matcher`` are configured, ``shadow_rules`` will be ignored.
	shadow_rules?: v3.#RBAC
	// If absent, no shadow matcher will be applied.
	// Match tree for testing RBAC rules through stats and logs without enforcing them.
	// If absent, no shadow matching occurs.
	shadow_matcher?: v31.#Matcher
	// If specified, shadow rules will emit stats with the given prefix.
	// This is useful for distinguishing metrics when multiple RBAC filters use shadow rules.
	shadow_rules_stat_prefix?: string
	// If “track_per_rule_stats“ is “true“, counters will be published for each rule and shadow rule.
	track_per_rule_stats?: bool
}

#RBACPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rbac.v3.RBACPerRoute"
	// Per-route specific RBAC configuration that overrides the global RBAC configuration.
	// If absent, RBAC policy will be disabled for this route.
	rbac?: #RBAC
}
