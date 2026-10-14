package v3alpha

#ClientCertConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.client_cert.v3alpha.ClientCertConfig"
	// If true, the optional ``Client-Cert-Chain`` header is also emitted, containing the
	// validated certificate chain of the downstream client certificate (excluding the leaf
	// certificate, which is carried by ``Client-Cert``). Disabled by default because the
	// header can be large for long certificate chains.
	set_client_cert_chain?: bool
}
