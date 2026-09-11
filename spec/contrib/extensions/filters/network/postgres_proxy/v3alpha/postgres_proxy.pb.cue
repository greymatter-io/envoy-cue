package v3alpha

// Downstream and Upstream SSL operational modes.
#PostgresProxy_SSLMode: "DISABLE" | "REQUIRE" | "ALLOW"

PostgresProxy_SSLMode_DISABLE: "DISABLE"
PostgresProxy_SSLMode_REQUIRE: "REQUIRE"
PostgresProxy_SSLMode_ALLOW:   "ALLOW"

// [#next-free-field: 6]
#PostgresProxy: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.postgres_proxy.v3alpha.PostgresProxy"
	// The human readable prefix to use when emitting :ref:`statistics
	// <config_network_filters_postgres_proxy_stats>`.
	stat_prefix?: string
	// Controls whether SQL statements received in Frontend Query messages
	// are parsed. Parsing is required to produce Postgres proxy filter
	// metadata. Defaults to true.
	enable_sql_parsing?: bool
	// Controls whether to terminate SSL session initiated by a client.
	// If the value is false, the Postgres proxy filter will not try to
	// terminate SSL session, but will pass all the packets to the upstream server.
	// If the value is true, the Postgres proxy filter will try to terminate SSL
	// session. In order to do that, the filter chain must use :ref:`starttls transport socket
	// <envoy_v3_api_msg_extensions.transport_sockets.starttls.v3.StartTlsConfig>`.
	// If the filter does not manage to terminate the SSL session, it will close the connection from the client.
	// Refer to official documentation for details
	// `SSL Session Encryption Message Flow <https://www.postgresql.org/docs/current/protocol-flow.html#id-1.10.5.7.11>`_.
	// This field is deprecated.
	// Please use :ref:`downstream_ssl <envoy_v3_api_field_extensions.filters.network.postgres_proxy.v3alpha.PostgresProxy.downstream_ssl>`.
	//
	// Deprecated: Marked as deprecated in contrib/envoy/extensions/filters/network/postgres_proxy/v3alpha/postgres_proxy.proto.
	terminate_ssl?: bool
	// Controls whether to establish upstream SSL connection to the server.
	// Envoy will try to establish upstream SSL connection to the server only when
	// Postgres filter is able to read Postgres payload in clear-text. It happens when
	// a client established a clear-text connection to Envoy or when a client established
	// SSL connection to Envoy and Postgres filter is configured to terminate SSL.
	// In order for upstream encryption to work, the corresponding cluster must be configured to use
	// :ref:`starttls transport socket <envoy_v3_api_msg_extensions.transport_sockets.starttls.v3.UpstreamStartTlsConfig>`.
	// Defaults to “DISABLE“.
	upstream_ssl?: #PostgresProxy_SSLMode
	// Controls whether to close downstream connections that refuse to upgrade to SSL.
	// If enabled, the filter chain must use
	// :ref:`starttls transport socket <envoy_v3_api_msg_extensions.transport_sockets.starttls.v3.UpstreamStartTlsConfig>`.
	// Defaults to “DISABLE“.
	downstream_ssl?: #PostgresProxy_SSLMode
}
