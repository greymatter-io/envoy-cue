package v3

#ProxyProtocolPassThroughTLVs_PassTLVsMatchType: "INCLUDE_ALL" | "INCLUDE"

ProxyProtocolPassThroughTLVs_PassTLVsMatchType_INCLUDE_ALL: "INCLUDE_ALL"
ProxyProtocolPassThroughTLVs_PassTLVsMatchType_INCLUDE:     "INCLUDE"

#ProxyProtocolConfig_Version: "V1" | "V2"

ProxyProtocolConfig_Version_V1: "V1"
ProxyProtocolConfig_Version_V2: "V2"

#ProxyProtocolPassThroughTLVs: {
	"@type": "type.googleapis.com/envoy.config.core.v3.ProxyProtocolPassThroughTLVs"
	// The strategy to pass through TLVs. Default is INCLUDE_ALL.
	// If INCLUDE_ALL is set, all TLVs will be passed through no matter the tlv_type field.
	match_type?: #ProxyProtocolPassThroughTLVs_PassTLVsMatchType
	// The TLV types that are applied based on match_type.
	// TLV type is defined as uint8_t in proxy protocol. See `the spec
	// <https://www.haproxy.org/download/2.1/doc/proxy-protocol.txt>`_ for details.
	tlv_type?: [...uint32]
}

// Represents a single Type-Length-Value (TLV) entry.
#TlvEntry: {
	"@type": "type.googleapis.com/envoy.config.core.v3.TlvEntry"
	// The type of the TLV. Must be a uint8 (0-255) as per the Proxy Protocol v2 specification.
	type?: uint32
	// The static value of the TLV.
	// Only one of “value“ or “format_string“ may be set.
	value?: bytes
	// Uses the :ref:`format string <config_access_log_format_strings>` to dynamically
	// populate the TLV value from stream information. This allows dynamic values
	// such as metadata, filter state, or other stream properties to be included in
	// the TLV.
	//
	// For example:
	//
	// .. code-block:: yaml
	//
	//	type: 0xF0
	//	format_string:
	//	  text_format_source:
	//	    inline_string: "%DYNAMIC_METADATA(envoy.filters.network:key)%"
	//
	// The formatted string will be used directly as the TLV value.
	// Only one of “value“ or “format_string“ may be set.
	format_string?: #SubstitutionFormatString
}

#ProxyProtocolConfig: {
	"@type": "type.googleapis.com/envoy.config.core.v3.ProxyProtocolConfig"
	// The PROXY protocol version to use. See https://www.haproxy.org/download/2.1/doc/proxy-protocol.txt for details
	version?: #ProxyProtocolConfig_Version
	// This config controls which TLVs can be passed to upstream if it is Proxy Protocol
	// V2 header. If there is no setting for this field, no TLVs will be passed through.
	pass_through_tlvs?: #ProxyProtocolPassThroughTLVs
	// This config allows additional TLVs to be included in the upstream PROXY protocol
	// V2 header. Unlike “pass_through_tlvs“, which passes TLVs from the downstream request,
	// “added_tlvs“ provides an extension mechanism for defining new TLVs that are included
	// with the upstream request. These TLVs may not be present in the downstream request and
	// can be defined at either the transport socket level or the host level to provide more
	// granular control over the TLVs that are included in the upstream request.
	//
	// Host-level TLVs are specified in the “metadata.typed_filter_metadata“ field under the
	// “envoy.transport_sockets.proxy_protocol“ namespace.
	//
	// .. literalinclude:: /_configs/repo/proxy_protocol.yaml
	//
	//	:language: yaml
	//	:lines: 49-57
	//	:linenos:
	//	:lineno-start: 49
	//	:caption: :download:`proxy_protocol.yaml </_configs/repo/proxy_protocol.yaml>`
	//
	// **Precedence behavior**:
	//
	//   - When a TLV is defined at both the host level and the transport socket level, the value
	//     from the host level configuration takes precedence. This allows users to define default TLVs
	//     at the transport socket level and override them at the host level.
	//   - Any TLV defined in the “pass_through_tlvs“ field will be overridden by either the host-level
	//     or transport socket-level TLV.
	//
	// If there are multiple TLVs with the same type, only the TLVs from the highest precedence level
	// will be used.
	added_tlvs?: [...#TlvEntry]
}

#PerHostConfig: {
	"@type": "type.googleapis.com/envoy.config.core.v3.PerHostConfig"
	// Enables per-host configuration for Proxy Protocol.
	added_tlvs?: [...#TlvEntry]
}
