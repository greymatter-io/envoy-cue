package endpoint

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
	core "envoyproxy.io/api/v2/core"
)

// These are stats Envoy reports to GLB every so often. Report frequency is
// defined by
// :ref:`LoadStatsResponse.load_reporting_interval<envoy_api_field_service.load_stats.v2.LoadStatsResponse.load_reporting_interval>`.
// Stats per upstream region/zone and optionally per subzone.
// [#not-implemented-hide:] Not configuration. TBD how to doc proto APIs.
// [#next-free-field: 9]
#UpstreamLocalityStats: {
	"@type": "type.googleapis.com/envoy.api.v2.endpoint.UpstreamLocalityStats"
	// Name of zone, region and optionally endpoint group these metrics were
	// collected from. Zone and region names could be empty if unknown.
	locality?: core.#Locality
	// The total number of requests successfully completed by the endpoints in the
	// locality.
	total_successful_requests?: uint64
	// The total number of unfinished requests
	total_requests_in_progress?: uint64
	// The total number of requests that failed due to errors at the endpoint,
	// aggregated over all endpoints in the locality.
	total_error_requests?: uint64
	// The total number of requests that were issued by this Envoy since
	// the last report. This information is aggregated over all the
	// upstream endpoints in the locality.
	total_issued_requests?: uint64
	// Stats for multi-dimensional load balancing.
	load_metric_stats?: [...#EndpointLoadMetricStats]
	// Endpoint granularity stats information for this locality. This information
	// is populated if the Server requests it by setting
	// :ref:`LoadStatsResponse.report_endpoint_granularity<envoy_api_field_service.load_stats.v2.LoadStatsResponse.report_endpoint_granularity>`.
	upstream_endpoint_stats?: [...#UpstreamEndpointStats]
	// [#not-implemented-hide:] The priority of the endpoint group these metrics
	// were collected from.
	priority?: uint32
}

// [#not-implemented-hide:] Not configuration. TBD how to doc proto APIs.
// [#next-free-field: 8]
#UpstreamEndpointStats: {
	"@type": "type.googleapis.com/envoy.api.v2.endpoint.UpstreamEndpointStats"
	// Upstream host address.
	address?: core.#Address
	// Opaque and implementation dependent metadata of the
	// endpoint. Envoy will pass this directly to the management server.
	metadata?: _struct.#Struct
	// The total number of requests successfully completed by the endpoints in the
	// locality. These include non-5xx responses for HTTP, where errors
	// originate at the client and the endpoint responded successfully. For gRPC,
	// the grpc-status values are those not covered by total_error_requests below.
	total_successful_requests?: uint64
	// The total number of unfinished requests for this endpoint.
	total_requests_in_progress?: uint64
	// The total number of requests that failed due to errors at the endpoint.
	// For HTTP these are responses with 5xx status codes and for gRPC the
	// grpc-status values:
	//
	//   - DeadlineExceeded
	//   - Unimplemented
	//   - Internal
	//   - Unavailable
	//   - Unknown
	//   - DataLoss
	total_error_requests?: uint64
	// The total number of requests that were issued to this endpoint
	// since the last report. A single TCP connection, HTTP or gRPC
	// request or stream is counted as one request.
	total_issued_requests?: uint64
	// Stats for multi-dimensional load balancing.
	load_metric_stats?: [...#EndpointLoadMetricStats]
}

// [#not-implemented-hide:] Not configuration. TBD how to doc proto APIs.
#EndpointLoadMetricStats: {
	"@type": "type.googleapis.com/envoy.api.v2.endpoint.EndpointLoadMetricStats"
	// Name of the metric; may be empty.
	metric_name?: string
	// Number of calls that finished and included this metric.
	num_requests_finished_with_metric?: uint64
	// Sum of metric values across all calls that finished with this metric for
	// load_reporting_interval.
	total_metric_value?: float64
}

// Per cluster load stats. Envoy reports these stats a management server in a
// :ref:`LoadStatsRequest<envoy_api_msg_service.load_stats.v2.LoadStatsRequest>`
// [#not-implemented-hide:] Not configuration. TBD how to doc proto APIs.
// Next ID: 7
// [#next-free-field: 7]
#ClusterStats: {
	"@type": "type.googleapis.com/envoy.api.v2.endpoint.ClusterStats"
	// The name of the cluster.
	cluster_name?: string
	// The eds_cluster_config service_name of the cluster.
	// It's possible that two clusters send the same service_name to EDS,
	// in that case, the management server is supposed to do aggregation on the load reports.
	cluster_service_name?: string
	// Need at least one.
	upstream_locality_stats?: [...#UpstreamLocalityStats]
	// Cluster-level stats such as total_successful_requests may be computed by
	// summing upstream_locality_stats. In addition, below there are additional
	// cluster-wide stats.
	//
	// The total number of dropped requests. This covers requests
	// deliberately dropped by the drop_overload policy and circuit breaking.
	total_dropped_requests?: uint64
	// Information about deliberately dropped requests for each category specified
	// in the DropOverload policy.
	dropped_requests?: [...#ClusterStats_DroppedRequests]
	// Period over which the actual load report occurred. This will be guaranteed to include every
	// request reported. Due to system load and delays between the *LoadStatsRequest* sent from Envoy
	// and the *LoadStatsResponse* message sent from the management server, this may be longer than
	// the requested load reporting interval in the *LoadStatsResponse*.
	load_report_interval?: string
}

#ClusterStats_DroppedRequests: {
	"@type": "type.googleapis.com/envoy.api.v2.endpoint.ClusterStats_DroppedRequests"
	// Identifier for the policy specifying the drop.
	category?: string
	// Total number of deliberately dropped requests for the category.
	dropped_count?: uint64
}
