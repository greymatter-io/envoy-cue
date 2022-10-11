package v3

import (
	v3 "envoyproxy.io/type/matcher/v3"
)

// Top level configuration for the AWS request signing filter.
// [#next-free-field: 6]
#AwsRequestSigning: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.aws_request_signing.v3.AwsRequestSigning"
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
	// :ref:`HCM host rewrite <envoy_v3_api_field_config.route.v3.RouteAction.host_rewrite_literal>` given that the
	// value set here would be used for signing whereas the value set in the HCM would be used
	// for host header forwarding which is not the desired outcome.
	host_rewrite?: string
	// Instead of buffering the request to calculate the payload hash, use the literal string ``UNSIGNED-PAYLOAD``
	// to calculate the payload hash. Not all services support this option. See the `S3
	// <https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-header-based-auth.html>`_ policy for details.
	use_unsigned_payload?: bool
	// A list of request header string matchers that will be excluded from signing. The excluded header can be matched by
	// any patterns defined in the StringMatcher proto (e.g. exact string, prefix, regex, etc).
	//
	// Example:
	// match_excluded_headers:
	// - prefix: x-envoy
	// - exact: foo
	// - exact: bar
	// When applied, all headers that start with "x-envoy" and headers "foo" and "bar" will not be signed.
	match_excluded_headers?: [...v3.#StringMatcher]
}
