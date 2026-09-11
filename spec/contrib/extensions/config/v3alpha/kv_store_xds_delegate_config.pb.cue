package v3alpha

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/common/key_value/v3"
)

// [#extension: envoy.xds_delegates.kv_store]
//
// Configuration for a KeyValueStore-based XdsResourcesDelegate implementation. This implementation
// updates the underlying KV store with xDS resources received from the configured management
// servers, enabling configuration to be persisted locally and used on startup in case connectivity
// with the xDS management servers could not be established.
//
// The KV Store based delegate's handling of wildcard resources (empty resource list or "*") is
// designed for use with O(100) resources or fewer, so it's not currently advised to use this
// feature for large configurations with heavy use of wildcard resources.
#KeyValueStoreXdsDelegateConfig: {
	"@type": "type.googleapis.com/envoy.extensions.config.v3alpha.KeyValueStoreXdsDelegateConfig"
	// Configuration for the KeyValueStore that holds the xDS resources.
	// [#allow-fully-qualified-name:]
	key_value_store_config?: v3.#KeyValueStoreConfig
}
