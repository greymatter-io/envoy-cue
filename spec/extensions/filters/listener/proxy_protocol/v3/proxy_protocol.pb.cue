package v3

#ProxyProtocol: {
	"@type": "type.googleapis.com/envoy.extensions.filters.listener.proxy_protocol.v3.ProxyProtocol"
	// The list of rules to apply to requests.
	rules?: [...#ProxyProtocol_Rule]
	// Allow requests through that don't use proxy protocol. Defaults to false.
	//
	// .. attention::
	//
	//   This breaks conformance with the specification.
	//   Only enable if ALL traffic to the listener comes from a trusted source.
	//   For more information on the security implications of this feature, see
	//   https://www.haproxy.org/download/2.1/doc/proxy-protocol.txt
	//
	// .. attention::
	//
	//   Requests of 12 or fewer bytes that match the proxy protocol v2 signature
	//   and requests of 6 or fewer bytes that match the proxy protocol v1
	//   signature will timeout (Envoy is unable to differentiate these requests
	//   from incomplete proxy protocol requests).
	allow_requests_without_proxy_protocol?: bool
}

#ProxyProtocol_KeyValuePair: {
	"@type": "type.googleapis.com/envoy.extensions.filters.listener.proxy_protocol.v3.ProxyProtocol_KeyValuePair"
	// The namespace — if this is empty, the filter's namespace will be used.
	metadata_namespace?: string
	// The key to use within the namespace.
	key?: string
}

// A Rule defines what metadata to apply when a header is present or missing.
#ProxyProtocol_Rule: {
	"@type": "type.googleapis.com/envoy.extensions.filters.listener.proxy_protocol.v3.ProxyProtocol_Rule"
	// The type that triggers the rule - required
	// TLV type is defined as uint8_t in proxy protocol. See `the spec
	// <https://www.haproxy.org/download/2.1/doc/proxy-protocol.txt>`_ for details.
	tlv_type?: uint32
	// If the TLV type is present, apply this metadata KeyValuePair.
	on_tlv_present?: #ProxyProtocol_KeyValuePair
}
