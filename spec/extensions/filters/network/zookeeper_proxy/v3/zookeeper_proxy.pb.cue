package v3

#ZooKeeperProxy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.zookeeper_proxy.v3.ZooKeeperProxy"
	// The human readable prefix to use when emitting :ref:`statistics
	// <config_network_filters_zookeeper_proxy_stats>`.
	stat_prefix?: string
	// [#not-implemented-hide:] The optional path to use for writing ZooKeeper access logs.
	// If the access log field is empty, access logs will not be written.
	access_log?: string
	// Messages — requests, responses and events — that are bigger than this value will
	// be ignored. If it is not set, the default value is 1Mb.
	//
	// The value here should match the jute.maxbuffer property in your cluster configuration:
	//
	// https://zookeeper.apache.org/doc/r3.4.10/zookeeperAdmin.html#Unsafe+Options
	//
	// if that is set. If it isn't, ZooKeeper's default is also 1Mb.
	max_packet_bytes?: uint32
}
