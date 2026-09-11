package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/geoip_providers/common/v3"
)

// [#next-free-field: 7]
#MaxMindConfig: {
	"@type": "type.googleapis.com/envoy.extensions.geoip_providers.maxmind.v3.MaxMindConfig"
	// Full file path to the MaxMind city database, e.g., “/etc/GeoLite2-City.mmdb“.
	// Database file is expected to have “.mmdb“ extension.
	city_db_path?: string
	// Full file path to the MaxMind ASN database, e.g., “/etc/GeoLite2-ASN.mmdb“.
	// Database file is expected to have “.mmdb“ extension.
	// When this is defined, the ASN information will always be fetched from the “asn_db“.
	asn_db_path?: string
	// Full file path to the MaxMind Anonymous IP database, e.g., “/etc/GeoIP2-Anonymous-IP.mmdb“.
	// Database file is expected to have “.mmdb“ extension.
	anon_db_path?: string
	// Full file path to the MaxMind ISP database, e.g., “/etc/GeoLite2-ISP.mmdb“.
	// Database file is expected to have “.mmdb“ extension.
	// If “asn_db_path“ is not defined, ASN information will be fetched from
	// “isp_db“ instead.
	isp_db_path?: string
	// Full file path to the MaxMind Country database, e.g., “/etc/GeoLite2-Country.mmdb“.
	// Database file is expected to have “.mmdb“ extension.
	//
	// If “country_db_path“ is not specified, country information will be fetched from
	// “city_db“ if “city_db“ is configured.
	country_db_path?: string
	// Common provider configuration that specifies which geolocation headers will be populated with geolocation data.
	common_provider_config?: v3.#CommonGeoipProviderConfig
}
