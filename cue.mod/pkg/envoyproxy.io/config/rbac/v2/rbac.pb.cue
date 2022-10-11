package v2

import (
	core "envoyproxy.io/api/v2/core"
	matcher "envoyproxy.io/type/matcher"
	route "envoyproxy.io/api/v2/route"
	v1alpha1 "envoyproxy.io/deps/genproto/googleapis/api/expr/v1alpha1"
)

// Should we do safe-list or block-list style access control?
#RBAC_Action: "ALLOW" | "DENY"

RBAC_Action_ALLOW: "ALLOW"
RBAC_Action_DENY:  "DENY"

// Role Based Access Control (RBAC) provides service-level and method-level access control for a
// service. RBAC policies are additive. The policies are examined in order. A request is allowed
// once a matching policy is found (suppose the `action` is ALLOW).
//
// Here is an example of RBAC configuration. It has two policies:
//
// * Service account "cluster.local/ns/default/sa/admin" has full access to the service, and so
//   does "cluster.local/ns/default/sa/superuser".
//
// * Any user can read ("GET") the service at paths with prefix "/products", so long as the
//   destination port is either 80 or 443.
//
//  .. code-block:: yaml
//
//   action: ALLOW
//   policies:
//     "service-admin":
//       permissions:
//         - any: true
//       principals:
//         - authenticated:
//             principal_name:
//               exact: "cluster.local/ns/default/sa/admin"
//         - authenticated:
//             principal_name:
//               exact: "cluster.local/ns/default/sa/superuser"
//     "product-viewer":
//       permissions:
//           - and_rules:
//               rules:
//                 - header: { name: ":method", exact_match: "GET" }
//                 - url_path:
//                     path: { prefix: "/products" }
//                 - or_rules:
//                     rules:
//                       - destination_port: 80
//                       - destination_port: 443
//       principals:
//         - any: true
//
#RBAC: {
	"@type": "type.googleapis.com/envoy.config.rbac.v2.RBAC"
	// The action to take if a policy matches. The request is allowed if and only if:
	//
	//   * `action` is "ALLOWED" and at least one policy matches
	//   * `action` is "DENY" and none of the policies match
	action?: #RBAC_Action
	// Maps from policy name to policy. A match occurs when at least one policy matches the request.
	policies?: [string]: #Policy
}

// Policy specifies a role and the principals that are assigned/denied the role. A policy matches if
// and only if at least one of its permissions match the action taking place AND at least one of its
// principals match the downstream AND the condition is true if specified.
#Policy: {
	"@type": "type.googleapis.com/envoy.config.rbac.v2.Policy"
	// Required. The set of permissions that define a role. Each permission is matched with OR
	// semantics. To match all actions for this policy, a single Permission with the `any` field set
	// to true should be used.
	permissions?: [...#Permission]
	// Required. The set of principals that are assigned/denied the role based on “action”. Each
	// principal is matched with OR semantics. To match all downstreams for this policy, a single
	// Principal with the `any` field set to true should be used.
	principals?: [...#Principal]
	// An optional symbolic expression specifying an access control
	// :ref:`condition <arch_overview_condition>`. The condition is combined
	// with the permissions and the principals as a clause with AND semantics.
	condition?: v1alpha1.#Expr
}

// Permission defines an action (or actions) that a principal can take.
// [#next-free-field: 11]
#Permission: {
	"@type": "type.googleapis.com/envoy.config.rbac.v2.Permission"
	// A set of rules that all must match in order to define the action.
	and_rules?: #Permission_Set
	// A set of rules where at least one must match in order to define the action.
	or_rules?: #Permission_Set
	// When any is set, it matches any action.
	any?: bool
	// A header (or pseudo-header such as :path or :method) on the incoming HTTP request. Only
	// available for HTTP request.
	// Note: the pseudo-header :path includes the query and fragment string. Use the `url_path`
	// field if you want to match the URL path without the query and fragment string.
	header?: route.#HeaderMatcher
	// A URL path on the incoming HTTP request. Only available for HTTP.
	url_path?: matcher.#PathMatcher
	// A CIDR block that describes the destination IP.
	destination_ip?: core.#CidrRange
	// A port number that describes the destination port connecting to.
	destination_port?: uint32
	// Metadata that describes additional information about the action.
	metadata?: matcher.#MetadataMatcher
	// Negates matching the provided permission. For instance, if the value of `not_rule` would
	// match, this permission would not match. Conversely, if the value of `not_rule` would not
	// match, this permission would match.
	not_rule?: #Permission
	// The request server from the client's connection request. This is
	// typically TLS SNI.
	//
	// .. attention::
	//
	//   The behavior of this field may be affected by how Envoy is configured
	//   as explained below.
	//
	//   * If the :ref:`TLS Inspector <config_listener_filters_tls_inspector>`
	//     filter is not added, and if a `FilterChainMatch` is not defined for
	//     the :ref:`server name <envoy_api_field_listener.FilterChainMatch.server_names>`,
	//     a TLS connection's requested SNI server name will be treated as if it
	//     wasn't present.
	//
	//   * A :ref:`listener filter <arch_overview_listener_filters>` may
	//     overwrite a connection's requested server name within Envoy.
	//
	// Please refer to :ref:`this FAQ entry <faq_how_to_setup_sni>` to learn to
	// setup SNI.
	requested_server_name?: matcher.#StringMatcher
}

