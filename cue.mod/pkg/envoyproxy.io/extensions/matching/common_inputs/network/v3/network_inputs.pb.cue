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
// * “local“ - matches a connection originating from the same host,
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
//   - “raw_buffer“ - default, used when no transport protocol is detected,
//   - “tls“ - set by :ref:`envoy.filters.listener.tls_inspector <config_listener_filters_tls_inspector>`
//     when TLS protocol is detected.
//
// [#extension: envoy.matching.inputs.transport_protocol]
#TransportProtocolInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.TransportProtocolInput"
}

// List of quoted and comma-separated requested application protocols. The list consists of a
// single negotiated application protocol once the network stream is established.
//
// Examples:
//
// * “'h2','http/1.1'“
// * “'h2c'“
//
// Suggested values in the list include:
//
//   - “http/1.1“ - set by :ref:`envoy.filters.listener.tls_inspector
//     <config_listener_filters_tls_inspector>` and :ref:`envoy.filters.listener.http_inspector
//     <config_listener_filters_http_inspector>`,
//   - “h2“ - set by :ref:`envoy.filters.listener.tls_inspector <config_listener_filters_tls_inspector>`
//   - “h2c“ - set by :ref:`envoy.filters.listener.http_inspector <config_listener_filters_http_inspector>`
//
// .. attention::
//
//	Currently, :ref:`TLS Inspector <config_listener_filters_tls_inspector>` provides
//	application protocol detection based on the requested
//	`ALPN <https://en.wikipedia.org/wiki/Application-Layer_Protocol_Negotiation>`_ values.
//
//	However, the use of ALPN is pretty much limited to the HTTP/2 traffic on the Internet,
//	and matching on values other than ``h2`` is going to lead to a lot of false negatives,
//	unless all connecting clients are known to use ALPN.
//
// [#extension: envoy.matching.inputs.application_protocol]
#ApplicationProtocolInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.ApplicationProtocolInput"
}

// Input that matches by a specific filter state key.
// The value of the provided filter state key will be the raw string representation of the filter state object
// [#extension: envoy.matching.inputs.filter_state]
#FilterStateInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.FilterStateInput"
	key?:    string
}

// Input that matches dynamic metadata by key.
// DynamicMetadataInput provides a general interface using “filter“ and “path“ to retrieve value from
// :ref:`Metadata <envoy_v3_api_msg_config.core.v3.Metadata>`.
//
// For example, for the following Metadata:
//
// .. code-block:: yaml
//
//	filter_metadata:
//	  envoy.xxx:
//	    prop:
//	      foo: bar
//	      xyz:
//	        hello: envoy
//
// The following DynamicMetadataInput will retrieve a string value "bar" from the Metadata.
//
// .. code-block:: yaml
//
//	filter: envoy.xxx
//	path:
//	- key: prop
//	- key: foo
//
// [#extension: envoy.matching.inputs.dynamic_metadata]
#DynamicMetadataInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.DynamicMetadataInput"
	// The filter name to retrieve the Struct from the Metadata.
	filter?: string
	// The path to retrieve the Value from the Struct.
	path?: [...#DynamicMetadataInput_PathSegment]
}

// Specifies the segment in a path to retrieve value from Metadata.
// Note: Currently it's not supported to retrieve a value from a list in Metadata. This means that
// if the segment key refers to a list, it has to be the last segment in a path.
#DynamicMetadataInput_PathSegment: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.network.v3.DynamicMetadataInput_PathSegment"
	// If specified, use the key to retrieve the value in a Struct.
	key?: string
}
