package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Configuration for AWS credential provider. This is optional and the credentials are normally
// retrieved from the environment or AWS configuration files by following the default credential
// provider chain. However, this configuration can be used to override the default behavior.
// [#next-free-field: 11]
#AwsCredentialProvider: {
	"@type": "type.googleapis.com/envoy.extensions.common.aws.v3.AwsCredentialProvider"
	// The option to use `AssumeRoleWithWebIdentity <https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRoleWithWebIdentity.html>`_.
	assume_role_with_web_identity_provider?: #AssumeRoleWithWebIdentityCredentialProvider
	// The option to use an inline credential. If inline credential is provided, no chain will be created and only the inline credential will be used.
	inline_credential?: #InlineCredentialProvider
	// The option to specify parameters for credential retrieval from an envoy data source, such as a file in AWS credential format.
	credentials_file_provider?: #CredentialsFileCredentialProvider
	// Create a custom credential provider chain instead of the default credential provider chain.
	// If set to TRUE, the credential provider chain that is created contains only those set in this credential provider message.
	// If set to FALSE, the settings provided here will act as modifiers to the default credential provider chain.
	// Defaults to FALSE.
	//
	// This has no effect if inline_credential is provided.
	custom_credential_provider_chain?: bool
	// The option to use `IAM Roles Anywhere <https://docs.aws.amazon.com/rolesanywhere/latest/userguide/introduction.html>`_.
	iam_roles_anywhere_credential_provider?: #IAMRolesAnywhereCredentialProvider
	// The option to use credentials sourced from standard `AWS configuration files <https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html>`_.
	config_credential_provider?: #ConfigCredentialProvider
	// The option to use credentials sourced from `container environment variables <https://docs.aws.amazon.com/sdkref/latest/guide/feature-container-credentials.html>`_.
	container_credential_provider?: #ContainerCredentialProvider
	// The option to use credentials sourced from `environment variables <https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html>`_.
	environment_credential_provider?: #EnvironmentCredentialProvider
	// The option to use credentials sourced from an EC2 `Instance Profile <https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html>`_.
	instance_profile_credential_provider?: #InstanceProfileCredentialProvider
	// The option to use `STS:AssumeRole aka Role Chaining <https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html>`_.
	assume_role_credential_provider?: #AssumeRoleCredentialProvider
}

// Configuration to use an inline AWS credential. This is an equivalent to setting the well-known
// environment variables “AWS_ACCESS_KEY_ID“, “AWS_SECRET_ACCESS_KEY“, and the optional “AWS_SESSION_TOKEN“.
#InlineCredentialProvider: {
	"@type": "type.googleapis.com/envoy.extensions.common.aws.v3.InlineCredentialProvider"
	// The AWS access key ID.
	access_key_id?: string
	// The AWS secret access key.
	secret_access_key?: string
	// The AWS session token. This is optional.
	session_token?: string
}

// Configuration to use `AssumeRoleWithWebIdentity <https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRoleWithWebIdentity.html>`_
// to retrieve AWS credentials.
#AssumeRoleWithWebIdentityCredentialProvider: {
	"@type": "type.googleapis.com/envoy.extensions.common.aws.v3.AssumeRoleWithWebIdentityCredentialProvider"
	// Data source for a web identity token that is provided by the identity provider to assume the role.
	// If a “watched_directory“ is not provided, one will be automatically inferred from the directory of the token file. This is to ensure
	// that if the token file is rotated, the new token will be picked up. This behaviour differs from the standard envoy data source behavior, which does not
	// automatically watch the directory of a file data source.
	// Even when file rotation occurs, current credentials will continue to be used until they expire, at which point new credentials will be retrieved using the new token.
	web_identity_token_data_source?: v3.#DataSource
	// The ARN of the role to assume.
	role_arn?: string
	// Optional role session name to use in AssumeRoleWithWebIdentity API call.
	role_session_name?: string
}

#CredentialsFileCredentialProvider: {
	"@type": "type.googleapis.com/envoy.extensions.common.aws.v3.CredentialsFileCredentialProvider"
	// Data source from which to retrieve AWS credentials
	// When using this data source, if a “watched_directory“ is provided, the credential file will be re-read when a file move is detected.
	// See :ref:`watched_directory <envoy_v3_api_msg_config.core.v3.DataSource>` for more information about the “watched_directory“ field.
	credentials_data_source?: v3.#DataSource
	// The profile within the credentials_file data source. If not provided, the default profile will be used.
	profile?: string
}

