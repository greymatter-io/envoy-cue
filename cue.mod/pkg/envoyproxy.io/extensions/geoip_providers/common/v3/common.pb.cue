package v3

#CommonGeoipProviderConfig: {
	"@type": "type.googleapis.com/envoy.extensions.geoip_providers.common.v3.CommonGeoipProviderConfig"
	// Configuration for geolocation headers to add to request.
	geo_headers_to_add?: #CommonGeoipProviderConfig_GeolocationHeadersToAdd
}

// The set of geolocation headers to add to request. If any of the configured headers is present
// in the incoming request, it will be overridden by the :ref:`Geoip filter <config_http_filters_geoip>`.
// [#next-free-field: 10]
#CommonGeoipProviderConfig_GeolocationHeadersToAdd: {
	"@type": "type.googleapis.com/envoy.extensions.geoip_providers.common.v3.CommonGeoipProviderConfig_GeolocationHeadersToAdd"
	// If set, the header will be used to populate the country ISO code associated with the IP address.
	country?: string
	// If set, the header will be used to populate the city associated with the IP address.
	city?: string
	// If set, the header will be used to populate the region ISO code associated with the IP address.
	// The least specific subdivision will be selected as region value.
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
