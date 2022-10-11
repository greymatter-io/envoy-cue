package v3

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
)

#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.set_metadata.v3.Config"
	// The metadata namespace.
	metadata_namespace?: string
	// The value to update the namespace with. See
	// :ref:`the filter documentation <config_http_filters_set_metadata>` for
	// more information on how this value is merged with potentially existing
	// ones.
	value?: _struct.#Struct
}
