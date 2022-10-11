package v2

import (
	core "envoyproxy.io/api/v2/core"
)

#Config: {
	"@type": "type.googleapis.com/envoy.config.filter.network.direct_response.v2.Config"
	// Response data as a data source.
	response?: core.#DataSource
}
