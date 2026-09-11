package v3

#RocketmqProxy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.rocketmq_proxy.v3.RocketmqProxy"
	// The human readable prefix to use when emitting statistics.
	stat_prefix?: string
	// The route table for the connection manager is specified in this property.
	route_config?: #RouteConfiguration
	// The largest duration transient object expected to live, more than 10s is recommended.
	transient_object_life_span?: string
	// If develop_mode is enabled, this proxy plugin may work without dedicated traffic intercepting
	// facility without considering backward compatibility of exiting RocketMQ client SDK.
	develop_mode?: bool
}
