package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#FilterStateValue_SharedWithUpstream: "NONE" | "ONCE" | "TRANSITIVE"

FilterStateValue_SharedWithUpstream_NONE:       "NONE"
FilterStateValue_SharedWithUpstream_ONCE:       "ONCE"
FilterStateValue_SharedWithUpstream_TRANSITIVE: "TRANSITIVE"

// A filter state key and value pair.
// [#next-free-field: 7]
#FilterStateValue: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.set_filter_state.v3.FilterStateValue"
	// The name under which the filter state object will be stored and can be retrieved.
	//
	// When using :ref:`well-known filter state keys <well_known_filter_state>` (e.g.,
	// “envoy.network.upstream_server_name“, “envoy.tcp_proxy.cluster“), the object key serves
	// dual purpose where it identifies both where the data is stored and which factory creates the
	// object. In this case, :ref:`factory_key
	// <envoy_v3_api_field_extensions.filters.common.set_filter_state.v3.FilterStateValue.factory_key>`
	// is not needed.
	//
	// When using a custom key name which is not from the well-known list, you must also specify
	// :ref:`factory_key
	// <envoy_v3_api_field_extensions.filters.common.set_filter_state.v3.FilterStateValue.factory_key>`
	// to indicate which factory should create the object from your value.
	//
	// Example using a well-known key where “factory_key“ is not needed:
	//
	// .. code-block:: yaml
	//
	//	object_key: envoy.tcp_proxy.cluster
	//	format_string:
	//	  text_format_source:
	//	    inline_string: "my-cluster"
	//
	// Example using a custom key which requires a “factory_key“:
	//
	// .. code-block:: yaml
	//
	//	object_key: my.custom.key
	//	factory_key: envoy.string
	//	format_string:
	//	  text_format_source:
	//	    inline_string: "my-value"
	object_key?: string
	// Specifies which registered factory should be used to create the filter state object from the
	// provided value. This field is required when :ref:`object_key
	// <envoy_v3_api_field_extensions.filters.common.set_filter_state.v3.FilterStateValue.object_key>`
	// is a custom name not found in the :ref:`well-known filter state keys <well_known_filter_state>`.
	//
	// Each well-known key has a factory registered with the same name (e.g., the key
	// “envoy.tcp_proxy.cluster“ has a factory also named “envoy.tcp_proxy.cluster“). For custom keys,
	// use one of the following generic factories:
	//
	//   - “envoy.string“: Creates a generic string object. Use this for arbitrary string values that
	//     will be accessed via “StringAccessor“.
	//
	// If not specified, defaults to the value of “object_key“.
	factory_key?: string
	// Uses the :ref:`format string <config_access_log_format_strings>` to
	// instantiate the filter state object value.
	format_string?: v3.#SubstitutionFormatString
	// This field is deprecated and its value has no effect.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/filters/common/set_filter_state/v3/value.proto.
	read_only?: bool
	// Configures the object to be shared with the upstream internal connections. See :ref:`internal upstream
	// transport <config_internal_upstream_transport>` for more details on the filter state sharing with
	// the internal connections.
	shared_with_upstream?: #FilterStateValue_SharedWithUpstream
	// Skip the update if the value evaluates to an empty string.
	// This option can be used to supply multiple alternatives for the same filter state object key.
	skip_if_empty?: bool
}
