package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/extensions/clusters/common/dns/v3"
)

// [#next-free-field: 11]
#DnsCluster: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.dns.v3.DnsCluster"
	// This value is the cluster’s DNS refresh rate. The value configured must be at least 1ms.
	// If this setting is not specified, the
	// value defaults to 5000ms.
	dns_refresh_rate?: string
	// This is the cluster’s DNS refresh rate when requests are failing. If this setting is
	// not specified, the failure refresh rate defaults to the DNS refresh rate.
	dns_failure_refresh_rate?: #DnsCluster_RefreshRate
	// Optional configuration for setting cluster's DNS refresh rate. If the value is set to true,
	// cluster's DNS refresh rate will be set to resource record's TTL which comes from DNS
	// resolution.
	respect_dns_ttl?: bool
	// DNS jitter causes the cluster to refresh DNS entries later by a random amount of time to avoid a
	// stampede of DNS requests. This value sets the upper bound (exclusive) for the random amount.
	// There will be no jitter if this value is omitted.
	dns_jitter?: string
	// DNS resolver type configuration extension. This extension can be used to configure c-ares, apple,
	// or any other DNS resolver types and the related parameters.
	// For example, an object of
	// :ref:`CaresDnsResolverConfig<envoy_v3_api_msg_extensions.network.dns_resolver.cares.v3.CaresDnsResolverConfig>`
	// can be packed into this “typed_dns_resolver_config“. This configuration replaces the
	// :ref:`Cluster.typed_dns_resolver_config<envoy_v3_api_field_config.cluster.v3.Cluster.typed_dns_resolver_config>`
	// configuration which replaces :ref:`Cluster.dns_resolution_config<envoy_v3_api_field_config.cluster.v3.Cluster.dns_resolution_config>`.
	// During the transition period when
	// :ref:`DnsCluster.typed_dns_resolver_config<envoy_v3_api_field_extensions.clusters.dns.v3.DnsCluster.typed_dns_resolver_config>`,
	// :ref:`Cluster.typed_dns_resolver_config<envoy_v3_api_field_config.cluster.v3.Cluster.typed_dns_resolver_config>`,
	// and :ref:`Cluster.dns_resolution_config<envoy_v3_api_field_config.cluster.v3.Cluster.dns_resolution_config>`
	// exist, Envoy will use
	// :ref:`DnsCluster.typed_dns_resolver_config<envoy_v3_api_field_extensions.clusters.dns.v3.DnsCluster.typed_dns_resolver_config>`
	// and ignore
	// DNS resolver-related fields in :ref:`Cluster<envoy_v3_api_msg_config.cluster.v3.Cluster>` if the cluster is configured via the
	// :ref:`Cluster.cluster_type<envoy_v3_api_field_config.cluster.v3.Cluster.cluster_type>` extension point with the
	// :ref:`DnsCluster<envoy_v3_api_msg_extensions.clusters.dns.v3.DnsCluster>` extension type.
	// Otherwise, see  :ref:`Cluster.typed_dns_resolver_config<envoy_v3_api_field_config.cluster.v3.Cluster.typed_dns_resolver_config>`.
	// [#extension-category: envoy.network.dns_resolver]
	typed_dns_resolver_config?: v3.#TypedExtensionConfig
	// The DNS IP address resolution policy. If this setting is not specified, the
	// value defaults to
	// :ref:`AUTO<envoy_v3_api_enum_value_extensions.clusters.common.dns.v3.DnsLookupFamily.AUTO>`.
	dns_lookup_family?: v31.#DnsLookupFamily
	// If true, all returned addresses are considered to be associated with a single endpoint,
	// which maps to :ref:`logical DNS discovery <arch_overview_service_discovery_types_logical_dns>`
	// semantics. Otherwise, each address is considered to be a separate endpoint, which maps to
	// :ref:`strict DNS discovery <arch_overview_service_discovery_types_strict_dns>` semantics.
	all_addresses_in_single_endpoint?: bool
	// When :ref:`respect_dns_ttl <envoy_v3_api_field_extensions.clusters.dns.v3.DnsCluster.respect_dns_ttl>`
	// is enabled, this field specifies a minimum value for the TTL-derived DNS refresh rate.
	// DNS records with TTLs shorter than this value will be refreshed at this rate instead. If not
	// set, the TTL from the DNS response is used directly with no minimum floor.
	// The value must be at least 1 second.
	dns_min_refresh_rate?: string
}

#DnsCluster_RefreshRate: {
	"@type": "type.googleapis.com/envoy.extensions.clusters.dns.v3.DnsCluster_RefreshRate"
	// Specifies the base interval between refreshes. This parameter is required and must be greater
	// than zero and less than
	// :ref:`max_interval <envoy_v3_api_field_extensions.clusters.dns.v3.DnsCluster.RefreshRate.max_interval>`.
	base_interval?: string
	// Specifies the maximum interval between refreshes. This parameter is optional, but must be
	// greater than or equal to the
	// :ref:`base_interval <envoy_v3_api_field_extensions.clusters.dns.v3.DnsCluster.RefreshRate.base_interval>`  if set. The default
	// is 10 times the :ref:`base_interval <envoy_v3_api_field_extensions.clusters.dns.v3.DnsCluster.RefreshRate.base_interval>`.
	max_interval?: string
}
