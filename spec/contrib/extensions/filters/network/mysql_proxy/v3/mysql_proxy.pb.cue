package v3

// Downstream SSL operational modes.
#MySQLProxy_SSLMode: "DISABLE" | "REQUIRE" | "ALLOW"

MySQLProxy_SSLMode_DISABLE: "DISABLE"
MySQLProxy_SSLMode_REQUIRE: "REQUIRE"
MySQLProxy_SSLMode_ALLOW:   "ALLOW"

#MySQLProxy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.mysql_proxy.v3.MySQLProxy"
	// The human readable prefix to use when emitting :ref:`statistics
	// <config_network_filters_mysql_proxy_stats>`.
	stat_prefix?: string
	// [#not-implemented-hide:] The optional path to use for writing MySQL access logs.
	// If the access log field is empty, access logs will not be written.
	access_log?: string
	// Controls whether to terminate SSL sessions initiated by downstream clients.
	// If enabled, the filter chain must use
	// :ref:`starttls transport socket <envoy_v3_api_msg_extensions.transport_sockets.starttls.v3.StartTlsConfig>`.
	// Defaults to “DISABLE“.
	downstream_ssl?: #MySQLProxy_SSLMode
}
