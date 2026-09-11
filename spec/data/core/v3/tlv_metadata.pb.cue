package v3

#TlvsMetadata: {
	"@type": "type.googleapis.com/envoy.data.core.v3.TlvsMetadata"
	// Typed metadata for :ref:`Proxy protocol filter <envoy_v3_api_msg_extensions.filters.listener.proxy_protocol.v3.ProxyProtocol>`, that represents a map of TLVs.
	// Each entry in the map consists of a key which corresponds to a configured
	// :ref:`rule key <envoy_v3_api_field_extensions.filters.listener.proxy_protocol.v3.ProxyProtocol.KeyValuePair.key>` and a value (TLV value in bytes).
	// :ref:`Proxy protocol filter <envoy_v3_api_msg_extensions.filters.listener.proxy_protocol.v3.ProxyProtocol>`
	// populates both typed and untyped metadata.
	typed_metadata?: [string]: bytes
}
