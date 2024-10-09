package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

#LatencyThresholdOverride_Opcode: "Connect" | "Create" | "Delete" | "Exists" | "GetData" | "SetData" | "GetAcl" | "SetAcl" | "GetChildren" | "Sync" | "Ping" | "GetChildren2" | "Check" | "Multi" | "Create2" | "Reconfig" | "CheckWatches" | "RemoveWatches" | "CreateContainer" | "CreateTtl" | "Close" | "SetAuth" | "SetWatches" | "GetEphemerals" | "GetAllChildrenNumber" | "SetWatches2" | "AddWatch"

LatencyThresholdOverride_Opcode_Connect:              "Connect"
LatencyThresholdOverride_Opcode_Create:               "Create"
LatencyThresholdOverride_Opcode_Delete:               "Delete"
LatencyThresholdOverride_Opcode_Exists:               "Exists"
LatencyThresholdOverride_Opcode_GetData:              "GetData"
LatencyThresholdOverride_Opcode_SetData:              "SetData"
LatencyThresholdOverride_Opcode_GetAcl:               "GetAcl"
LatencyThresholdOverride_Opcode_SetAcl:               "SetAcl"
LatencyThresholdOverride_Opcode_GetChildren:          "GetChildren"
LatencyThresholdOverride_Opcode_Sync:                 "Sync"
LatencyThresholdOverride_Opcode_Ping:                 "Ping"
LatencyThresholdOverride_Opcode_GetChildren2:         "GetChildren2"
LatencyThresholdOverride_Opcode_Check:                "Check"
LatencyThresholdOverride_Opcode_Multi:                "Multi"
LatencyThresholdOverride_Opcode_Create2:              "Create2"
LatencyThresholdOverride_Opcode_Reconfig:             "Reconfig"
LatencyThresholdOverride_Opcode_CheckWatches:         "CheckWatches"
LatencyThresholdOverride_Opcode_RemoveWatches:        "RemoveWatches"
LatencyThresholdOverride_Opcode_CreateContainer:      "CreateContainer"
LatencyThresholdOverride_Opcode_CreateTtl:            "CreateTtl"
LatencyThresholdOverride_Opcode_Close:                "Close"
LatencyThresholdOverride_Opcode_SetAuth:              "SetAuth"
LatencyThresholdOverride_Opcode_SetWatches:           "SetWatches"
LatencyThresholdOverride_Opcode_GetEphemerals:        "GetEphemerals"
LatencyThresholdOverride_Opcode_GetAllChildrenNumber: "GetAllChildrenNumber"
LatencyThresholdOverride_Opcode_SetWatches2:          "SetWatches2"
LatencyThresholdOverride_Opcode_AddWatch:             "AddWatch"

// [#next-free-field: 10]
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
	max_packet_bytes?: wrapperspb.#UInt32Value
	// Whether to emit latency threshold metrics. If not set, it defaults to false.
	// If false, setting “default_latency_threshold“ and “latency_threshold_overrides“ will not have effect.
	enable_latency_threshold_metrics?: bool
	// The default latency threshold to decide the fast/slow responses and emit metrics (used for error budget calculation).
	//
	// https://sre.google/workbook/implementing-slos/
	//
	// If it is not set, the default value is 100 milliseconds.
	default_latency_threshold?: durationpb.#Duration
	// List of latency threshold overrides for opcodes.
	// If the threshold override of one opcode is not set, it will fallback to the default latency
	// threshold.
	// Specifying latency threshold overrides multiple times for one opcode is not allowed.
	latency_threshold_overrides?: [...#LatencyThresholdOverride]
	// Whether to emit per opcode request bytes metrics. If not set, it defaults to false.
	enable_per_opcode_request_bytes_metrics?: bool
	// Whether to emit per opcode response bytes metrics. If not set, it defaults to false.
	enable_per_opcode_response_bytes_metrics?: bool
	// Whether to emit per opcode decoder error metrics. If not set, it defaults to false.
	enable_per_opcode_decoder_error_metrics?: bool
}

#LatencyThresholdOverride: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.zookeeper_proxy.v3.LatencyThresholdOverride"
	// The ZooKeeper opcodes. Can be found as part of the ZooKeeper source code:
	//
	// https://github.com/apache/zookeeper/blob/master/zookeeper-server/src/main/java/org/apache/zookeeper/ZooDefs.java
	opcode?: #LatencyThresholdOverride_Opcode
	// The latency threshold override of certain opcode.
	threshold?: durationpb.#Duration
}