// Configuration to use `IAM Roles Anywhere <https://docs.aws.amazon.com/rolesanywhere/latest/userguide/introduction.html>`_
// to retrieve AWS credentials.
// [#next-free-field: 9]
#IAMRolesAnywhereCredentialProvider: {
	"@type": "type.googleapis.com/envoy.extensions.common.aws.v3.IAMRolesAnywhereCredentialProvider"
	// The ARN of the role to assume via the IAM Roles Anywhere sessions API. See `Configure Roles <https://docs.aws.amazon.com/rolesanywhere/latest/userguide/getting-started.html#getting-started-step2>`_ for more details.
	role_arn?: string
	// The certificate used for authenticating to the IAM Roles Anywhere service.
	// This certificate must match one configured in the IAM Roles Anywhere profile. See `Configure Roles <https://docs.aws.amazon.com/rolesanywhere/latest/userguide/getting-started.html#getting-started-step2>`_ for more details.
	certificate?: v3.#DataSource
	// The optional certificate chain, required when you are using a subordinate certificate authority for certificate issuance.
	// A certificate chain can contain a maximum of 5 elements, see `The IAM Roles Anywhere authentication process <https://docs.aws.amazon.com/rolesanywhere/latest/userguide/authentication.html>`_ for more details.
	certificate_chain?: v3.#DataSource
	// The TLS private key matching the certificate provided.
	private_key?: v3.#DataSource
	// The arn of the IAM Roles Anywhere trust anchor configured in your AWS account. A trust anchor in IAM Roles anywhere establishes
	// trust between your certificate authority (CA) and AWS. See `Establish trust <https://docs.aws.amazon.com/rolesanywhere/latest/userguide/getting-started.html#getting-started-step1>`_ for more details.
	trust_anchor_arn?: string
	// The IAM Roles Anywhere profile ARN configured in your AWS account.
	profile_arn?: string
	// An optional role session name, used when identifying the role in subsequent AWS API calls.
	role_session_name?: string
	// An optional session duration, used when calculating the maximum time before vended credentials expire. This value cannot exceed the value configured
	// in the IAM Roles Anywhere profile and the resultant session duration is calculate by the formula `here <https://docs.aws.amazon.com/rolesanywhere/latest/userguide/authentication-create-session.html#credentials-object>`_.
	// If no session duration is provided here, the session duration is sourced from the IAM Roles Anywhere profile.
	session_duration?: string
}

// The Config Credential Provider has no configurable parameters, but listing it in a custom credential provider chain will enable this
// credential provider.
#ConfigCredentialProvider: {
	"@type": "type.googleapis.com/envoy.extensions.common.aws.v3.ConfigCredentialProvider"
}

// The Container Credential Provider has no configurable parameters, but listing it in a custom credential provider chain will enable this
// credential provider.
#ContainerCredentialProvider: {
	"@type": "type.googleapis.com/envoy.extensions.common.aws.v3.ContainerCredentialProvider"
}

// The Environment Credential Provider has no configurable parameters, but listing it in a custom credential provider chain will enable this
// credential provider.
#EnvironmentCredentialProvider: {
	"@type": "type.googleapis.com/envoy.extensions.common.aws.v3.EnvironmentCredentialProvider"
}

// The Instance Profile Credential Provider has no configurable parameters, but listing it in a custom credential provider chain will enable this
// credential provider.
#InstanceProfileCredentialProvider: {
	"@type": "type.googleapis.com/envoy.extensions.common.aws.v3.InstanceProfileCredentialProvider"
}

// Configuration to use `AssumeRole <https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html>`_ for retrieving new credentials, via role chaining.
// [#next-free-field: 6]
#AssumeRoleCredentialProvider: {
	"@type": "type.googleapis.com/envoy.extensions.common.aws.v3.AssumeRoleCredentialProvider"
	// The ARN of the role to assume.
	role_arn?: string
	// An optional role session name, used when identifying the role in subsequent AWS API calls. If not provided, the role session name will default
	// to the current timestamp.
	role_session_name?: string
	// Optional string value to use as the externalId
	external_id?: string
	// An optional duration, in seconds, of the role session. Minimum role duration is 900s (5 minutes) and maximum is 43200s (12 hours).
	// If the session duration is not provided, the default will be determined using the `table described here <https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_manage-assume.html>`_.
	session_duration?: string
	// The credential provider for signing the AssumeRole request. This is optional and if not set,
	// it will be retrieved from the procedure described in :ref:`config_http_filters_aws_request_signing`.
	// This list of credential providers cannot include an AssumeRole credential provider and if one is provided
	// it will be ignored.
	credential_provider?: #AwsCredentialProvider
}
