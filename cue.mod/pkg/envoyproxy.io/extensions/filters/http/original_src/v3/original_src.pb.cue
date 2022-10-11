package v3

// The Original Src filter binds upstream connections to the original source address determined
// for the request. This address could come from something like the Proxy Protocol filter, or it
// could come from trusted http headers.
// [#extension: envoy.filters.http.original_src]
#OriginalSrc: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.original_src.v3.OriginalSrc"
	// Sets the SO_MARK option on the upstream connection's socket to the provided value. Used to
	// ensure that non-local addresses may be routed back through envoy when binding to the original
	// source address. The option will not be applied if the mark is 0.
	mark?: uint32
}
