package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

#BootstrapExtension: {
	"@type":        "type.googleapis.com/envoy.extensions.filters.common.workload_discovery.v3.BootstrapExtension"
	config_source?: v3.#ConfigSource
}
