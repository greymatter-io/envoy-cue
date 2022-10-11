package v3

import (
	v3 "envoyproxy.io/config/core/v3"
)

#Config: {
	"@type": "type.googleapis.com/envoy.extensions.filters.network.direct_response.v3.Config"
	// Response data as a data source.
	response?: v3.#DataSource
}
