package v3

import (
	_struct "envoyproxy.io/envoy-cue/spec/deps/golang/protobuf/ptypes/struct"
	v3 "envoyproxy.io/envoy-cue/spec/type/v3"
	v31 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/core/v3"
)

// Envoy supports :ref:`upstream priority routing
// <arch_overview_http_routing_priority>` both at the route and the virtual
// cluster level. The current priority implementation uses different connection
// pool and circuit breaking settings for each priority level. This means that
// even for HTTP/2 requests, two physical connections will be used to an
// upstream host. In the future Envoy will likely support true HTTP/2 priority
// over a single upstream connection.
#RoutingPriority: "DEFAULT" | "HIGH"

RoutingPriority_DEFAULT: "DEFAULT"
RoutingPriority_HIGH:    "HIGH"

// HTTP request method.
#RequestMethod: "METHOD_UNSPECIFIED" | "GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "CONNECT" | "OPTIONS" | "TRACE" | "PATCH"

RequestMethod_METHOD_UNSPECIFIED: "METHOD_UNSPECIFIED"
RequestMethod_GET:                "GET"
RequestMethod_HEAD:               "HEAD"
RequestMethod_POST:               "POST"
RequestMethod_PUT:                "PUT"
RequestMethod_DELETE:             "DELETE"
RequestMethod_CONNECT:            "CONNECT"
RequestMethod_OPTIONS:            "OPTIONS"
RequestMethod_TRACE:              "TRACE"
RequestMethod_PATCH:              "PATCH"

// Identifies the direction of the traffic relative to the local Envoy.
#TrafficDirection: "UNSPECIFIED" | "INBOUND" | "OUTBOUND"

TrafficDirection_UNSPECIFIED: "UNSPECIFIED"
TrafficDirection_INBOUND:     "INBOUND"
TrafficDirection_OUTBOUND:    "OUTBOUND"

// Describes the supported actions types for header append action.
#HeaderValueOption_HeaderAppendAction: "APPEND_IF_EXISTS_OR_ADD" | "ADD_IF_ABSENT" | "OVERWRITE_IF_EXISTS_OR_ADD"

HeaderValueOption_HeaderAppendAction_APPEND_IF_EXISTS_OR_ADD:    "APPEND_IF_EXISTS_OR_ADD"
HeaderValueOption_HeaderAppendAction_ADD_IF_ABSENT:              "ADD_IF_ABSENT"
HeaderValueOption_HeaderAppendAction_OVERWRITE_IF_EXISTS_OR_ADD: "OVERWRITE_IF_EXISTS_OR_ADD"

// Identifies location of where either Envoy runs or where upstream hosts run.
#Locality: {
	"@type": "type.googleapis.com/envoy.config.core.v3.Locality"
	// Region this :ref:`zone <envoy_v3_api_field_config.core.v3.Locality.zone>` belongs to.
	region?: string
	// Defines the local service zone where Envoy is running. Though optional, it
	// should be set if discovery service routing is used and the discovery
	// service exposes :ref:`zone data <envoy_v3_api_field_config.endpoint.v3.LocalityLbEndpoints.locality>`,
	// either in this message or via :option:`--service-zone`. The meaning of zone
	// is context dependent, e.g. `Availability Zone (AZ)
	// <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html>`_
	// on AWS, `Zone <https://cloud.google.com/compute/docs/regions-zones/>`_ on
	// GCP, etc.
	zone?: string
	// When used for locality of upstream hosts, this field further splits zone
	// into smaller chunks of sub-zones so they can be load balanced
	// independently.
	sub_zone?: string
}

// BuildVersion combines SemVer version of extension with free-form build information
// (i.e. 'alpha', 'private-build') as a set of strings.
#BuildVersion: {
	"@type": "type.googleapis.com/envoy.config.core.v3.BuildVersion"
	// SemVer version of extension.
	version?: v3.#SemanticVersion
	// Free-form build information.
	// Envoy defines several well known keys in the source/common/version/version.h file
	metadata?: _struct.#Struct
}

