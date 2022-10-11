package v2

import (
	core "envoyproxy.io/api/v2/core"
)

#ClientSSLAuth: {
	"@type": "type.googleapis.com/envoy.config.filter.network.client_ssl_auth.v2.ClientSSLAuth"
	// The :ref:`cluster manager <arch_overview_cluster_manager>` cluster that runs
	// the authentication service. The filter will connect to the service every 60s to fetch the list
	// of principals. The service must support the expected :ref:`REST API
	// <config_network_filters_client_ssl_auth_rest_api>`.
	auth_api_cluster?: string
	// The prefix to use when emitting :ref:`statistics
	// <config_network_filters_client_ssl_auth_stats>`.
	stat_prefix?: string
	// Time in milliseconds between principal refreshes from the
	// authentication service. Default is 60000 (60s). The actual fetch time
	// will be this value plus a random jittered value between
	// 0-refresh_delay_ms milliseconds.
	refresh_delay?: string
	// An optional list of IP address and subnet masks that should be white
	// listed for access by the filter. If no list is provided, there is no
	// IP allowlist.
	ip_white_list?: [...core.#CidrRange]
}
