package v3

import (
	wrapperspb "envoyproxy.io/deps/protobuf/types/known/wrapperspb"
)

// Configuration for internal listener.
#InternalListener: {
	"@type": "type.googleapis.com/envoy.extensions.bootstrap.internal_listener.v3.InternalListener"
	// The internal listener client connection buffer size in KiB.
	// For example, if “buffer_size_kb“ is set to 5, then the actual buffer size is
	// 5 KiB = 5 * 1024 bytes.
	// If the “buffer_size_kb“ is not specified, the buffer size is set to 1024 KiB.
	buffer_size_kb?: wrapperspb.#UInt32Value
}
