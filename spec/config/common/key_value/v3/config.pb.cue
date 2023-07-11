package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// This shared configuration for Envoy key value stores.
#KeyValueStoreConfig: {
	"@type": "type.googleapis.com/envoy.config.common.key_value.v3.KeyValueStoreConfig"
	// [#extension-category: envoy.common.key_value]
	config?: v3.#TypedExtensionConfig
}
