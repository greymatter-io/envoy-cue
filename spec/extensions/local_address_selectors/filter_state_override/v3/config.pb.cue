package v3

// Overrides the upstream bind address Linux network namespace using a filter
// state object with the key “envoy.network.upstream_bind_override.network_namespace“
// passed from the downstream. The override applies over the :ref:`default
// address selector
// <extension_envoy.upstream.local_address_selector.default_local_address_selector>`
#Config: {
	"@type": "type.googleapis.com/envoy.extensions.local_address_selectors.filter_state_override.v3.Config"
}
