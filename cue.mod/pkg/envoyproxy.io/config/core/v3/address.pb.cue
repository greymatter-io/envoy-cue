package v3

#SocketAddress_Protocol: "TCP" | "UDP"

SocketAddress_Protocol_TCP: "TCP"
SocketAddress_Protocol_UDP: "UDP"

#Pipe: {
	"@type": "type.googleapis.com/envoy.config.core.v3.Pipe"
	// Unix Domain Socket path. On Linux, paths starting with '@' will use the
	// abstract namespace. The starting '@' is replaced by a null byte by Envoy.
	// Paths starting with '@' will result in an error in environments other than
	// Linux.
	path?: string
	// The mode for the Pipe. Not applicable for abstract sockets.
	mode?: uint32
}

// The address represents an envoy internal listener.
// [#comment: TODO(asraa): When address available, remove workaround from test/server/server_fuzz_test.cc:30.]
#EnvoyInternalAddress: {
	"@type": "type.googleapis.com/envoy.config.core.v3.EnvoyInternalAddress"
	// Specifies the :ref:`name <envoy_v3_api_field_config.listener.v3.Listener.name>` of the
	// internal listener.
	server_listener_name?: string
	// Specifies an endpoint identifier to distinguish between multiple endpoints for the same internal listener in a
	// single upstream pool. Only used in the upstream addresses for tracking changes to individual endpoints. This, for
	// example, may be set to the final destination IP for the target internal listener.
	endpoint_id?: string
}

// [#next-free-field: 7]
#SocketAddress: {
	"@type":   "type.googleapis.com/envoy.config.core.v3.SocketAddress"
	protocol?: #SocketAddress_Protocol
	// The address for this socket. :ref:`Listeners <config_listeners>` will bind
	// to the address. An empty address is not allowed. Specify ``0.0.0.0`` or ``::``
	// to bind to any address. [#comment:TODO(zuercher) reinstate when implemented:
	// It is possible to distinguish a Listener address via the prefix/suffix matching
	// in :ref:`FilterChainMatch <envoy_v3_api_msg_config.listener.v3.FilterChainMatch>`.] When used
	// within an upstream :ref:`BindConfig <envoy_v3_api_msg_config.core.v3.BindConfig>`, the address
	// controls the source address of outbound connections. For :ref:`clusters
	// <envoy_v3_api_msg_config.cluster.v3.Cluster>`, the cluster type determines whether the
	// address must be an IP (``STATIC`` or ``EDS`` clusters) or a hostname resolved by DNS
	// (``STRICT_DNS`` or ``LOGICAL_DNS`` clusters). Address resolution can be customized
	// via :ref:`resolver_name <envoy_v3_api_field_config.core.v3.SocketAddress.resolver_name>`.
	address?:    string
	port_value?: uint32
	// This is only valid if :ref:`resolver_name
	// <envoy_v3_api_field_config.core.v3.SocketAddress.resolver_name>` is specified below and the
	// named resolver is capable of named port resolution.
	named_port?: string
	// The name of the custom resolver. This must have been registered with Envoy. If
	// this is empty, a context dependent default applies. If the address is a concrete
	// IP address, no resolution will occur. If address is a hostname this
	// should be set for resolution other than DNS. Specifying a custom resolver with
	// ``STRICT_DNS`` or ``LOGICAL_DNS`` will generate an error at runtime.
	resolver_name?: string
	// When binding to an IPv6 address above, this enables `IPv4 compatibility
	// <https://tools.ietf.org/html/rfc3493#page-11>`_. Binding to ``::`` will
	// allow both IPv4 and IPv6 connections, with peer IPv4 addresses mapped into
	// IPv6 space as ``::FFFF:<IPv4-address>``.
	ipv4_compat?: bool
}