// Version and identification for an Envoy extension.
// [#next-free-field: 7]
#Extension: {
	"@type": "type.googleapis.com/envoy.config.core.v3.Extension"
	// This is the name of the Envoy filter as specified in the Envoy
	// configuration, e.g. envoy.filters.http.router, com.acme.widget.
	name?: string
	// Category of the extension.
	// Extension category names use reverse DNS notation. For instance "envoy.filters.listener"
	// for Envoy's built-in listener filters or "com.acme.filters.http" for HTTP filters from
	// acme.com vendor.
	// [#comment:TODO(yanavlasov): Link to the doc with existing envoy category names.]
	category?: string
	// [#not-implemented-hide:] Type descriptor of extension configuration proto.
	// [#comment:TODO(yanavlasov): Link to the doc with existing configuration protos.]
	// [#comment:TODO(yanavlasov): Add tests when PR #9391 lands.]
	//
	// Deprecated: Do not use.
	type_descriptor?: string
	// The version is a property of the extension and maintained independently
	// of other extensions and the Envoy API.
	// This field is not set when extension did not provide version information.
	version?: #BuildVersion
	// Indicates that the extension is present but was disabled via dynamic configuration.
	disabled?: bool
	// Type URLs of extension configuration protos.
	type_urls?: [...string]
}

// Identifies a specific Envoy instance. The node identifier is presented to the
// management server, which may use this identifier to distinguish per Envoy
// configuration for serving.
// [#next-free-field: 13]
#Node: {
	"@type": "type.googleapis.com/envoy.config.core.v3.Node"
	// An opaque node identifier for the Envoy node. This also provides the local
	// service node name. It should be set if any of the following features are
	// used: :ref:`statsd <arch_overview_statistics>`, :ref:`CDS
	// <config_cluster_manager_cds>`, and :ref:`HTTP tracing
	// <arch_overview_tracing>`, either in this message or via
	// :option:`--service-node`.
	id?: string
	// Defines the local service cluster name where Envoy is running. Though
	// optional, it should be set if any of the following features are used:
	// :ref:`statsd <arch_overview_statistics>`, :ref:`health check cluster
	// verification
	// <envoy_v3_api_field_config.core.v3.HealthCheck.HttpHealthCheck.service_name_matcher>`,
	// :ref:`runtime override directory <envoy_v3_api_msg_config.bootstrap.v3.Runtime>`,
	// :ref:`user agent addition
	// <envoy_v3_api_field_extensions.filters.network.http_connection_manager.v3.HttpConnectionManager.add_user_agent>`,
	// :ref:`HTTP global rate limiting <config_http_filters_rate_limit>`,
	// :ref:`CDS <config_cluster_manager_cds>`, and :ref:`HTTP tracing
	// <arch_overview_tracing>`, either in this message or via
	// :option:`--service-cluster`.
	cluster?: string
	// Opaque metadata extending the node identifier. Envoy will pass this
	// directly to the management server.
	metadata?: _struct.#Struct
	// Map from xDS resource type URL to dynamic context parameters. These may vary at runtime (unlike
	// other fields in this message). For example, the xDS client may have a shard identifier that
	// changes during the lifetime of the xDS client. In Envoy, this would be achieved by updating the
	// dynamic context on the Server::Instance's LocalInfo context provider. The shard ID dynamic
	// parameter then appears in this field during future discovery requests.
	dynamic_parameters?: [string]: v31.#ContextParams
	// Locality specifying where the Envoy instance is running.
	locality?: #Locality
	// Free-form string that identifies the entity requesting config.
	// E.g. "envoy" or "grpc"
	user_agent_name?: string
	// Free-form string that identifies the version of the entity requesting config.
	// E.g. "1.12.2" or "abcd1234", or "SpecialEnvoyBuild"
	user_agent_version?: string
	// Structured version of the entity requesting config.
	user_agent_build_version?: #BuildVersion
	// List of extensions and their versions supported by the node.
	extensions?: [...#Extension]
	// Client feature support list. These are well known features described
	// in the Envoy API repository for a given major version of an API. Client features
	// use reverse DNS naming scheme, for example ``com.acme.feature``.
	// See :ref:`the list of features <client_features>` that xDS client may
	// support.
	client_features?: [...string]
	// Known listening ports on the node as a generic hint to the management server
	// for filtering :ref:`listeners <config_listeners>` to be returned. For example,
	// if there is a listener bound to port 80, the list can optionally contain the
	// SocketAddress ``(0.0.0.0,80)``. The field is optional and just a hint.
	//
	// Deprecated: Do not use.
	listening_addresses?: [...#Address]
}

// Metadata provides additional inputs to filters based on matched listeners,
// filter chains, routes and endpoints. It is structured as a map, usually from
// filter name (in reverse DNS format) to metadata specific to the filter. Metadata
// key-values for a filter are merged as connection and request handling occurs,
// with later values for the same key overriding earlier values.
//
// An example use of metadata is providing additional values to
// http_connection_manager in the envoy.http_connection_manager.access_log
// namespace.
//
// Another example use of metadata is to per service config info in cluster metadata, which may get
// consumed by multiple filters.
//
// For load balancing, Metadata provides a means to subset cluster endpoints.
// Endpoints have a Metadata object associated and routes contain a Metadata
// object to match against. There are some well defined metadata used today for
// this purpose:
//
// * ``{"envoy.lb": {"canary": <bool> }}`` This indicates the canary status of an
//   endpoint and is also used during header processing
//   (x-envoy-upstream-canary) and for stats purposes.
// [#next-major-version: move to type/metadata/v2]
#Metadata: {
	"@type": "type.googleapis.com/envoy.config.core.v3.Metadata"
	// Key is the reverse DNS filter name, e.g. com.acme.widget. The ``envoy.*``
	// namespace is reserved for Envoy's built-in filters.
	// If both ``filter_metadata`` and
	// :ref:`typed_filter_metadata <envoy_v3_api_field_config.core.v3.Metadata.typed_filter_metadata>`
	// fields are present in the metadata with same keys,
	// only ``typed_filter_metadata`` field will be parsed.
	filter_metadata?: [string]: _struct.#Struct
	// Key is the reverse DNS filter name, e.g. com.acme.widget. The ``envoy.*``
	// namespace is reserved for Envoy's built-in filters.
	// The value is encoded as google.protobuf.Any.
	// If both :ref:`filter_metadata <envoy_v3_api_field_config.core.v3.Metadata.filter_metadata>`
	// and ``typed_filter_metadata`` fields are present in the metadata with same keys,
	// only ``typed_filter_metadata`` field will be parsed.
	typed_filter_metadata?: [string]: _
}

