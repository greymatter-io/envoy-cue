package v2alpha

// Top level configuration for the AWS request signing filter.
#AwsRequestSigning: {
	"@type": "type.googleapis.com/envoy.config.filter.http.aws_request_signing.v2alpha.AwsRequestSigning"
	// The `service namespace
	// <https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#genref-aws-service-namespaces>`_
	// of the HTTP endpoint.
	//
	// Example: s3
	service_name?: string
	// The `region <https://docs.aws.amazon.com/general/latest/gr/rande.html>`_ hosting the HTTP
	// endpoint.
	//
	// Example: us-west-2
	region?: string
	// Indicates that before signing headers, the host header will be swapped with
	// this value. If not set or empty, the original host header value
	// will be used and no rewrite will happen.
	//
	// Note: this rewrite affects both signing and host header forwarding. However, this
	// option shouldn't be used with
	// :ref:`HCM host rewrite <envoy_api_field_route.RouteAction.host_rewrite>` given that the
	// value set here would be used for signing whereas the value set in the HCM would be used
	// for host header forwarding which is not the desired outcome.
	host_rewrite?: string
}
