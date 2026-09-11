package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/type/matcher/v3"
	v31 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// [#next-free-field: 9]
#BandwidthShare: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.bandwidth_share.v3.BandwidthShare"
	// Configuration for request limiting. If unset, requests are not limited.
	// If “kbps“ is zero, requests are not limited.
	request_limit?: #BandwidthShare_Limit
	// Configuration for response limiting. If unset, responses are not limited.
	// If “kbps“ is zero, responses are not limited.
	response_limit?: #BandwidthShare_Limit
	// Optional fill interval in milliseconds for the token refills. Defaults to 50ms.
	// It must be at least 20ms to avoid too aggressive refills.
	//
	// Lower values will use more CPU and provide smoother bandwidth distribution
	// when the limit is being enforced.
	fill_interval?: string
	// Enable response trailers.
	//
	// .. note::
	//
	//	If set true, the following 4 trailers will be added, prefixed by ``response_trailer_prefix``:
	//	* bandwidth-request-delay-ms: delay time in milliseconds added by the limiter.
	//	* bandwidth-response-delay-ms: delay time in milliseconds added by the limiter.
	//	* bandwidth-request-duration-ms: total duration of receiving and processing the request.
	//	* bandwidth-response-duration-ms: total duration of receiving and processing the response.
	//
	//	If ``response_limit`` is unset or has ``kbps`` of 0, the trailers will not be set.
	//
	//	If both the request and response delay time is 0, the trailers will not be set.
	//
	//	Note that the delay time may overlap with other factors such that it may not actually
	//	increase the duration by the stated amount - for example, the source data may still be
	//	arriving into a buffer during the artificial delay, such that it's possible to fully
	//	"catch up" the lost time by reading from that buffer at a later, less-constrained time.
	enable_response_trailers?: bool
	// The prefix for the response trailers. Empty string is a valid prefix.
	//
	// If set, “enable_response_trailers“ must be true.
	//
	// For example, if this value is “x-banana-“ then the trailer keys will be
	// “x-banana-bandwidth-request-delay-ms“, “x-banana-bandwidth-response-duration-ms“,
	// etc.
	response_trailer_prefix?: string
	// An optional matcher which returns a string to use as a tenant name.
	//
	// If unset, the tenant name will always be the empty string, and all requests will
	// have equal weight when limiting is being enforced.
	//
	// If tenant names are set when limiting is being enforced, traffic may be
	// distributed unevenly - for example, assuming all requests want all possible
	// bandwidth, if there are five streams with tenant “foo“ and two streams with
	// tenant “bar“, and no custom weights, “foo“ and “bar“ will get an equal
	// share of the bandwidth (half), then the requests within each tenant will get
	// an equal share of that tenant's share, i.e. the “foo“ requests will each
	// get a fifth of the “foo“ half, a tenth of the total, and the “bar“ requests
	// will each get half of the “bar“ half, a quarter of the total.
	//
	// An example way this might be used is to have “tenant_name_selector“ make
	// each source IP address a tenant. Then if one source IP is trying to make 100
	// requests in parallel, and 99 other IPs are making one request each, the
	// total bandwidth distribution (assuming the limit is being exceeded) would
	// be equal per IP, versus with no tenants it would be equal per request and
	// the greedy IP address would be getting 100x more bandwidth than the others.
	//
	// Note that if the limit is not consistently exceeded, all available bandwidth
	// is still distributed - so in this case if the 99 other IPs were only using
	// half the available bandwidth total between them, the greedy IP would still
	// be able to get 50x more bandwidth than the rest. In this example the value is
	// clearer - the less greedy tenants get all the bandwidth they want, and
	// only the greedy tenant gets throttled, vs. without tenants all the requests
	// would be throttled equally.
	tenant_name_selector?: v3.#Matcher
	// A map from tenant names to configurations. If a tenant name is not present
	// in the map, “default_tenant_config“ is used.
	tenant_configs?: [string]: #BandwidthShare_TenantConfig
	// Optional configuration override for the default tenant. If unset, the
	// default values are used.
	default_tenant_config?: #BandwidthShare_TenantConfig
}

#BandwidthShare_TenantConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.bandwidth_share.v3.BandwidthShare_TenantConfig"
	// Weight of the tenant. For example, if two tenants are competing for
	// limited bandwidth, one has weight=3 and the other has weight=1, the
	// contested bandwidth will be distributed 3/4 to the weight=3 tenant
	// and 1/4 to the weight=1 tenant.
	//
	// If unset or 0, the default weight of 1 will be used.
	weight?: uint32
	// True to record stats with “tenant“ tag set to the tenant name.
	// If false or unset, the stats tag will be empty. It is recommended not
	// to set this to default true if tenant names are dynamically generated
	// from untrusted sources (or otherwise with unlimited scope), to
	// avoid creating unlimited stats cardinality.
	include_stats_tag?: bool
}

#BandwidthShare_Limit: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.bandwidth_share.v3.BandwidthShare_Limit"
	// The unique id of the limiter. Should be set if you want to apply distinct
	// limits on different listeners, or distinct limits for requests and responses.
	// With matching “bucket_id“ values, multiple listeners can share a single limit
	// (e.g. for https and http listener that share a network bandwidth constraint).
	//
	// Also used for the “bucket_id“ stats tag.
	//
	// The empty string is a valid “bucket_id“.
	bucket_id?: string
	// The limit supplied in KiB/s.
	//
	// .. note::
	//
	//	The limit is associated with the ``bucket_id``. If the same ``bucket_id``
	//	is used in multiple listeners/routes, it is a config error for the
	//	configurations to not be identical. If the configuration is updated
	//	dynamically via xds, changing the runtime key, the ``bucket_id`` must
	//	also be changed or it is a config error.
	//
	// The limit can be updated dynamically via runtime. Setting the limit
	// to zero, or unset, disables the filter.
	kbps?: v31.#RuntimeUInt32
}