// Principal defines an identity or a group of identities for a downstream subject.
// [#next-free-field: 12]
#Principal: {
	"@type": "type.googleapis.com/envoy.config.rbac.v2.Principal"
	// A set of identifiers that all must match in order to define the downstream.
	and_ids?: #Principal_Set
	// A set of identifiers at least one must match in order to define the downstream.
	or_ids?: #Principal_Set
	// When any is set, it matches any downstream.
	any?: bool
	// Authenticated attributes that identify the downstream.
	authenticated?: #Principal_Authenticated
	// A CIDR block that describes the downstream IP.
	// This address will honor proxy protocol, but will not honor XFF.
	//
	// Deprecated: Do not use.
	source_ip?: core.#CidrRange
	// A CIDR block that describes the downstream remote/origin address.
	// Note: This is always the physical peer even if the
	// :ref:`remote_ip <envoy_api_field_config.rbac.v2.Principal.remote_ip>` is inferred
	// from for example the x-forwarder-for header, proxy protocol, etc.
	direct_remote_ip?: core.#CidrRange
	// A CIDR block that describes the downstream remote/origin address.
	// Note: This may not be the physical peer and could be different from the
	// :ref:`direct_remote_ip <envoy_api_field_config.rbac.v2.Principal.direct_remote_ip>`.
	// E.g, if the remote ip is inferred from for example the x-forwarder-for header,
	// proxy protocol, etc.
	remote_ip?: core.#CidrRange
	// A header (or pseudo-header such as :path or :method) on the incoming HTTP request. Only
	// available for HTTP request.
	// Note: the pseudo-header :path includes the query and fragment string. Use the `url_path`
	// field if you want to match the URL path without the query and fragment string.
	header?: route.#HeaderMatcher
	// A URL path on the incoming HTTP request. Only available for HTTP.
	url_path?: matcher.#PathMatcher
	// Metadata that describes additional information about the principal.
	metadata?: matcher.#MetadataMatcher
	// Negates matching the provided principal. For instance, if the value of `not_id` would match,
	// this principal would not match. Conversely, if the value of `not_id` would not match, this
	// principal would match.
	not_id?: #Principal
}

// Used in the `and_rules` and `or_rules` fields in the `rule` oneof. Depending on the context,
// each are applied with the associated behavior.
#Permission_Set: {
	"@type": "type.googleapis.com/envoy.config.rbac.v2.Permission_Set"
	rules?: [...#Permission]
}

// Used in the `and_ids` and `or_ids` fields in the `identifier` oneof. Depending on the context,
// each are applied with the associated behavior.
#Principal_Set: {
	"@type": "type.googleapis.com/envoy.config.rbac.v2.Principal_Set"
	ids?: [...#Principal]
}

// Authentication attributes for a downstream.
#Principal_Authenticated: {
	"@type": "type.googleapis.com/envoy.config.rbac.v2.Principal_Authenticated"
	// The name of the principal. If set, The URI SAN or DNS SAN in that order is used from the
	// certificate, otherwise the subject field is used. If unset, it applies to any user that is
	// authenticated.
	principal_name?: matcher.#StringMatcher
}
