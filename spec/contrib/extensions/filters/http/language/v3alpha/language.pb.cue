package v3alpha

// Language detection filter config.
#Language: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.language.v3alpha.Language"
	// The default language to be used as a fallback.
	// The value will be included in the list of the supported languages.
	//
	// See https://unicode-org.github.io/icu/userguide/locale/
	default_language?: string
	// The set of supported languages. There is no order priority.
	// The order will be determined by the Accept-Language header priority list
	// of the client.
	//
	// See https://unicode-org.github.io/icu/userguide/locale/
	supported_languages?: [...string]
	// If the x-language header is altered, clear the route cache for the current request.
	// This should be set if the route configuration may depend on the x-language header.
	// Otherwise it should be unset to avoid the performance cost of route recalculation.
	clear_route_cache?: bool
}
