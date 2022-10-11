package v3

import (
	v3 "envoyproxy.io/extensions/filters/common/fault/v3"
)

// [#next-free-field: 6]
#MongoProxy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.mongo_proxy.v3.MongoProxy"
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
	delay?: v3.#FaultDelay
	// Flag to specify whether :ref:`dynamic metadata
	// <config_network_filters_mongo_proxy_dynamic_metadata>` should be emitted. Defaults to false.
	emit_dynamic_metadata?: bool
	// List of commands to emit metrics for. Defaults to "delete", "insert", and "update".
	// Note that metrics will not be emitted for "find" commands, since those are considered
	// queries, and metrics for those are emitted under a dedicated "query" namespace.
	commands?: [...string]
}
