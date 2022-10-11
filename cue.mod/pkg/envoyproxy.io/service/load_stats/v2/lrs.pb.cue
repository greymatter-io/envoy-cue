package v2

import (
	core "envoyproxy.io/api/v2/core"
	endpoint "envoyproxy.io/api/v2/endpoint"
)

// A load report Envoy sends to the management server.
// [#not-implemented-hide:] Not configuration. TBD how to doc proto APIs.
#LoadStatsRequest: {
	"@type": "type.googleapis.com/envoy.service.load_stats.v2.LoadStatsRequest"
	// Node identifier for Envoy instance.
	node?: core.#Node
	// A list of load stats to report.
	cluster_stats?: [...endpoint.#ClusterStats]
}

// The management server sends envoy a LoadStatsResponse with all clusters it
// is interested in learning load stats about.
// [#not-implemented-hide:] Not configuration. TBD how to doc proto APIs.
#LoadStatsResponse: {
	"@type": "type.googleapis.com/envoy.service.load_stats.v2.LoadStatsResponse"
	// Clusters to report stats for.
	// Not populated if *send_all_clusters* is true.
	clusters?: [...string]
	// If true, the client should send all clusters it knows about.
	// Only clients that advertise the "envoy.lrs.supports_send_all_clusters" capability in their
	// :ref:`client_features<envoy_api_field_core.Node.client_features>` field will honor this field.
	send_all_clusters?: bool
	// The minimum interval of time to collect stats over. This is only a minimum for two reasons:
	// 1. There may be some delay from when the timer fires until stats sampling occurs.
	// 2. For clusters that were already feature in the previous *LoadStatsResponse*, any traffic
	//    that is observed in between the corresponding previous *LoadStatsRequest* and this
	//    *LoadStatsResponse* will also be accumulated and billed to the cluster. This avoids a period
	//    of inobservability that might otherwise exists between the messages. New clusters are not
	//    subject to this consideration.
	load_reporting_interval?: string
	// Set to *true* if the management server supports endpoint granularity
	// report.
	report_endpoint_granularity?: bool
}

// LoadReportingServiceClient is the client API for LoadReportingService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#LoadReportingServiceClient: _

#LoadReportingService_StreamLoadStatsClient: _

// LoadReportingServiceServer is the server API for LoadReportingService service.
#LoadReportingServiceServer: _

// UnimplementedLoadReportingServiceServer can be embedded to have forward compatible implementations.
#UnimplementedLoadReportingServiceServer: {
	"@type": "type.googleapis.com/envoy.service.load_stats.v2.UnimplementedLoadReportingServiceServer"
}

#LoadReportingService_StreamLoadStatsServer: _