#TcpKeepalive: {
	"@type": "type.googleapis.com/envoy.config.core.v3.TcpKeepalive"
	// Maximum number of keepalive probes to send without response before deciding
	// the connection is dead. Default is to use the OS level configuration (unless
	// overridden, Linux defaults to 9.)
	keepalive_probes?: uint32
	// The number of seconds a connection needs to be idle before keep-alive probes
	// start being sent. Default is to use the OS level configuration (unless
	// overridden, Linux defaults to 7200s (i.e., 2 hours.)
	keepalive_time?: uint32
	// The number of seconds between keep-alive probes. Default is to use the OS
	// level configuration (unless overridden, Linux defaults to 75s.)
	keepalive_interval?: uint32
}

#ExtraSourceAddress: {
	"@type": "type.googleapis.com/envoy.config.core.v3.ExtraSourceAddress"
	// The additional address to bind.
	address?: #SocketAddress
	// Additional socket options that may not be present in Envoy source code or
	// precompiled binaries. If specified, this will override the
	// :ref:`socket_options <envoy_v3_api_field_config.core.v3.BindConfig.socket_options>`
	// in the BindConfig. If specified with no
	// :ref:`socket_options <envoy_v3_api_field_config.core.v3.SocketOptionsOverride.socket_options>`
	// or an empty list of :ref:`socket_options <envoy_v3_api_field_config.core.v3.SocketOptionsOverride.socket_options>`,
	// it means no socket option will apply.
	socket_options?: #SocketOptionsOverride
}

// [#next-free-field: 6]
#BindConfig: {
	"@type": "type.googleapis.com/envoy.config.core.v3.BindConfig"
	// The address to bind to when creating a socket.
	source_address?: #SocketAddress
	// Whether to set the ``IP_FREEBIND`` option when creating the socket. When this
	// flag is set to true, allows the :ref:`source_address
	// <envoy_v3_api_field_config.core.v3.BindConfig.source_address>` to be an IP address
	// that is not configured on the system running Envoy. When this flag is set
	// to false, the option ``IP_FREEBIND`` is disabled on the socket. When this
	// flag is not set (default), the socket is not modified, i.e. the option is
	// neither enabled nor disabled.
	freebind?: bool
	// Additional socket options that may not be present in Envoy source code or
	// precompiled binaries.
	socket_options?: [...#SocketOption]
	// Extra source addresses appended to the address specified in the `source_address`
	// field. This enables to specify multiple source addresses. Currently, only one extra
	// address can be supported, and the extra address should have a different IP version
	// with the address in the `source_address` field. The address which has the same IP
	// version with the target host's address IP version will be used as bind address. If more
	// than one extra address specified, only the first address matched IP version will be
	// returned. If there is no same IP version address found, the address in the `source_address`
	// will be returned.
	extra_source_addresses?: [...#ExtraSourceAddress]
	// Deprecated by
	// :ref:`extra_source_addresses <envoy_v3_api_field_config.core.v3.BindConfig.extra_source_addresses>`
	//
	// Deprecated: Do not use.
	additional_source_addresses?: [...#SocketAddress]
}

// Addresses specify either a logical or physical address and port, which are
// used to tell Envoy where to bind/listen, connect to upstream and find
// management servers.
#Address: {
	"@type":         "type.googleapis.com/envoy.config.core.v3.Address"
	socket_address?: #SocketAddress
	pipe?:           #Pipe
	// Specifies a user-space address handled by :ref:`internal listeners
	// <envoy_v3_api_field_config.listener.v3.Listener.internal_listener>`.
	envoy_internal_address?: #EnvoyInternalAddress
}

// CidrRange specifies an IP Address and a prefix length to construct
// the subnet mask for a `CIDR <https://tools.ietf.org/html/rfc4632>`_ range.
#CidrRange: {
	"@type": "type.googleapis.com/envoy.config.core.v3.CidrRange"
	// IPv4 or IPv6 address, e.g. ``192.0.0.0`` or ``2001:db8::``.
	address_prefix?: string
	// Length of prefix, e.g. 0, 32. Defaults to 0 when unset.
	prefix_len?: uint32
}
