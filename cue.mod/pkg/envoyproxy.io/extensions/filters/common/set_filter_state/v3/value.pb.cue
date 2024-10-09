package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#FilterStateValue_SharedWithUpstream: "NONE" | "ONCE" | "TRANSITIVE"

FilterStateValue_SharedWithUpstream_NONE:       "NONE"
FilterStateValue_SharedWithUpstream_ONCE:       "ONCE"
FilterStateValue_SharedWithUpstream_TRANSITIVE: "TRANSITIVE"

// A filter state key and value pair.
// [#next-free-field: 7]
#FilterStateValue: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.set_filter_state.v3.FilterStateValue"
	// Filter state object key. The key is used to lookup the object factory, unless :ref:`factory_key
	// <envoy_v3_api_field_extensions.filters.common.set_filter_state.v3.FilterStateValue.factory_key>` is set. See
	// :ref:`the well-known filter state keys <well_known_filter_state>` for a list of valid object keys.
	object_key?: string
	// Optional filter object factory lookup key. See :ref:`the well-known filter state keys <well_known_filter_state>`
	// for a list of valid factory keys.
	factory_key?: string
	// Uses the :ref:`format string <config_access_log_format_strings>` to
	// instantiate the filter state object value.
	format_string?: v3.#SubstitutionFormatString
	// If marked as read-only, the filter state key value is locked, and cannot
	// be overridden by any filter, including this filter.
	read_only?: bool
	// Configures the object to be shared with the upstream internal connections. See :ref:`internal upstream
	// transport <config_internal_upstream_transport>` for more details on the filter state sharing with
	// the internal connections.
	shared_with_upstream?: #FilterStateValue_SharedWithUpstream
	// Skip the update if the value evaluates to an empty string.
	// This option can be used to supply multiple alternatives for the same filter state object key.
	skip_if_empty?: bool
}
