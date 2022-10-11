package v2

import (
	core "envoyproxy.io/api/v2/core"
)

// The type of requests the filter should apply to. The supported types
// are internal, external or both. The
// :ref:`x-forwarded-for<config_http_conn_man_headers_x-forwarded-for_internal_origin>` header is
// used to determine if a request is internal and will result in
// :ref:`x-envoy-internal<config_http_conn_man_headers_x-envoy-internal>`
// being set. The filter defaults to both, and it will apply to all request types.
#IPTagging_RequestType: "BOTH" | "INTERNAL" | "EXTERNAL"

IPTagging_RequestType_BOTH:     "BOTH"
IPTagging_RequestType_INTERNAL: "INTERNAL"
IPTagging_RequestType_EXTERNAL: "EXTERNAL"

#IPTagging: {
	"@type": "type.googleapis.com/envoy.config.filter.http.ip_tagging.v2.IPTagging"
	// The type of request the filter should apply to.
	request_type?: #IPTagging_RequestType
	// [#comment:TODO(ccaraman): Extend functionality to load IP tags from file system.
	// Tracked by issue https://github.com/envoyproxy/envoy/issues/2695]
	// The set of IP tags for the filter.
	ip_tags?: [...#IPTagging_IPTag]
}

// Supplies the IP tag name and the IP address subnets.
#IPTagging_IPTag: {
	"@type": "type.googleapis.com/envoy.config.filter.http.ip_tagging.v2.IPTagging_IPTag"
	// Specifies the IP tag name to apply.
	ip_tag_name?: string
	// A list of IP address subnets that will be tagged with
	// ip_tag_name. Both IPv4 and IPv6 are supported.
	ip_list?: [...core.#CidrRange]
}
