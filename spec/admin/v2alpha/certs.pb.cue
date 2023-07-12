package v2alpha

// Proto representation of certificate details. Admin endpoint uses this wrapper for `/certs` to
// display certificate information. See :ref:`/certs <operations_admin_interface_certs>` for more
// information.
#Certificates: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.Certificates"
	// List of certificates known to an Envoy.
	certificates?: [...#Certificate]
}

#Certificate: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.Certificate"
	// Details of CA certificate.
	ca_cert?: [...#CertificateDetails]
	// Details of Certificate Chain
	cert_chain?: [...#CertificateDetails]
}

// [#next-free-field: 7]
#CertificateDetails: {
	"@type": "type.googleapis.com/envoy.admin.v2alpha.CertificateDetails"
	// Path of the certificate.
	path?: string
	// Certificate Serial Number.
	serial_number?: string
	// List of Subject Alternate names.
	subject_alt_names?: [...#SubjectAlternateName]
	// Minimum of days until expiration of certificate and it's chain.
	days_until_expiration?: uint64
	// Indicates the time from which the certificate is valid.
	valid_from?: string
	// Indicates the time at which the certificate expires.
	expiration_time?: string
}

#SubjectAlternateName: {
	"@type":     "type.googleapis.com/envoy.admin.v2alpha.SubjectAlternateName"
	dns?:        string
	uri?:        string
	ip_address?: string
}
