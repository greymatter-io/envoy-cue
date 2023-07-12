package v3

// CDN-Loop Header filter config. See the :ref:`configuration overview
// <config_http_filters_cdn_loop>` for more information.
#CdnLoopConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.cdn_loop.v3.CdnLoopConfig"
	// The CDN identifier to use for loop checks and to append to the
	// CDN-Loop header.
	//
	// RFC 8586 calls this the cdn-id. The cdn-id can either be a
	// pseudonym or hostname the CDN is in control of.
	//
	// cdn_id must not be empty.
	cdn_id?: string
	// The maximum allowed count of cdn_id in the downstream CDN-Loop
	// request header.
	//
	// The default of 0 means a request can transit the CdnLoopFilter
	// once. A value of 1 means that a request can transit the
	// CdnLoopFilter twice and so on.
	max_allowed_occurrences?: uint32
}
