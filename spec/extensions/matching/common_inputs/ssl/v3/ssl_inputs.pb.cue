package v3

// List of comma-delimited URIs in the SAN field of the peer certificate for a downstream.
// [#extension: envoy.matching.inputs.uri_san]
#UriSanInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.ssl.v3.UriSanInput"
}

// List of comma-delimited DNS entries in the SAN field of the peer certificate for a downstream.
// [#extension: envoy.matching.inputs.dns_san]
#DnsSanInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.ssl.v3.DnsSanInput"
}

// Input that matches the subject field of the peer certificate in RFC 2253 format for a
// downstream.
// [#extension: envoy.matching.inputs.subject]
#SubjectInput: {
	"@type": "type.googleapis.com/envoy.extensions.matching.common_inputs.ssl.v3.SubjectInput"
}
