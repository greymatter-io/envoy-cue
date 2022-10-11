package v3

#AwsIamConfig: {
	"@type": "type.googleapis.com/envoy.config.grpc_credential.v3.AwsIamConfig"
	// The `service namespace
	// <https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#genref-aws-service-namespaces>`_
	// of the Grpc endpoint.
	//
	// Example: appmesh
	service_name?: string
	// The `region <https://docs.aws.amazon.com/general/latest/gr/rande.html>`_ hosting the Grpc
	// endpoint. If unspecified, the extension will use the value in the ``AWS_REGION`` environment
	// variable.
	//
	// Example: us-west-2
	region?: string
}
