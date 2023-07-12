package v3

#ProxyProtocolConfig_Version: "V1" | "V2"

ProxyProtocolConfig_Version_V1: "V1"
ProxyProtocolConfig_Version_V2: "V2"

#ProxyProtocolConfig: {
	"@type": "type.googleapis.com/envoy.config.core.v3.ProxyProtocolConfig"
	// The PROXY protocol version to use. See https://www.haproxy.org/download/2.1/doc/proxy-protocol.txt for details
	version?: #ProxyProtocolConfig_Version
}
