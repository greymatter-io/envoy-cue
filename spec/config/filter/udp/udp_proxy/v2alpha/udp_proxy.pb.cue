package v2alpha

// Configuration for the UDP proxy filter.
#UdpProxyConfig: {
	"@type": "type.googleapis.com/envoy.config.filter.udp.udp_proxy.v2alpha.UdpProxyConfig"
	// The stat prefix used when emitting UDP proxy filter stats.
	stat_prefix?: string
	// The upstream cluster to connect to.
	cluster?: string
	// The idle timeout for sessions. Idle is defined as no datagrams between received or sent by
	// the session. The default if not specified is 1 minute.
	idle_timeout?: string
}
