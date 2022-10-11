package listener

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
	_type "envoyproxy.io/type"
	auth "envoyproxy.io/api/v2/auth"
	core "envoyproxy.io/api/v2/core"
)

#FilterChainMatch_ConnectionSourceType: "ANY" | "LOCAL" | "EXTERNAL"

FilterChainMatch_ConnectionSourceType_ANY:      "ANY"
FilterChainMatch_ConnectionSourceType_LOCAL:    "LOCAL"
FilterChainMatch_ConnectionSourceType_EXTERNAL: "EXTERNAL"

#Filter: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.Filter"
	// The name of the filter to instantiate. The name must match a
	// :ref:`supported filter <config_network_filters>`.
	name?: string
	// Deprecated: Do not use.
	config?:       _struct.#Struct
	typed_config?: _
}

// Specifies the match criteria for selecting a specific filter chain for a
// listener.
//
// In order for a filter chain to be selected, *ALL* of its criteria must be
// fulfilled by the incoming connection, properties of which are set by the
// networking stack and/or listener filters.
//
// The following order applies:
//
// 1. Destination port.
// 2. Destination IP address.
// 3. Server name (e.g. SNI for TLS protocol),
// 4. Transport protocol.
// 5. Application protocols (e.g. ALPN for TLS protocol).
// 6. Source type (e.g. any, local or external network).
// 7. Source IP address.
// 8. Source port.
//
// For criteria that allow ranges or wildcards, the most specific value in any
// of the configured filter chains that matches the incoming connection is going
// to be used (e.g. for SNI ``www.example.com`` the most specific match would be
// ``www.example.com``, then ``*.example.com``, then ``*.com``, then any filter
// chain without ``server_names`` requirements).
//
// [#comment: Implemented rules are kept in the preference order, with deprecated fields
// listed at the end, because that's how we want to list them in the docs.
//
// [#comment:TODO(PiotrSikora): Add support for configurable precedence of the rules]
// [#next-free-field: 13]
#FilterChainMatch: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.FilterChainMatch"
	// Optional destination port to consider when use_original_dst is set on the
	// listener in determining a filter chain match.
	destination_port?: uint32
	// If non-empty, an IP address and prefix length to match addresses when the
	// listener is bound to 0.0.0.0/:: or when use_original_dst is specified.
	prefix_ranges?: [...core.#CidrRange]
	// If non-empty, an IP address and suffix length to match addresses when the
	// listener is bound to 0.0.0.0/:: or when use_original_dst is specified.
	// [#not-implemented-hide:]
	address_suffix?: string
	// [#not-implemented-hide:]
	suffix_len?: uint32
	// Specifies the connection source IP match type. Can be any, local or external network.
	source_type?: #FilterChainMatch_ConnectionSourceType
	// The criteria is satisfied if the source IP address of the downstream
	// connection is contained in at least one of the specified subnets. If the
	// parameter is not specified or the list is empty, the source IP address is
	// ignored.
	source_prefix_ranges?: [...core.#CidrRange]
	// The criteria is satisfied if the source port of the downstream connection
	// is contained in at least one of the specified ports. If the parameter is
	// not specified, the source port is ignored.
	source_ports?: [...uint32]
	// If non-empty, a list of server names (e.g. SNI for TLS protocol) to consider when determining
	// a filter chain match. Those values will be compared against the server names of a new
	// connection, when detected by one of the listener filters.
	//
	// The server name will be matched against all wildcard domains, i.e. ``www.example.com``
	// will be first matched against ``www.example.com``, then ``*.example.com``, then ``*.com``.
	//
	// Note that partial wildcards are not supported, and values like ``*w.example.com`` are invalid.
	//
	// .. attention::
	//
	//   See the :ref:`FAQ entry <faq_how_to_setup_sni>` on how to configure SNI for more
	//   information.
	server_names?: [...string]
	// If non-empty, a transport protocol to consider when determining a filter chain match.
	// This value will be compared against the transport protocol of a new connection, when
	// it's detected by one of the listener filters.
	//
	// Suggested values include:
	//
	// * ``raw_buffer`` - default, used when no transport protocol is detected,
	// * ``tls`` - set by :ref:`envoy.filters.listener.tls_inspector <config_listener_filters_tls_inspector>`
	//   when TLS protocol is detected.
	transport_protocol?: string
	// If non-empty, a list of application protocols (e.g. ALPN for TLS protocol) to consider when
	// determining a filter chain match. Those values will be compared against the application
	// protocols of a new connection, when detected by one of the listener filters.
	//
	// Suggested values include:
	//
	// * ``http/1.1`` - set by :ref:`envoy.filters.listener.tls_inspector
	//   <config_listener_filters_tls_inspector>`,
	// * ``h2`` - set by :ref:`envoy.filters.listener.tls_inspector <config_listener_filters_tls_inspector>`
	//
	// .. attention::
	//
	//   Currently, only :ref:`TLS Inspector <config_listener_filters_tls_inspector>` provides
	//   application protocol detection based on the requested
	//   `ALPN <https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation>`_ values.
	//
	//   However, the use of ALPN is pretty much limited to the HTTP/2 traffic on the Internet,
	//   and matching on values other than ``h2`` is going to lead to a lot of false negatives,
	//   unless all connecting clients are known to use ALPN.
	application_protocols?: [...string]
}

// A filter chain wraps a set of match criteria, an option TLS context, a set of filters, and
// various other parameters.
// [#next-free-field: 8]
#FilterChain: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.FilterChain"
	// The criteria to use when matching a connection to this filter chain.
	filter_chain_match?: #FilterChainMatch
	// The TLS context for this filter chain.
	//
	// .. attention::
	//
	//   **This field is deprecated**. Use `transport_socket` with name `tls` instead. If both are
	//   set, `transport_socket` takes priority.
	//
	// Deprecated: Do not use.
	tls_context?: auth.#DownstreamTlsContext
	// A list of individual network filters that make up the filter chain for
	// connections established with the listener. Order matters as the filters are
	// processed sequentially as connection events happen. Note: If the filter
	// list is empty, the connection will close by default.
	filters?: [...#Filter]
	// Whether the listener should expect a PROXY protocol V1 header on new
	// connections. If this option is enabled, the listener will assume that that
	// remote address of the connection is the one specified in the header. Some
	// load balancers including the AWS ELB support this option. If the option is
	// absent or set to false, Envoy will use the physical peer address of the
	// connection as the remote address.
	use_proxy_proto?: bool
	// [#not-implemented-hide:] filter chain metadata.
	metadata?: core.#Metadata
	// Optional custom transport socket implementation to use for downstream connections.
	// To setup TLS, set a transport socket with name `tls` and
	// :ref:`DownstreamTlsContext <envoy_api_msg_auth.DownstreamTlsContext>` in the `typed_config`.
	// If no transport socket configuration is specified, new connections
	// will be set up with plaintext.
	transport_socket?: core.#TransportSocket
	// [#not-implemented-hide:] The unique name (or empty) by which this filter chain is known. If no
	// name is provided, Envoy will allocate an internal UUID for the filter chain. If the filter
	// chain is to be dynamically updated or removed via FCDS a unique name must be provided.
	name?: string
}

// Listener filter chain match configuration. This is a recursive structure which allows complex
// nested match configurations to be built using various logical operators.
//
// Examples:
//
// * Matches if the destination port is 3306.
//
// .. code-block:: yaml
//
//  destination_port_range:
//   start: 3306
//   end: 3307
//
// * Matches if the destination port is 3306 or 15000.
//
// .. code-block:: yaml
//
//  or_match:
//    rules:
//      - destination_port_range:
//          start: 3306
//          end: 3307
//      - destination_port_range:
//          start: 15000
//          end: 15001
//
// [#next-free-field: 6]
#ListenerFilterChainMatchPredicate: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.ListenerFilterChainMatchPredicate"
	// A set that describes a logical OR. If any member of the set matches, the match configuration
	// matches.
	or_match?: #ListenerFilterChainMatchPredicate_MatchSet
	// A set that describes a logical AND. If all members of the set match, the match configuration
	// matches.
	and_match?: #ListenerFilterChainMatchPredicate_MatchSet
	// A negation match. The match configuration will match if the negated match condition matches.
	not_match?: #ListenerFilterChainMatchPredicate
	// The match configuration will always match.
	any_match?: bool
	// Match destination port. Particularly, the match evaluation must use the recovered local port if
	// the owning listener filter is after :ref:`an original_dst listener filter <config_listener_filters_original_dst>`.
	destination_port_range?: _type.#Int32Range
}

#ListenerFilter: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.ListenerFilter"
	// The name of the filter to instantiate. The name must match a
	// :ref:`supported filter <config_listener_filters>`.
	name?: string
	// Deprecated: Do not use.
	config?:       _struct.#Struct
	typed_config?: _
	// Optional match predicate used to disable the filter. The filter is enabled when this field is empty.
	// See :ref:`ListenerFilterChainMatchPredicate <envoy_api_msg_listener.ListenerFilterChainMatchPredicate>`
	// for further examples.
	filter_disabled?: #ListenerFilterChainMatchPredicate
}

// A set of match configurations used for logical operations.
#ListenerFilterChainMatchPredicate_MatchSet: {
	"@type": "type.googleapis.com/envoy.api.v2.listener.ListenerFilterChainMatchPredicate_MatchSet"
	// The list of rules that make up the set.
	rules?: [...#ListenerFilterChainMatchPredicate]
}
