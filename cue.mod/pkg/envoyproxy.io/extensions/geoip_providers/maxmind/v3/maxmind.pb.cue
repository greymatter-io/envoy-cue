package v3

import (
	v3 "envoyproxy.io/extensions/geoip_providers/common/v3"
)

#MaxMindConfig: {
	"@type": "type.googleapis.com/envoy.extensions.geoip_providers.maxmind.v3.MaxMindConfig"
	// Full file path to the Maxmind city database, e.g. /etc/GeoLite2-City.mmdb.
	// Database file is expected to have .mmdb extension.
	city_db_path?: string
	// Full file path to the Maxmind ASN database, e.g. /etc/GeoLite2-ASN.mmdb.
	// Database file is expected to have .mmdb extension.
	isp_db_path?: string
	// Full file path to the Maxmind anonymous IP database, e.g. /etc/GeoIP2-Anonymous-IP.mmdb.
	// Database file is expected to have .mmdb extension.
	anon_db_path?: string
	// Common provider configuration that specifies which geolocation headers will be populated with geolocation data.
	common_provider_config?: v3.#CommonGeoipProviderConfig
}
