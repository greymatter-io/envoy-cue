package v3

// Security token service configuration that allows Google gRPC to
// fetch security token from an OAuth 2.0 authorization server.
// See https://tools.ietf.org/html/draft-ietf-oauth-token-exchange-16 and
// https://github.com/grpc/grpc/pull/19587.
// [#not-implemented-hide:]
// [#next-free-field: 10]
#StsServiceCredentials: {
	"@type": "type.googleapis.com/envoy.extensions.grpc_service.call_credentials.sts_service.v3.StsServiceCredentials"
	// URI of the token exchange service that handles token exchange requests.
	// [#comment:TODO(asraa): Add URI validation when implemented. Tracked by
	// https://github.com/bufbuild/protoc-gen-validate/issues/303]
	token_exchange_service_uri?: string
	// Location of the target service or resource where the client
	// intends to use the requested security token.
	resource?: string
	// Logical name of the target service where the client intends to
	// use the requested security token.
	audience?: string
	// The desired scope of the requested security token in the
	// context of the service or resource where the token will be used.
	scope?: string
	// Type of the requested security token.
	requested_token_type?: string
	// The path of subject token, a security token that represents the
	// identity of the party on behalf of whom the request is being made.
	subject_token_path?: string
	// Type of the subject token.
	subject_token_type?: string
	// The path of actor token, a security token that represents the identity
	// of the acting party. The acting party is authorized to use the
	// requested security token and act on behalf of the subject.
	actor_token_path?: string
	// Type of the actor token.
	actor_token_type?: string
}
