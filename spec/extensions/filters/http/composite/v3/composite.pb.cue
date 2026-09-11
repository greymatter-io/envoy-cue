package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/type/matcher/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// :ref:`Composite filter <config_http_filters_composite>` config. The composite filter config
// allows delegating filter handling to another filter as determined by matching on the request
// headers. This makes it possible to use different filters or filter configurations based on the
// incoming request.
//
// This is intended to be used with
// :ref:`ExtensionWithMatcher <envoy_v3_api_msg_extensions.common.matching.v3.ExtensionWithMatcher>`
// where a match tree is specified that indicates (via
// :ref:`ExecuteFilterAction <envoy_v3_api_msg_extensions.filters.http.composite.v3.ExecuteFilterAction>`)
// which filter configuration to create and delegate to.
#Composite: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.composite.v3.Composite"
	// Named filter chain definitions that can be referenced from
	// :ref:`ExecuteFilterAction.filter_chain_name
	// <envoy_v3_api_field_extensions.filters.http.composite.v3.ExecuteFilterAction.filter_chain_name>`.
	// The filter chains are compiled at configuration time and can be referenced by name.
	// This is useful when the same filter chain needs to be applied across many routes,
	// as it avoids duplicating the filter chain configuration.
	named_filter_chains?: [string]: #FilterChainConfiguration
	// The match tree that will be used to select an action to execute. The action type should be
	// :ref:`ExecuteFilterAction
	// <envoy_v3_api_msg_extensions.filters.http.composite.v3.ExecuteFilterAction>`.
	//
	// .. warning::
	//
	//	This should only be set when using the Composite filter as in the :ref:`http_filters
	//	<envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.http_filters>`.
	//	Never set this field when using the Composite filter with the :ref:`ExtensionWithMatcher
	//	<envoy_v3_api_msg_extensions.common.matching.v3.ExtensionWithMatcher>` which will result in
	//	undefined behavior.
	matcher?: v3.#Matcher
}

// Per-route configuration for the Composite filter.
#CompositePerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.composite.v3.CompositePerRoute"
	// Override of the match tree for this route.
	//
	// .. warning::
	//
	//	This should only be set when using the Composite filter as in the :ref:`http_filters
	//	<envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.http_filters>`.
	//	Never set this field when using the Composite filter with the :ref:`ExtensionWithMatcher
	//	<envoy_v3_api_msg_extensions.common.matching.v3.ExtensionWithMatcher>` which will result in
	//	undefined behavior.
	matcher?: v3.#Matcher
}

// A list of filter configurations to be called in order. Note that this can be used as the type
// inside of an ECDS :ref:`TypedExtensionConfig
// <envoy_v3_api_msg_config.core.v3.TypedExtensionConfig>` extension, which allows a chain of
// filters to be configured dynamically. In that case, the types of all filters in the chain must
// be present in the :ref:`ExtensionConfigSource.type_urls
// <envoy_v3_api_field_config.core.v3.ExtensionConfigSource.type_urls>` field.
#FilterChainConfiguration: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.composite.v3.FilterChainConfiguration"
	typed_config?: [...v31.#TypedExtensionConfig]
}

// Configuration for an extension configuration discovery service with name.
#DynamicConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.composite.v3.DynamicConfig"
	// The name of the extension configuration. It also serves as a resource name in ExtensionConfigDS.
	// The resource type in the “DiscoveryRequest“ will be :ref:`TypedExtensionConfig
	// <envoy_v3_api_msg_config.core.v3.TypedExtensionConfig>`.
	name?: string
	// Configuration source specifier for an extension configuration discovery
	// service. In case of a failure and without the default configuration,
	// 500(Internal Server Error) will be returned.
	config_discovery?: v31.#ExtensionConfigSource
}

// Composite match action (see :ref:`matching docs <arch_overview_matching_api>` for more info on match actions).
// This specifies the filter configuration of the filter that the composite filter should delegate filter interactions to.
// [#next-free-field: 6]
#ExecuteFilterAction: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.composite.v3.ExecuteFilterAction"
	// Filter specific configuration which depends on the filter being
	// instantiated. See the supported filters for further documentation.
	// Only one of “typed_config“, “dynamic_config“, “filter_chain“, or “filter_chain_name“
	// can be set.
	// [#extension-category: envoy.filters.http]
	typed_config?: v31.#TypedExtensionConfig
	// Dynamic configuration of filter obtained via extension configuration discovery service.
	// Only one of “typed_config“, “dynamic_config“, “filter_chain“, or “filter_chain_name“
	// can be set.
	dynamic_config?: #DynamicConfig
	// An inlined list of filter configurations. The specified filters will be executed in order.
	// Only one of “typed_config“, “dynamic_config“, “filter_chain“, or “filter_chain_name“
	// can be set.
	filter_chain?: #FilterChainConfiguration
	// The name of a filter chain defined in
	// :ref:`Composite.named_filter_chains
	// <envoy_v3_api_field_extensions.filters.http.composite.v3.Composite.named_filter_chains>`.
	// At runtime, if the named filter chain is not found in the Composite filter's configuration,
	// no filter will be applied for this match (the action is silently skipped).
	// Only one of “typed_config“, “dynamic_config“, “filter_chain“, or “filter_chain_name“
	// can be set.
	filter_chain_name?: string
	// Probability of the action execution. If not specified, this is 100%.
	// This allows sampling behavior for the configured actions.
	// For example, if
	// :ref:`default_value <envoy_v3_api_field_config.core.v3.RuntimeFractionalPercent.default_value>`
	// under the “sample_percent“ is configured with 30%, a dice roll with that
	// probability is done. The underline action will only be executed if the
	// dice roll returns positive. Otherwise, the action is skipped.
	sample_percent?: v31.#RuntimeFractionalPercent
}
