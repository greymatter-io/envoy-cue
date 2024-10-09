package v3

import (
	v3 "envoyproxy.io/config/rbac/v3"
	v31 "envoyproxy.io/deps/cncf/xds/go/xds/type/matcher/v3"
)

#RBAC_EnforcementType: "ONE_TIME_ON_FIRST_BYTE" | "CONTINUOUS"

RBAC_EnforcementType_ONE_TIME_ON_FIRST_BYTE: "ONE_TIME_ON_FIRST_BYTE"
RBAC_EnforcementType_CONTINUOUS:             "CONTINUOUS"

// RBAC network filter config.
//
// Header should not be used in rules/shadow_rules in RBAC network filter as
// this information is only available in :ref:`RBAC http filter <config_http_filters_rbac>`.
// [#next-free-field: 8]
#RBAC: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.rbac.v3.RBAC"
	// Specify the RBAC rules to be applied globally.
	// If absent, no enforcing RBAC policy will be applied.
	// If present and empty, DENY.
	// If both rules and matcher are configured, rules will be ignored.
	rules?: v3.#RBAC
	// The match tree to use when resolving RBAC action for incoming connections. Connections do
	// not match any matcher will be denied.
	// If absent, no enforcing RBAC matcher will be applied.
	// If present and empty, deny all connections.
	matcher?: v31.#Matcher
	// Shadow rules are not enforced by the filter but will emit stats and logs
	// and can be used for rule testing.
	// If absent, no shadow RBAC policy will be applied.
	// If both shadow rules and shadow matcher are configured, shadow rules will be ignored.
	shadow_rules?: v3.#RBAC
	// The match tree to use for emitting stats and logs which can be used for rule testing for
	// incoming connections.
	// If absent, no shadow matcher will be applied.
	shadow_matcher?: v31.#Matcher
	// If specified, shadow rules will emit stats with the given prefix.
	// This is useful to distinguish the stat when there are more than 1 RBAC filter configured with
	// shadow rules.
	shadow_rules_stat_prefix?: string
	// The prefix to use when emitting statistics.
	stat_prefix?: string
	// RBAC enforcement strategy. By default RBAC will be enforced only once
	// when the first byte of data arrives from the downstream. When used in
	// conjunction with filters that emit dynamic metadata after decoding
	// every payload (e.g., Mongo, MySQL, Kafka) set the enforcement type to
	// CONTINUOUS to enforce RBAC policies on every message boundary.
	enforcement_type?: #RBAC_EnforcementType
}
