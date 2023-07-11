package v3

// Specifies that matching should be performed by the destination IP address.
// [#extension: envoy.matching.inputs.destination_ip]
#DestinationIPInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.DestinationIPInput"
}

// Specifies that matching should be performed by the destination port.
// [#extension: envoy.matching.inputs.destination_port]
#DestinationPortInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.DestinationPortInput"
}

// Specifies that matching should be performed by the source IP address.
// [#extension: envoy.matching.inputs.source_ip]
#SourceIPInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.SourceIPInput"
}

// Specifies that matching should be performed by the source port.
// [#extension: envoy.matching.inputs.source_port]
#SourcePortInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.SourcePortInput"
}

// Input that matches by the directly connected source IP address (this
// will only be different from the source IP address when using a listener
// filter that overrides the source address, such as the :ref:`Proxy Protocol
// listener filter <config_listener_filters_proxy_protocol>`).
// [#extension: envoy.matching.inputs.direct_source_ip]
#DirectSourceIPInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.DirectSourceIPInput"
}

// Input that matches by the source IP type.
// Specifies the source IP match type. The values include:
//
// * ``local`` - matches a connection originating from the same host,
// [#extension: envoy.matching.inputs.source_type]
#SourceTypeInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.SourceTypeInput"
}

// Input that matches by the requested server name (e.g. SNI in TLS).
//
// :ref:`TLS Inspector <config_listener_filters_tls_inspector>` provides the requested server name based on SNI,
// when TLS protocol is detected.
// [#extension: envoy.matching.inputs.server_name]
#ServerNameInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.ServerNameInput"
}

// Input that matches by the transport protocol.
//
// Suggested values include:
//
// * ``raw_buffer`` - default, used when no transport protocol is detected,
// * ``tls`` - set by :ref:`envoy.filters.listener.tls_inspector <config_listener_filters_tls_inspector>`
//   when TLS protocol is detected.
// [#extension: envoy.matching.inputs.transport_protocol]
#TransportProtocolInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.TransportProtocolInput"
}

// List of quoted and comma-separated requested application protocols. The list consists of a
// single negotiated application protocol once the network stream is established.
//
// Examples:
//
// * ``'h2','http/1.1'``
// * ``'h2c'``
//
// Suggested values in the list include:
//
// * ``http/1.1`` - set by :ref:`envoy.filters.listener.tls_inspector
//   <config_listener_filters_tls_inspector>` and :ref:`envoy.filters.listener.http_inspector
//   <config_listener_filters_http_inspector>`,
// * ``h2`` - set by :ref:`envoy.filters.listener.tls_inspector <config_listener_filters_tls_inspector>`
// * ``h2c`` - set by :ref:`envoy.filters.listener.http_inspector <config_listener_filters_http_inspector>`
//
// .. attention::
//
//   Currently, :ref:`TLS Inspector <config_listener_filters_tls_inspector>` provides
//   application protocol detection based on the requested
//   `ALPN <https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation>`_ values.
//
//   However, the use of ALPN is pretty much limited to the HTTP/2 traffic on the Internet,
//   and matching on values other than ``h2`` is going to lead to a lot of false negatives,
//   unless all connecting clients are known to use ALPN.
// [#extension: envoy.matching.inputs.application_protocol]
#ApplicationProtocolInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.ApplicationProtocolInput"
}
