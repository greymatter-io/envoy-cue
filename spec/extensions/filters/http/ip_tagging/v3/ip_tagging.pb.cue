package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
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

// Describes how to apply the tags to the headers.
#IPTagging_IpTagHeader_HeaderAction: "SANITIZE" | "APPEND_IF_EXISTS_OR_ADD"

IPTagging_IpTagHeader_HeaderAction_SANITIZE:                "SANITIZE"
IPTagging_IpTagHeader_HeaderAction_APPEND_IF_EXISTS_OR_ADD: "APPEND_IF_EXISTS_OR_ADD"

// [#next-free-field: 7]
#IPTagging: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ip_tagging.v3.IPTagging"
	// The type of request the filter should apply to.
	request_type?: #IPTagging_RequestType
	// The set of IP tags for the filter.
	// Only one of :ref:`ip_tags <envoy_v3_api_field_extensions.filters.http.ip_tagging.v3.IPTagging.ip_tags>`
	// or :ref:`ip_tags_datasource <envoy_v3_api_field_extensions.filters.http.ip_tagging.v3.IPTagging.ip_tags_datasource>`
	// can be set for the IP Tagging filter.
	ip_tags?: [...#IPTagging_IPTag]
	// Specify to which header the tags will be written.
	//
	// If left unspecified, the tags will be appended to the “x-envoy-ip-tags“ header.
	ip_tag_header?: #IPTagging_IpTagHeader
	// Data source from which to retrieve ip tags.
	// Only filename based data source is currently supported for IP tags.
	// When using this data source, if a “watched_directory“ is provided, the IP tags file will be re-read when a file move is detected.
	// See :ref:`watched_directory <envoy_v3_api_msg_config.core.v3.DataSource>` for more information about the “watched_directory“ field.
	ip_tags_datasource?: v3.#DataSource
}

// Supplies the IP tag name and the IP address subnets.
#IPTagging_IPTag: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ip_tagging.v3.IPTagging_IPTag"
	// Specifies the IP tag name to apply.
	ip_tag_name?: string
	// A list of IP address subnets that will be tagged with
	// ip_tag_name. Both IPv4 and IPv6 are supported.
	ip_list?: [...v3.#CidrRange]
}

// Specifies the content of the IP tag file.
// Allow the file to be created with no IP tags.
#IPTagging_IPTags: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ip_tagging.v3.IPTagging_IPTags"
	ip_tags?: [...#IPTagging_IPTag]
}

// Specify to which header the tags will be written.
#IPTagging_IpTagHeader: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.ip_tagging.v3.IPTagging_IpTagHeader"
	// Header to use for ip-tagging.
	//
	// This header will be sanitized based on the config in
	// :ref:`action <envoy_v3_api_field_extensions.filters.http.ip_tagging.v3.IPTagging.IpTagHeader.action>`
	// rather than the defaults for x-envoy prefixed headers.
	header?: string
	// Control if the :ref:`header <envoy_v3_api_field_extensions.filters.http.ip_tagging.v3.IPTagging.IpTagHeader.header>`
	// will be sanitized, or be appended to.
	//
	// Default: *SANITIZE*.
	action?: #IPTagging_IpTagHeader_HeaderAction
}
