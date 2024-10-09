package v1alpha1

#MySQLProxy: {
	"@type": "type.googleapis.com/envoy.config.filter.network.mysql_proxy.v1alpha1.MySQLProxy"
	// The human readable prefix to use when emitting :ref:`statistics
	// <config_network_filters_mysql_proxy_stats>`.
	stat_prefix?: string
	// [#not-implemented-hide:] The optional path to use for writing MySQL access logs.
	// If the access log field is empty, access logs will not be written.
	access_log?: string
}
