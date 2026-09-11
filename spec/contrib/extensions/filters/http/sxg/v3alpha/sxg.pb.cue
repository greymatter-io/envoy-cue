package v3alpha

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/transport_sockets/tls/v3"
)

// [#next-free-field: 10]
#SXG: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.sxg.v3alpha.SXG"
	// The SDS configuration for the public key data for the SSL certificate that will be used to sign the
	// SXG response.
	certificate?: v3.#SdsSecretConfig
	// The SDS configuration for the private key data for the SSL certificate that will be used to sign the
	// SXG response.
	private_key?: v3.#SdsSecretConfig
	// The duration for which the generated SXG package will be valid. Default is 604800s (7 days in seconds).
	// Note that in order to account for clock skew, the timestamp will be backdated by a day. So, if duration
	// is set to 7 days, that will be 7 days from 24 hours ago (6 days from now). Also note that while 6/7 days
	// is appropriate for most content, if the downstream service is serving Javascript, or HTML with inline
	// Javascript, 1 day (so, with backdated expiry, 2 days, or 172800 seconds) is more appropriate.
	duration?: string
	// The SXG response payload is Merkle Integrity Content Encoding (MICE) encoded (specification is [here](https://datatracker.ietf.org/doc/html/draft-thomson-http-mice-03))
	// This value indicates the record size in the encoded payload. The default value is 4096.
	mi_record_size?: uint64
	// The URI of certificate CBOR file published. Since it is required that the certificate CBOR file
	// be served from the same domain as the SXG document, this should be a relative URI.
	cbor_url?: string
	// URL to retrieve validity data for signature, a CBOR map. See specification [here](https://tools.ietf.org/html/draft-yasskin-httpbis-origin-signed-exchanges-impl-00#section-3.6)
	validity_url?: string
	// Header that will be set if it is determined that the client can accept SXG (typically “accept: application/signed-exchange;v=b3“)
	// If not set, filter will default to: “x-client-can-accept-sxg“
	client_can_accept_sxg_header?: string
	// Header set by downstream service to signal that the response should be transformed to SXG If not set,
	// filter will default to: “x-should-encode-sxg“
	should_encode_sxg_header?: string
	// Headers that will be stripped from the SXG document, by listing a prefix (i.e. “x-custom-“ will cause
	// all headers prefixed by “x-custom-“ to be omitted from the SXG document)
	header_prefix_filters?: [...string]
}
