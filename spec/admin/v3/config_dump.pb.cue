package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/bootstrap/v3"
)

// The :ref:`/config_dump <operations_admin_interface_config_dump>` admin endpoint uses this wrapper
// message to maintain and serve arbitrary configuration information from any component in Envoy.
#ConfigDump: {
	"@type": "type.googleapis.com/envoy.admin.v3.ConfigDump"
	// This list is serialized and dumped in its entirety at the
	// :ref:`/config_dump <operations_admin_interface_config_dump>` endpoint.
	//
	// The following configurations are currently supported and will be dumped in the order given
	// below:
	//
	// * ``bootstrap``: :ref:`BootstrapConfigDump <envoy_v3_api_msg_admin.v3.BootstrapConfigDump>`
	// * ``clusters``: :ref:`ClustersConfigDump <envoy_v3_api_msg_admin.v3.ClustersConfigDump>`
	// * ``endpoints``:  :ref:`EndpointsConfigDump <envoy_v3_api_msg_admin.v3.EndpointsConfigDump>`
	// * ``listeners``: :ref:`ListenersConfigDump <envoy_v3_api_msg_admin.v3.ListenersConfigDump>`
	// * ``scoped_routes``: :ref:`ScopedRoutesConfigDump <envoy_v3_api_msg_admin.v3.ScopedRoutesConfigDump>`
	// * ``routes``:  :ref:`RoutesConfigDump <envoy_v3_api_msg_admin.v3.RoutesConfigDump>`
	// * ``secrets``:  :ref:`SecretsConfigDump <envoy_v3_api_msg_admin.v3.SecretsConfigDump>`
	//
	// EDS Configuration will only be dumped by using parameter ``?include_eds``
	//
	// You can filter output with the resource and mask query parameters.
	// See :ref:`/config_dump?resource={} <operations_admin_interface_config_dump_by_resource>`,
	// :ref:`/config_dump?mask={} <operations_admin_interface_config_dump_by_mask>`,
	// or :ref:`/config_dump?resource={},mask={}
	// <operations_admin_interface_config_dump_by_resource_and_mask>` for more information.
	configs?: _
}

// This message describes the bootstrap configuration that Envoy was started with. This includes
// any CLI overrides that were merged. Bootstrap configuration information can be used to recreate
// the static portions of an Envoy configuration by reusing the output as the bootstrap
// configuration for another Envoy.
#BootstrapConfigDump: {
	"@type":    "type.googleapis.com/envoy.admin.v3.BootstrapConfigDump"
	bootstrap?: v3.#Bootstrap
	// The timestamp when the BootstrapConfig was last updated.
	last_updated?: string
}

// Envoys SDS implementation fills this message with all secrets fetched dynamically via SDS.
#SecretsConfigDump: {
	"@type": "type.googleapis.com/envoy.admin.v3.SecretsConfigDump"
	// The statically loaded secrets.
	static_secrets?: [...#SecretsConfigDump_StaticSecret]
	// The dynamically loaded active secrets. These are secrets that are available to service
	// clusters or listeners.
	dynamic_active_secrets?: [...#SecretsConfigDump_DynamicSecret]
	// The dynamically loaded warming secrets. These are secrets that are currently undergoing
	// warming in preparation to service clusters or listeners.
	dynamic_warming_secrets?: [...#SecretsConfigDump_DynamicSecret]
}

// DynamicSecret contains secret information fetched via SDS.
// [#next-free-field: 7]
#SecretsConfigDump_DynamicSecret: {
	"@type": "type.googleapis.com/envoy.admin.v3.SecretsConfigDump_DynamicSecret"
	// The name assigned to the secret.
	name?: string
	// This is the per-resource version information.
	version_info?: string
	// The timestamp when the secret was last updated.
	last_updated?: string
	// The actual secret information.
	// Security sensitive information is redacted (replaced with "[redacted]") for
	// private keys and passwords in TLS certificates.
	secret?: _
	// Set if the last update failed, cleared after the next successful update.
	// The *error_state* field contains the rejected version of this particular
	// resource along with the reason and timestamp. For successfully updated or
	// acknowledged resource, this field should be empty.
	// [#not-implemented-hide:]
	error_state?: #UpdateFailureState
	// The client status of this resource.
	// [#not-implemented-hide:]
	client_status?: #ClientResourceStatus
}

// StaticSecret specifies statically loaded secret in bootstrap.
#SecretsConfigDump_StaticSecret: {
	"@type": "type.googleapis.com/envoy.admin.v3.SecretsConfigDump_StaticSecret"
	// The name assigned to the secret.
	name?: string
	// The timestamp when the secret was last updated.
	last_updated?: string
	// The actual secret information.
	// Security sensitive information is redacted (replaced with "[redacted]") for
	// private keys and passwords in TLS certificates.
	secret?: _
}
