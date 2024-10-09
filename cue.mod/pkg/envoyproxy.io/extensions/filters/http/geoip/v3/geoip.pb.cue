package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#Geoip: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.geoip.v3.Geoip"
	// If set, the :ref:`xff_num_trusted_hops <envoy_v3_api_field_extensions.filters.http.geoip.v3.Geoip.XffConfig.xff_num_trusted_hops>` field will be used to determine
	// trusted client address from “x-forwarded-for“ header.
	// Otherwise, the immediate downstream connection source address will be used.
	// [#next-free-field: 2]
	xff_config?: #Geoip_XffConfig
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
	// determining the origin client's IP address. The default is zero if this option
	// is not specified. See the documentation for
	// :ref:`config_http_conn_man_headers_x-forwarded-for` for more information.
	xff_num_trusted_hops?: uint32
}
