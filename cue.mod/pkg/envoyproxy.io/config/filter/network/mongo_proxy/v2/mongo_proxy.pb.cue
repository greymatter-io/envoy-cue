package v2

import (
	v2 "envoyproxy.io/config/filter/fault/v2"
)

#MongoProxy: {
	"@type": "type.googleapis.com/envoy.config.filter.network.mongo_proxy.v2.MongoProxy"
	// The human readable prefix to use when emitting :ref:`statistics
	// <config_network_filters_mongo_proxy_stats>`.
	stat_prefix?: string
	// The optional path to use for writing Mongo access logs. If not access log
	// path is specified no access logs will be written. Note that access log is
	// also gated :ref:`runtime <config_network_filters_mongo_proxy_runtime>`.
	access_log?: string
	// Inject a fixed delay before proxying a Mongo operation. Delays are
	// applied to the following MongoDB operations: Query, Insert, GetMore,
	// and KillCursors. Once an active delay is in progress, all incoming
	// data up until the timer event fires will be a part of the delay.
	delay?: v2.#FaultDelay
	// Flag to specify whether :ref:`dynamic metadata
	// <config_network_filters_mongo_proxy_dynamic_metadata>` should be emitted. Defaults to false.
	emit_dynamic_metadata?: bool
}
