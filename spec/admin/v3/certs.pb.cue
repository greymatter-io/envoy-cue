package v3

// Proto representation of certificate details. Admin endpoint uses this wrapper for ``/certs`` to
// display certificate information. See :ref:`/certs <operations_admin_interface_certs>` for more
// information.
#Certificates: {
	"@type": "type.googleapis.com/envoy.admin.v3.Certificates"
	// List of certificates known to an Envoy.
	certificates?: [...#Certificate]
}

#Certificate: {
	"@type": "type.googleapis.com/envoy.admin.v3.Certificate"
	// Details of CA certificate.
	ca_cert?: [...#CertificateDetails]
	// Details of Certificate Chain
	cert_chain?: [...#CertificateDetails]
}

// [#next-free-field: 8]
#CertificateDetails: {
	"@type": "type.googleapis.com/envoy.admin.v3.CertificateDetails"
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
	// Details related to the OCSP response associated with this certificate, if any.
	ocsp_details?: #CertificateDetails_OcspDetails
}

#SubjectAlternateName: {
	"@type":     "type.googleapis.com/envoy.admin.v3.SubjectAlternateName"
	dns?:        string
	uri?:        string
	ip_address?: string
}

#CertificateDetails_OcspDetails: {
	"@type": "type.googleapis.com/envoy.admin.v3.CertificateDetails_OcspDetails"
	// Indicates the time from which the OCSP response is valid.
	valid_from?: string
	// Indicates the time at which the OCSP response expires.
	expiration?: string
}
