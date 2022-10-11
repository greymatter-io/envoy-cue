package v3

import (
	v3 "envoyproxy.io/config/tap/v3"
)

// Common configuration for all tap extensions.
#CommonExtensionConfig: {
	"@type": "type.googleapis.com/envoy.extensions.common.tap.v3.CommonExtensionConfig"
	// If specified, the tap filter will be configured via an admin handler.
	admin_config?: #AdminConfig
	// If specified, the tap filter will be configured via a static configuration that cannot be
	// changed.
	static_config?: v3.#TapConfig
}

// Configuration for the admin handler. See :ref:`here <config_http_filters_tap_admin_handler>` for
// more information.
#AdminConfig: {
	"@type": "type.googleapis.com/envoy.extensions.common.tap.v3.AdminConfig"
	// Opaque configuration ID. When requests are made to the admin handler, the passed opaque ID is
	// matched to the configured filter opaque ID to determine which filter to configure.
	config_id?: string
}
