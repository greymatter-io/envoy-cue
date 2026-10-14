package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/route/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v32 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
	v33 "envoyproxy.io/envoy-cue/spec/extensions/dynamic_modules/v3"
)

// What Envoy does when the decision of the module cannot be honored.
//
// This covers a module that reports an error, which is what the SDK does when the module panics,
// a decision or a status Envoy does not know, a template selection that names an identifier that
// is not declared, a template whose “match“ does not hold for the request, an override recorded
// without a template while route matching resolved no route, route entry overrides recorded for a
// direct response, and route metadata a typed metadata factory rejects.
#FailurePolicy: "FAILURE_POLICY_UNSPECIFIED" | "PASS_THROUGH" | "NO_ROUTE" | "CONTINUE_MATCHING"

FailurePolicy_FAILURE_POLICY_UNSPECIFIED: "FAILURE_POLICY_UNSPECIFIED"
FailurePolicy_PASS_THROUGH:               "PASS_THROUGH"
FailurePolicy_NO_ROUTE:                   "NO_ROUTE"
FailurePolicy_CONTINUE_MATCHING:          "CONTINUE_MATCHING"

// A named route the module may select for a request.
//
// A template is built and validated once, when the specifier is configured, so an invalid template
// is rejected at configuration load. It inherits from the virtual host and the route configuration
// the specifier is configured on, exactly like a configured route does. When the module selects a
// template, Envoy evaluates it against the request like a configured route: the
// :ref:`match <envoy_v3_api_field_config.route.v3.Route.match>` must hold, otherwise the
// “failure_policy“ applies, and the action is resolved the usual way, including
// :ref:`weighted_clusters <envoy_v3_api_field_config.route.v3.RouteAction.weighted_clusters>` and
// :ref:`cluster specifier plugins
// <envoy_v3_api_field_config.route.v3.RouteAction.cluster_specifier_plugin>`.
#RouteTemplate: {
	"@type": "type.googleapis.com/envoy.extensions.router.route_specifiers.dynamic_modules.v3.RouteTemplate"
	// The identifier the module selects this template with. Must be unique within the specifier.
	template_id?: string
	// The route. ``route_specifiers`` must be empty, since a template is not run through the
	// specifier chains.
	route?: v3.#Route
}

