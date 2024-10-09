package v3

import (
	v3 "envoyproxy.io/config/core/v3"
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
}

// Configuration for an extension configuration discovery service with name.
#DynamicConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.composite.v3.DynamicConfig"
	// The name of the extension configuration. It also serves as a resource name in ExtensionConfigDS.
	name?: string
	// Configuration source specifier for an extension configuration discovery
	// service. In case of a failure and without the default configuration,
	// 500(Internal Server Error) will be returned.
	config_discovery?: v3.#ExtensionConfigSource
}

// Composite match action (see :ref:`matching docs <arch_overview_matching_api>` for more info on match actions).
// This specifies the filter configuration of the filter that the composite filter should delegate filter interactions to.
#ExecuteFilterAction: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.composite.v3.ExecuteFilterAction"
	// Filter specific configuration which depends on the filter being
	// instantiated. See the supported filters for further documentation.
	// Only one of “typed_config“ or “dynamic_config“ can be set.
	// [#extension-category: envoy.filters.http]
	typed_config?: v3.#TypedExtensionConfig
	// Dynamic configuration of filter obtained via extension configuration discovery service.
	// Only one of “typed_config“ or “dynamic_config“ can be set.
	dynamic_config?: #DynamicConfig
	// Probability of the action execution. If not specified, this is 100%.
	// This allows sampling behavior for the configured actions.
	// For example, if
	// :ref:`default_value <envoy_v3_api_field_config.core.v3.RuntimeFractionalPercent.default_value>`
	// under the “sample_percent“ is configured with 30%, a dice roll with that
	// probability is done. The underline action will only be executed if the
	// dice roll returns positive. Otherwise, the action is skipped.
	sample_percent?: v3.#RuntimeFractionalPercent
}
