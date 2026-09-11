package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/metadata/v3"
)

// Configuration for the Original Destination cluster.
#OriginalDstCluster: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.original_dst.v3.OriginalDstCluster"
	// When true, an HTTP header can be used to override the original dst address. The default header is
	// :ref:`x-envoy-original-dst-host <config_http_conn_man_headers_x-envoy-original-dst-host>`.
	//
	// .. attention::
	//
	//	This header isn't sanitized by default, so enabling this feature allows HTTP clients to
	//	route traffic to arbitrary hosts and/or ports, which may have serious security
	//	consequences.
	//
	// .. note::
	//
	//	If the header appears multiple times only the first value is used.
	use_http_header?: bool
	// The http header to override destination address if :ref:`use_http_header
	// <envoy_v3_api_field_extensions.clusters.original_dst.v3.OriginalDstCluster.use_http_header>`
	// is set to true. If the value is empty,
	// :ref:`x-envoy-original-dst-host <config_http_conn_man_headers_x-envoy-original-dst-host>` will be used.
	http_header_name?: string
	// The port to override for the original dst address. This port
	// will take precedence over filter state and header override ports.
	upstream_port_override?: uint32
	// The dynamic metadata key to override destination address.
	// First the request metadata is considered, then the connection one.
	metadata_key?: v3.#MetadataKey
}
