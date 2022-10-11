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

// Composite match action (see :ref:`matching docs <arch_overview_matching_api>` for more info on match actions).
// This specifies the filter configuration of the filter that the composite filter should delegate filter interactions to.
#ExecuteFilterAction: {
	"@type":       "type.googleapis.com/envoy.extensions.filters.http.composite.v3.ExecuteFilterAction"
	typed_config?: v3.#TypedExtensionConfig
}
