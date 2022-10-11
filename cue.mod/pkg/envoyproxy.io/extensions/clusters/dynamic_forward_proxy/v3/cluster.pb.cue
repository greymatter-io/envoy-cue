package v3

import (
	v3 "envoyproxy.io/extensions/common/dynamic_forward_proxy/v3"
)

// Configuration for the dynamic forward proxy cluster. See the :ref:`architecture overview
// <arch_overview_http_dynamic_forward_proxy>` for more information.
// [#extension: envoy.clusters.dynamic_forward_proxy]
#ClusterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.dynamic_forward_proxy.v3.ClusterConfig"
	// The DNS cache configuration that the cluster will attach to. Note this configuration must
	// match that of associated :ref:`dynamic forward proxy HTTP filter configuration
	// <envoy_v3_api_field_extensions.filters.http.dynamic_forward_proxy.v3.FilterConfig.dns_cache_config>`.
	dns_cache_config?: v3.#DnsCacheConfig
	// If true allow the cluster configuration to disable the auto_sni and auto_san_validation options
	// in the :ref:`cluster's upstream_http_protocol_options
	// <envoy_v3_api_field_config.cluster.v3.Cluster.upstream_http_protocol_options>`
	allow_insecure_cluster_options?: bool
	// [#not-implemented-hide:]
	// If true allow HTTP/2 and HTTP/3 connections to be reused for requests to different
	// origins than the connection was initially created for. This will only happen when the
	// resolved address for the new connection matches the peer address of the connection and
	// the TLS certificate is also valid for the new hostname. For example, if a connection
	// has previously been established to foo.example.com at IP 1.2.3.4 with a certificate
	// that is valid for `*.example.com`, then this connection could be used for requests to
	// bar.example.com if that also resolved to 1.2.3.4.
	//
	// .. note::
	//   By design, this feature will maximize reuse of connections. This means that instead
	//   opening a new connection when an existing connection reaches the maximum number of
	//   concurrent streams, requests will instead be sent to the existing connection.
	//   TODO(alyssawilk) implement request queueing in connections.
	//
	// .. note::
	//   The coalesced connections might be to upstreams that would not be otherwise
	//   selected by Envoy. See the section `Connection Reuse in RFC 7540
	//   <https://datatracker.ietf.org/doc/html/rfc7540#section-9.1.1>`_
	//
	allow_coalesced_connections?: bool
}
