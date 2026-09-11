package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#Geoip: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.geoip.v3.Geoip"
	// Configuration for extracting the client IP address from the
	// “x-forwarded-for“ header. If set, the
	// :ref:`xff_num_trusted_hops <envoy_v3_api_field_extensions.filters.http.geoip.v3.Geoip.XffConfig.xff_num_trusted_hops>`
	// field will be used to determine the trusted client address from the “x-forwarded-for“ header.
	// If not set, the immediate downstream connection source address will be used.
	//
	// Only one of “xff_config“ or
	// :ref:`custom_header_config <envoy_v3_api_field_extensions.filters.http.geoip.v3.Geoip.custom_header_config>`
	// can be set.
	xff_config?: #Geoip_XffConfig
	// Configuration for extracting the client IP address from a custom request header.
	//
	// If set, the
	// :ref:`header_name <envoy_v3_api_field_extensions.filters.http.geoip.v3.Geoip.CustomHeaderConfig.header_name>`
	// field will be used to extract the client IP address from the specified request header.
	//
	// Only one of “custom_header_config“ or
	// :ref:`xff_config <envoy_v3_api_field_extensions.filters.http.geoip.v3.Geoip.xff_config>`
	// can be set.
	custom_header_config?: #Geoip_CustomHeaderConfig
	// Geoip driver specific configuration which depends on the driver being instantiated.
	// See the geoip drivers for examples:
	//
	// - :ref:`MaxMindConfig <envoy_v3_api_msg_extensions.geoip_providers.maxmind.v3.MaxMindConfig>`
	// [#extension-category: envoy.geoip_providers]
	provider?: v3.#TypedExtensionConfig
}

#Geoip_XffConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.geoip.v3.Geoip_XffConfig"
	// The number of additional ingress proxy hops from the right side of the
	// :ref:`config_http_conn_man_headers_x-forwarded-for` HTTP header to trust when
	// determining the origin client's IP address. See the documentation for
	// :ref:`config_http_conn_man_headers_x-forwarded-for` for more information.
	//
	// Defaults to “0“.
	xff_num_trusted_hops?: uint32
}

#Geoip_CustomHeaderConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.geoip.v3.Geoip_CustomHeaderConfig"
	// The name of the request header to extract the client IP address from.
	// The header value must contain a valid IP address (IPv4 or IPv6).
	//
	// If the header is missing or contains an invalid IP address, the filter will fall back
	// to using the immediate downstream connection source address.
	header_name?: string
}
