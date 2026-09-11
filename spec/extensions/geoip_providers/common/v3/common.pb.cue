package v3

#CommonGeoipProviderConfig: {
	"@type": "type.googleapis.com/envoy.extensions.geoip_providers.common.v3.CommonGeoipProviderConfig"
	// Configuration for geolocation headers to add to HTTP requests.
	// This field is deprecated in favor of “geo_field_keys“. If both are set, “geo_field_keys“
	// takes precedence.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/geoip_providers/common/v3/common.proto.
	geo_headers_to_add?: #CommonGeoipProviderConfig_GeolocationHeadersToAdd
	// Configuration for geolocation field keys.
	// At least one of “geo_headers_to_add“ or “geo_field_keys“ must be set.
	geo_field_keys?: #CommonGeoipProviderConfig_GeolocationFieldKeys
}

// The set of geolocation headers to add to request. If any of the configured headers is present
// in the incoming request, it will be overridden by the :ref:`HTTP GeoIP filter <config_http_filters_geoip>`.
// [#next-free-field: 14]
//
// .. attention::
//
//	This field is deprecated in favor of :ref:`geo_field_keys
//	<envoy_v3_api_field_extensions.geoip_providers.common.v3.CommonGeoipProviderConfig.geo_field_keys>`.
#CommonGeoipProviderConfig_GeolocationHeadersToAdd: {
	"@type": "type.googleapis.com/envoy.extensions.geoip_providers.common.v3.CommonGeoipProviderConfig_GeolocationHeadersToAdd"
	// If set, the header will be used to populate the country ISO code associated with the IP address.
	country?: string
	// If set, the header will be used to populate the city associated with the IP address.
	city?: string
	// If set, the header will be used to populate the region ISO code associated with the IP address.
	// The least specific subdivision will be selected as the region value.
	region?: string
	// If set, the header will be used to populate the ASN associated with the IP address.
	// Note: If both ISP and ASN databases are configured, only the ASN database is used for lookup.
	asn?: string
	// If set, the header will be used to populate the autonomous system organization associated with the IP address.
	// Note: If both ISP and ASN databases are configured, only the ASN database is used for lookup.
	asn_org?: string
	// This field is deprecated; use “anon“ instead.
	//
	// Deprecated: Marked as deprecated in envoy/extensions/geoip_providers/common/v3/common.proto.
	is_anon?: string
	// If set, the IP address will be checked if it belongs to any type of anonymization network (e.g., VPN, public proxy).
	// The header will be populated with the check result. Header value will be set to either “true“ or “false“ depending on the check result.
	anon?: string
	// If set, the IP address will be checked if it belongs to a VPN and the header will be populated with the check result.
	// Header value will be set to either “true“ or “false“ depending on the check result.
	anon_vpn?: string
	// If set, the IP address will be checked if it belongs to a hosting provider and the header will be populated with the check result.
	// Header value will be set to either “true“ or “false“ depending on the check result.
	anon_hosting?: string
	// If set, the IP address will be checked if it belongs to a TOR exit node and the header will be populated with the check result.
	// Header value will be set to either “true“ or “false“ depending on the check result.
	anon_tor?: string
	// If set, the IP address will be checked if it belongs to a public proxy and the header will be populated with the check result.
	// Header value will be set to either “true“ or “false“ depending on the check result.
	anon_proxy?: string
	// If set, the header will be used to populate the ISP associated with the IP address.
	isp?: string
	// If set, the IP address will be checked if it belongs to the ISP named iCloud Private Relay and the header will be populated with the check result.
	// Header value will be set to either “true“ or “false“ depending on the check result.
	apple_private_relay?: string
}

// The set of geolocation field keys to use for storing lookup results.
// These keys define how the geolocation lookup results will be stored. The actual storage
// mechanism depends on the filter using the provider:
//
//   - The :ref:`HTTP GeoIP filter <config_http_filters_geoip>` stores results as HTTP request headers.
//   - The :ref:`Network GeoIP filter <config_network_filters_geoip>` stores results in the
//     connection's filter state under the well-known key “envoy.geoip“.
//
// [#next-free-field: 13]
#CommonGeoipProviderConfig_GeolocationFieldKeys: {
	"@type": "type.googleapis.com/envoy.extensions.geoip_providers.common.v3.CommonGeoipProviderConfig_GeolocationFieldKeys"
	// If set, the key will be used to populate the country ISO code associated with the IP address.
	country?: string
	// If set, the key will be used to populate the city associated with the IP address.
	city?: string
	// If set, the key will be used to populate the region ISO code associated with the IP address.
	// The least specific subdivision will be selected as the region value.
	region?: string
	// If set, the key will be used to populate the ASN associated with the IP address.
	asn?: string
	// If set, the key will be used to populate the autonomous system organization associated with the IP address.
	asn_org?: string
	// If set, the IP address will be checked if it belongs to any type of anonymization network
	// (e.g., VPN, public proxy). The result will be stored with this key. Value will be set to
	// either “true“ or “false“ depending on the check result.
	anon?: string
	// If set, the IP address will be checked if it belongs to a VPN and the result will be stored
	// with this key. Value will be set to either “true“ or “false“ depending on the check result.
	anon_vpn?: string
	// If set, the IP address will be checked if it belongs to a hosting provider and the result
	// will be stored with this key. Value will be set to either “true“ or “false“ depending on
	// the check result.
	anon_hosting?: string
	// If set, the IP address will be checked if it belongs to a TOR exit node and the result will
	// be stored with this key. Value will be set to either “true“ or “false“ depending on the
	// check result.
	anon_tor?: string
	// If set, the IP address will be checked if it belongs to a public proxy and the result will
	// be stored with this key. Value will be set to either “true“ or “false“ depending on the
	// check result.
	anon_proxy?: string
	// If set, the key will be used to populate the ISP associated with the IP address.
	isp?: string
	// If set, the IP address will be checked if it belongs to the ISP named iCloud Private Relay
	// and the result will be stored with this key. Value will be set to either “true“ or “false“
	// depending on the check result.
	apple_private_relay?: string
}
