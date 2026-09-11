package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// The network geolocation filter performs IP geolocation lookups on incoming connections
// and stores the results in the connection's filter state under the well-known key
// “envoy.geoip“. The stored data is a “GeoipInfo“ object that supports
// serialization for access logging and field-level access.
//
// See :ref:`well known filter state <well_known_filter_state>` for details on accessing
// the geolocation data.
#Geoip: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.geoip.v3.Geoip"
	// The prefix to use when emitting statistics. This is useful when there are multiple
	// listeners configured with geoip filters, allowing stats to be grouped per listener.
	// For example, with “stat_prefix: "listener_1."“, stats would be emitted as
	// “listener_1.geoip.total“.
	stat_prefix?: string
	// Geoip driver specific configuration which depends on the driver being instantiated.
	// [#extension-category: envoy.geoip_providers]
	provider?: v3.#TypedExtensionConfig
	// Configuration for dynamically extracting the client IP address used for geolocation lookups.
	//
	// This field accepts the same :ref:`format specifiers <config_access_log_format>` as used for
	// :ref:`HTTP access logging <config_access_log>` to extract the client IP.
	// The formatted result must be a valid IPv4 or IPv6 address string. For example:
	//
	// * “%FILTER_STATE(my.custom.client.ip:PLAIN)%“ - Read from filter state populated by a preceding filter.
	// * “%DYNAMIC_METADATA(namespace:key)%“ - Read from dynamic metadata.
	// * “%REQ(X-Forwarded-For)%“ - Extract from request header (if applicable in context).
	//
	// If not specified, defaults to the downstream connection's remote address.
	// If specified but the result is empty, “-“, or not a valid IP address, the filter
	// falls back to the downstream connection's remote address.
	//
	// Example reading from filter state:
	//
	// .. code-block:: yaml
	//
	//	client_ip: "%FILTER_STATE(my.custom.client.ip:PLAIN)%"
	client_ip?: string
}
