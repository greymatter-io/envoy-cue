package v3alpha

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/matcher/v3"
)

#ChecksumConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.checksum.v3alpha.ChecksumConfig"
	// A set of matcher and checksum pairs for which, if a path matching “path_matcher“
	// is requested and the checksum of the response body does not match the “sha256“, the
	// response will be replaced with a 403 Forbidden status.
	//
	// If multiple matchers match the same path, the first to match takes precedence.
	checksums?: [...#ChecksumConfig_Checksum]
	// If a request doesn't match any of the specified checksum paths and reject_unmatched is
	// true, the request is rejected immediately with 403 Forbidden.
	reject_unmatched?: bool
}

#ChecksumConfig_Checksum: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.checksum.v3alpha.ChecksumConfig_Checksum"
	// A matcher for a path that is expected to have a specific checksum, as specified
	// in the “sha256“ field.
	path_matcher?: v3.#StringMatcher
	// A hex-encoded sha256 string required to match the sha256sum of the response body
	// of the path specified in the “path_matcher“ field.
	sha256?: string
}