// Runtime derived uint32 with a default when not specified.
#RuntimeUInt32: {
	"@type": "type.googleapis.com/envoy.config.core.v3.RuntimeUInt32"
	// Default value if runtime value is not available.
	default_value?: uint32
	// Runtime key to get value for comparison. This value is used if defined.
	runtime_key?: string
}

// Runtime derived percentage with a default when not specified.
#RuntimePercent: {
	"@type": "type.googleapis.com/envoy.config.core.v3.RuntimePercent"
	// Default value if runtime value is not available.
	default_value?: v3.#Percent
	// Runtime key to get value for comparison. This value is used if defined.
	runtime_key?: string
}

// Runtime derived double with a default when not specified.
#RuntimeDouble: {
	"@type": "type.googleapis.com/envoy.config.core.v3.RuntimeDouble"
	// Default value if runtime value is not available.
	default_value?: float64
	// Runtime key to get value for comparison. This value is used if defined.
	runtime_key?: string
}

// Runtime derived bool with a default when not specified.
#RuntimeFeatureFlag: {
	"@type": "type.googleapis.com/envoy.config.core.v3.RuntimeFeatureFlag"
	// Default value if runtime value is not available.
	default_value?: bool
	// Runtime key to get value for comparison. This value is used if defined. The boolean value must
	// be represented via its
	// `canonical JSON encoding <https://developers.google.com/protocol-buffers/docs/proto3#json>`_.
	runtime_key?: string
}

// Query parameter name/value pair.
#QueryParameter: {
	"@type": "type.googleapis.com/envoy.config.core.v3.QueryParameter"
	// The key of the query parameter. Case sensitive.
	key?: string
	// The value of the query parameter.
	value?: string
}

// Header name/value pair.
#HeaderValue: {
	"@type": "type.googleapis.com/envoy.config.core.v3.HeaderValue"
	// Header name.
	key?: string
	// Header value.
	//
	// The same :ref:`format specifier <config_access_log_format>` as used for
	// :ref:`HTTP access logging <config_access_log>` applies here, however
	// unknown header values are replaced with the empty string instead of ``-``.
	value?: string
}

// Header name/value pair plus option to control append behavior.
#HeaderValueOption: {
	"@type": "type.googleapis.com/envoy.config.core.v3.HeaderValueOption"
	// Header name/value pair that this option applies to.
	header?: #HeaderValue
	// Should the value be appended? If true (default), the value is appended to
	// existing values. Otherwise it replaces any existing values.
	// This field is deprecated and please use
	// :ref:`append_action <envoy_v3_api_field_config.core.v3.HeaderValueOption.append_action>` as replacement.
	//
	// Deprecated: Do not use.
	append?: bool
	// Describes the action taken to append/overwrite the given value for an existing header
	// or to only add this header if it's absent.
	// Value defaults to :ref:`APPEND_IF_EXISTS_OR_ADD
	// <envoy_v3_api_enum_value_config.core.v3.HeaderValueOption.HeaderAppendAction.APPEND_IF_EXISTS_OR_ADD>`.
	append_action?: #HeaderValueOption_HeaderAppendAction
	// Is the header value allowed to be empty? If false (default), custom headers with empty values are dropped,
	// otherwise they are added.
	keep_empty_value?: bool
}