// Route properties the module may select for a request.
//
// These properties are built from other extensions, so they are declared here and built once at
// configuration load rather than constructed on the request path. An entry that replaces no
// property is rejected. A property an entry leaves unset keeps the value of the route the decision
// produced, so an entry can never remove a property that route configures.
// [#next-free-field: 12]
#RouteOverride: {
	"@type": "type.googleapis.com/envoy.extensions.router.route_specifiers.dynamic_modules.v3.RouteOverride"
	// The identifier the module selects this override with. Must be unique within the specifier.
	override_id?: string
	// Retry policy replacing the retry policy of the produced route.
	retry_policy?: v3.#RetryPolicy
	// Metadata match criteria replacing those of the produced route, used by subset load balancing.
	// Only the ``envoy.lb`` entry of :ref:`filter_metadata
	// <envoy_v3_api_field_config.core.v3.Metadata.filter_metadata>` is used, matching the behavior of
	// :ref:`RouteAction.metadata_match
	// <envoy_v3_api_field_config.route.v3.RouteAction.metadata_match>`. An entry whose only property
	// is a ``metadata_match`` without an ``envoy.lb`` entry replaces nothing and is rejected.
	metadata_match?: v31.#Metadata
	// Request mirroring policies replacing those of the produced route. Statically named mirror
	// clusters are checked against the cluster manager when ``validate_clusters`` is enabled.
	request_mirror_policies?: [...v3.#RouteAction_RequestMirrorPolicy]
	// Hash policy replacing the hash policy of the produced route, used when the upstream cluster
	// employs a hashing load balancer. A cluster level and a load balancer level hash policy, when
	// configured, take precedence over this route level policy.
	hash_policy?: [...v3.#RouteAction_HashPolicy]
	// Hedge policy replacing the hedge policy of the produced route.
	hedge_policy?: v3.#HedgePolicy
	// Rate limits replacing the rate limits of the produced route.
	rate_limits?: [...v3.#RateLimit]
	// CORS policy replacing the CORS policy of the produced route. The CORS filter reads it only when
	// CORS is not configured through per filter configuration.
	cors?: v3.#CorsPolicy
	// Regex rewrite of the request path, replacing the path the produced route sends upstream,
	// unless the module records a path of its own, which wins. The
	// pattern is compiled once when the specifier is configured. It applies to the path without the
	// query string, which is preserved, and the result is capped at
	// :ref:`max_rewritten_path_bytes
	// <envoy_v3_api_field_extensions.router.route_specifiers.dynamic_modules.v3.DynamicModuleRouteSpecifier.max_rewritten_path_bytes>`.
	regex_rewrite?: v32.#RegexMatchAndSubstitute
	// Tracing configuration replacing the tracing settings of the produced route, overriding the
	// connection manager defaults for the request. This is a route level property, so it applies to
	// a direct response or a redirect route as well as a route entry.
	tracing?: v3.#Tracing
	// Metadata layered onto the metadata of the produced route, per namespace, so consumers such as
	// the rate limit ROUTE_ENTRY action, ext_authz and the METADATA(ROUTE) formatter observe it.
	// Metadata the module records itself layers on top of it. It is a route level property. An
	// empty message layers nothing.
	metadata?: v31.#Metadata
}

// Configuration for the dynamic modules route specifier.
// [#next-free-field: 12]
#DynamicModuleRouteSpecifier: {
	"@type": "type.googleapis.com/envoy.extensions.router.route_specifiers.dynamic_modules.v3.DynamicModuleRouteSpecifier"
	// Specifies the shared object level configuration. This field is required.
	//
	// .. note::
	//   This extension loads the module while the route configuration is built, so it cannot wait
	//   for an asynchronous fetch. A remote :ref:`module
	//   <envoy_v3_api_field_extensions.dynamic_modules.v3.DynamicModuleConfig.module>` is therefore
	//   accepted only when the module is already cached on disk, and is otherwise rejected. Setting
	//   :ref:`nack_on_cache_miss
	//   <envoy_v3_api_field_extensions.dynamic_modules.v3.DynamicModuleConfig.nack_on_cache_miss>` to
	//   ``true`` makes the rejection start a background fetch so that a later update succeeds. Prefer
	//   ``name`` or a local data source.
	dynamic_module_config?: v33.#DynamicModuleConfig
	// The name for this route specifier configuration, used to select an implementation within the
	// module. If not specified, defaults to an empty string.
	specifier_name?: string
	// The configuration for the route specifier chosen by ``specifier_name``. If not specified,
	// defaults to an empty configuration.
	specifier_config?: _
	// Prefix for the statistics of this specifier, emitted as
	// ``<metrics_namespace>.route_specifier.<stat_prefix>.*``, where ``metrics_namespace`` is the
	// :ref:`metrics_namespace
	// <envoy_v3_api_field_extensions.dynamic_modules.v3.DynamicModuleConfig.metrics_namespace>`
	// of the module. Specifiers that share a metrics namespace and prefix share counters, so keep
	// the prefix unique within that namespace.
	stat_prefix?: string
	// The route templates the module may select by ``template_id``, each replacing the resolved
	// route with a route built from configuration. The ``template_id`` values must be unique.
	route_templates?: [...#RouteTemplate]
	// The route overrides the module may select by ``override_id``, each overlaying its properties
	// onto the produced route. The ``override_id`` values must be unique.
	route_overrides?: [...#RouteOverride]
	// Fraction of requests the module is invoked for. A request outside the fraction is passed
	// through untouched and counted in ``runtime_skipped``. The stable random value of the request is
	// used, so the choice holds when the route of a request is recomputed. If not specified,
	// defaults to every request.
	//
	// .. attention::
	//   A request outside the fraction is routed by ``routes`` or ``matcher`` alone, so a fraction
	//   below 100% is only safe, as a canary or as an emergency switch with the runtime key set to
	//   ``0``, while the route table the module replaces is still complete. Once that table has been
	//   shrunk, lowering the fraction turns the affected requests into 404s or routes them wrongly, and
	//   the way back is a route configuration rollback that restores the table.
	runtime_fraction?: v31.#RuntimeFractionalPercent
	// What Envoy does when the decision of the module cannot be honored. Must be set explicitly.
	failure_policy?: #FailurePolicy
	// Whether the clusters the route templates and the route overrides name are checked
	// against the cluster manager while the specifier is configured. If not specified, defaults to
	// ``false``, because the clusters a route names may be delivered after the route configuration
	// that references them. An unknown cluster then fails the request with the
	// ``cluster_not_found_response_code`` of the route instead.
	validate_clusters?: bool
	// The maximum length of a request path a module rewrite may produce, covering the full ``:path``
	// value including the query string. A rewrite whose result would exceed it is rejected. If not
	// specified, defaults to 65536.
	max_rewritten_path_bytes?: uint32
	// An opaque identifier the module reads with ``get_config_specifier_instance_id``, so that two
	// specifier instances sharing one module can tell the routes they build apart, for example by
	// writing it into the route metadata they mark their routes with. It is documentation and
	// convenience for the module and Envoy enforces nothing about it. If not specified, defaults to
	// an empty string.
	specifier_instance_id?: string
}
