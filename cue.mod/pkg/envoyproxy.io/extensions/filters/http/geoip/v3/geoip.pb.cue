package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#Geoip: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.geoip.v3.Geoip"
	// If set, the :ref:`xff_num_trusted_hops <envoy_v3_api_field_extensions.filters.http.geoip.v3.Geoip.XffConfig.xff_num_trusted_hops>` field will be used to determine
	// trusted client address from `x-forwarded-for` header.
	// Otherwise, the immediate downstream connection source address will be used.
	// [#next-free-field: 2]
	xff_config?: #Geoip_XffConfig
	// Configuration for geolocation headers to add to request.
	geo_headers_to_add?: #Geoip_GeolocationHeadersToAdd
	// Geolocation provider specific configuration.
	provider?: v3.#TypedExtensionConfig
}

// The set of geolocation headers to add to request. If any of the configured headers is present
// in the incoming request, it will be overridden by Geoip filter.
// [#next-free-field: 10]
#Geoip_GeolocationHeadersToAdd: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.geoip.v3.Geoip_GeolocationHeadersToAdd"
	// If set, the header will be used to populate the country ISO code associated with the IP address.
	country?: string
	// If set, the header will be used to populate the city associated with the IP address.
	city?: string
	// If set, the header will be used to populate the region ISO code associated with the IP address.
	region?: string
	// If set, the header will be used to populate the ASN associated with the IP address.
	asn?: string
	// If set, the IP address will be checked if it belongs to any type of anonymization network (e.g. VPN, public proxy etc)
	// and header will be populated with the check result. Header value will be set to either "true" or "false" depending on the check result.
	is_anon?: string
	// If set, the IP address will be checked if it belongs to a VPN and header will be populated with the check result.
	// Header value will be set to either "true" or "false" depending on the check result.
	anon_vpn?: string
	// If set, the IP address will be checked if it belongs to a hosting provider and header will be populated with the check result.
	// Header value will be set to either "true" or "false" depending on the check result.
	anon_hosting?: string
	// If set, the IP address will be checked if it belongs to a TOR exit node and header will be populated with the check result.
	// Header value will be set to either "true" or "false" depending on the check result.
	anon_tor?: string
	// If set, the IP address will be checked if it belongs to a public proxy and header will be populated with the check result.
	// Header value will be set to either "true" or "false" depending on the check result.
	anon_proxy?: string
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
