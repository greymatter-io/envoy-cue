package v3

import (
	durationpb "envoyproxy.io/deps/protobuf/types/known/durationpb"
	v3 "envoyproxy.io/type/matcher/v3"
)

#AwsRequestSigning_SigningAlgorithm: "AWS_SIGV4" | "AWS_SIGV4A"

AwsRequestSigning_SigningAlgorithm_AWS_SIGV4:  "AWS_SIGV4"
AwsRequestSigning_SigningAlgorithm_AWS_SIGV4A: "AWS_SIGV4A"

// Top level configuration for the AWS request signing filter.
// [#next-free-field: 8]
#AwsRequestSigning: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.aws_request_signing.v3.AwsRequestSigning"
	// The `service namespace
	// <https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#genref-aws-service-namespaces>`_
	// of the HTTP endpoint.
	//
	// Example: s3
	service_name?: string
	// Optional region string. If region is not provided, the region will be retrieved from the environment
	// or AWS configuration files. See :ref:`config_http_filters_aws_request_signing_region` for more details.
	//
	// When signing_algorithm is set to “AWS_SIGV4“ the region is a standard AWS `region <https://docs.aws.amazon.com/general/latest/gr/rande.html>`_ string for the service
	// hosting the HTTP endpoint.
	//
	// Example: us-west-2
	//
	// When signing_algorithm is set to “AWS_SIGV4A“ the region is used as a region set.
	//
	// A region set is a comma separated list of AWS regions, such as “us-east-1,us-east-2“ or wildcard “*“
	// or even region strings containing wildcards such as “us-east-*“
	//
	// Example: '*'
	//
	// By configuring a region set, a SigV4A signed request can be sent to multiple regions, rather than being
	// valid for only a single region destination.
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
	// Instead of buffering the request to calculate the payload hash, use the literal string “UNSIGNED-PAYLOAD“
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
	// Optional Signing algorithm specifier, either “AWS_SIGV4“ or “AWS_SIGV4A“, defaulting to “AWS_SIGV4“.
	signing_algorithm?: #AwsRequestSigning_SigningAlgorithm
	// If set, use the query string to store output of SigV4 or SigV4A calculation, rather than HTTP headers. The “Authorization“ header will not be modified if “query_string“
	// is configured.
	//
	// Example:
	// query_string: {}
	query_string?: #AwsRequestSigning_QueryString
}

#AwsRequestSigningPerRoute: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.aws_request_signing.v3.AwsRequestSigningPerRoute"
	// Override the global configuration of the filter with this new config.
	// This overrides the entire message of AwsRequestSigning and not at field level.
	aws_request_signing?: #AwsRequestSigning
	// The human readable prefix to use when emitting stats.
	stat_prefix?: string
}

#AwsRequestSigning_QueryString: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.aws_request_signing.v3.AwsRequestSigning_QueryString"
	// Optional expiration time for the query string parameters. As query string parameter based requests are replayable, in effect representing
	// an API call that has already been authenticated, it is recommended to keep this expiration time as short as feasible.
	// This value will default to 5 seconds and has a maximum value of 3600 seconds (1 hour).
	expiration_time?: durationpb.#Duration
}
