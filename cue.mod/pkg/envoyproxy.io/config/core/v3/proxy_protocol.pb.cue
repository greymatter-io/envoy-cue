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

#ProxyProtocolConfig: {
	"@type": "type.googleapis.com/envoy.config.core.v3.ProxyProtocolConfig"
	// The PROXY protocol version to use. See https://www.haproxy.org/download/2.1/doc/proxy-protocol.txt for details
	version?: #ProxyProtocolConfig_Version
	// This config controls which TLVs can be passed to upstream if it is Proxy Protocol
	// V2 header. If there is no setting for this field, no TLVs will be passed through.
	pass_through_tlvs?: #ProxyProtocolPassThroughTLVs
}
