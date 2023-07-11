package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/type/metadata/v3"
)

// Configuration for the internal upstream address. An internal address defines
// a loopback user space socket residing in the same proxy instance. This
// extension allows passing additional structured state across the user space
// socket in addition to the regular byte stream. The purpose is to facilitate
// communication between filters on the downstream and the upstream internal
// connections. All filter state objects that are shared with the upstream
// connection are also shared with the downstream internal connection using
// this transport socket.
#InternalUpstreamTransport: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.internal_upstream.v3.InternalUpstreamTransport"
	// Specifies the metadata namespaces and values to insert into the downstream
	// internal connection dynamic metadata when an internal address is used as a
	// host. If the destination name is repeated across two metadata source
	// locations, and both locations contain the metadata with the given name,
	// then the latter in the list overrides the former.
	passthrough_metadata?: [...#InternalUpstreamTransport_MetadataValueSource]
	// The underlying transport socket being wrapped.
	transport_socket?: v3.#TransportSocket
}

// Describes the location of the imported metadata value.
// If the metadata with the given name is not present at the source location,
// then no metadata is passed through for this particular instance.
#InternalUpstreamTransport_MetadataValueSource: {
	"@type": "type.googleapis.com/envoy.extensions.transport_sockets.internal_upstream.v3.InternalUpstreamTransport_MetadataValueSource"
	// Specifies what kind of metadata.
	kind?: v31.#MetadataKind
	// Name is the filter namespace used in the dynamic metadata.
	name?: string
}
