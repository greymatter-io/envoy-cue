package v3

#TlvsMetadata: {
	"@type": "type.googleapis.com/envoy.data.core.v3.TlvsMetadata"
	// Typed metadata for :ref:`Proxy protocol filter <envoy_v3_api_msg_extensions.filters.listener.proxy_protocol.v3.ProxyProtocol>`, that represents a map of TLVs.
	// Each entry in the map consists of a key which corresponds to a configured
	// :ref:`rule key <envoy_v3_api_field_extensions.filters.listener.proxy_protocol.v3.ProxyProtocol.KeyValuePair.key>` and a value (TLV value in bytes).
	// When runtime flag “envoy.reloadable_features.use_typed_metadata_in_proxy_protocol_listener“ is enabled,
	// :ref:`Proxy protocol filter <envoy_v3_api_msg_extensions.filters.listener.proxy_protocol.v3.ProxyProtocol>`
	// will populate typed metadata and regular metadata. By default filter will populate typed and untyped metadata.
	typed_metadata?: [string]: [...byte]
}