// Wrapper for a set of headers.
#HeaderMap: {
	"@type": "type.googleapis.com/envoy.config.core.v3.HeaderMap"
	headers?: [...#HeaderValue]
}

// A directory that is watched for changes, e.g. by inotify on Linux. Move/rename
// events inside this directory trigger the watch.
#WatchedDirectory: {
	"@type": "type.googleapis.com/envoy.config.core.v3.WatchedDirectory"
	// Directory path to watch.
	path?: string
}

// Data source consisting of a file, an inline value, or an environment variable.
#DataSource: {
	"@type": "type.googleapis.com/envoy.config.core.v3.DataSource"
	// Local filesystem data source.
	filename?: string
	// Bytes inlined in the configuration.
	inline_bytes?: bytes
	// String inlined in the configuration.
	inline_string?: string
	// Environment variable data source.
	environment_variable?: string
}

// The message specifies the retry policy of remote data source when fetching fails.
#RetryPolicy: {
	"@type": "type.googleapis.com/envoy.config.core.v3.RetryPolicy"
	// Specifies parameters that control :ref:`retry backoff strategy <envoy_v3_api_msg_config.core.v3.BackoffStrategy>`.
	// This parameter is optional, in which case the default base interval is 1000 milliseconds. The
	// default maximum interval is 10 times the base interval.
	retry_back_off?: #BackoffStrategy
	// Specifies the allowed number of retries. This parameter is optional and
	// defaults to 1.
	num_retries?: uint32
}

// The message specifies how to fetch data from remote and how to verify it.
#RemoteDataSource: {
	"@type": "type.googleapis.com/envoy.config.core.v3.RemoteDataSource"
	// The HTTP URI to fetch the remote data.
	http_uri?: #HttpUri
	// SHA256 string for verifying data.
	sha256?: string
	// Retry policy for fetching remote data.
	retry_policy?: #RetryPolicy
}

// Async data source which support async data fetch.
#AsyncDataSource: {
	"@type": "type.googleapis.com/envoy.config.core.v3.AsyncDataSource"
	// Local async data source.
	local?: #DataSource
	// Remote async data source.
	remote?: #RemoteDataSource
}

// Configuration for transport socket in :ref:`listeners <config_listeners>` and
// :ref:`clusters <envoy_v3_api_msg_config.cluster.v3.Cluster>`. If the configuration is
// empty, a default transport socket implementation and configuration will be
// chosen based on the platform and existence of tls_context.
#TransportSocket: {
	"@type": "type.googleapis.com/envoy.config.core.v3.TransportSocket"
	// The name of the transport socket to instantiate. The name must match a supported transport
	// socket implementation.
	name?:         string
	typed_config?: _
}

// Runtime derived FractionalPercent with defaults for when the numerator or denominator is not
// specified via a runtime key.
//
// .. note::
//
//   Parsing of the runtime key's data is implemented such that it may be represented as a
//   :ref:`FractionalPercent <envoy_v3_api_msg_type.v3.FractionalPercent>` proto represented as JSON/YAML
//   and may also be represented as an integer with the assumption that the value is an integral
//   percentage out of 100. For instance, a runtime key lookup returning the value "42" would parse
//   as a ``FractionalPercent`` whose numerator is 42 and denominator is HUNDRED.
#RuntimeFractionalPercent: {
	"@type": "type.googleapis.com/envoy.config.core.v3.RuntimeFractionalPercent"
	// Default value if the runtime value's for the numerator/denominator keys are not available.
	default_value?: v3.#FractionalPercent
	// Runtime key for a YAML representation of a FractionalPercent.
	runtime_key?: string
}

// Identifies a specific ControlPlane instance that Envoy is connected to.
#ControlPlane: {
	"@type": "type.googleapis.com/envoy.config.core.v3.ControlPlane"
	// An opaque control plane identifier that uniquely identifies an instance
	// of control plane. This can be used to identify which control plane instance,
	// the Envoy is connected to.
	identifier?: string
}
