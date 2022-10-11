package core

import (
	_struct "envoyproxy.io/deps/golang/protobuf/ptypes/struct"
	emptypb "envoyproxy.io/deps/protobuf/types/known/emptypb"
)

// gRPC service configuration. This is used by :ref:`ApiConfigSource
// <envoy_api_msg_core.ApiConfigSource>` and filter configurations.
// [#next-free-field: 6]
#GrpcService: {
	"@type": "type.googleapis.com/envoy.api.v2.core.GrpcService"
	// Envoy's in-built gRPC client.
	// See the :ref:`gRPC services overview <arch_overview_grpc_services>`
	// documentation for discussion on gRPC client selection.
	envoy_grpc?: #GrpcService_EnvoyGrpc
	// `Google C++ gRPC client <https://github.com/grpc/grpc>`_
	// See the :ref:`gRPC services overview <arch_overview_grpc_services>`
	// documentation for discussion on gRPC client selection.
	google_grpc?: #GrpcService_GoogleGrpc
	// The timeout for the gRPC request. This is the timeout for a specific
	// request.
	timeout?: string
	// Additional metadata to include in streams initiated to the GrpcService.
	// This can be used for scenarios in which additional ad hoc authorization
	// headers (e.g. ``x-foo-bar: baz-key``) are to be injected.
	initial_metadata?: [...#HeaderValue]
}

#GrpcService_EnvoyGrpc: {
	"@type": "type.googleapis.com/envoy.api.v2.core.GrpcService_EnvoyGrpc"
	// The name of the upstream gRPC cluster. SSL credentials will be supplied
	// in the :ref:`Cluster <envoy_api_msg_Cluster>` :ref:`transport_socket
	// <envoy_api_field_Cluster.transport_socket>`.
	cluster_name?: string
}

// [#next-free-field: 7]
#GrpcService_GoogleGrpc: {
	"@type": "type.googleapis.com/envoy.api.v2.core.GrpcService_GoogleGrpc"
	// The target URI when using the `Google C++ gRPC client
	// <https://github.com/grpc/grpc>`_. SSL credentials will be supplied in
	// :ref:`channel_credentials <envoy_api_field_core.GrpcService.GoogleGrpc.channel_credentials>`.
	target_uri?:          string
	channel_credentials?: #GrpcService_GoogleGrpc_ChannelCredentials
	// A set of call credentials that can be composed with `channel credentials
	// <https://grpc.io/docs/guides/auth.html#credential-types>`_.
	call_credentials?: [...#GrpcService_GoogleGrpc_CallCredentials]
	// The human readable prefix to use when emitting statistics for the gRPC
	// service.
	//
	// .. csv-table::
	//    :header: Name, Type, Description
	//    :widths: 1, 1, 2
	//
	//    streams_total, Counter, Total number of streams opened
	//    streams_closed_<gRPC status code>, Counter, Total streams closed with <gRPC status code>
	stat_prefix?: string
	// The name of the Google gRPC credentials factory to use. This must have been registered with
	// Envoy. If this is empty, a default credentials factory will be used that sets up channel
	// credentials based on other configuration parameters.
	credentials_factory_name?: string
	// Additional configuration for site-specific customizations of the Google
	// gRPC library.
	config?: _struct.#Struct
}

// See https://grpc.io/grpc/cpp/structgrpc_1_1_ssl_credentials_options.html.
#GrpcService_GoogleGrpc_SslCredentials: {
	"@type": "type.googleapis.com/envoy.api.v2.core.GrpcService_GoogleGrpc_SslCredentials"
	// PEM encoded server root certificates.
	root_certs?: #DataSource
	// PEM encoded client private key.
	private_key?: #DataSource
	// PEM encoded client certificate chain.
	cert_chain?: #DataSource
}

// Local channel credentials. Only UDS is supported for now.
// See https://github.com/grpc/grpc/pull/15909.
#GrpcService_GoogleGrpc_GoogleLocalCredentials: {
	"@type": "type.googleapis.com/envoy.api.v2.core.GrpcService_GoogleGrpc_GoogleLocalCredentials"
}

// See https://grpc.io/docs/guides/auth.html#credential-types to understand Channel and Call
// credential types.
#GrpcService_GoogleGrpc_ChannelCredentials: {
	"@type":          "type.googleapis.com/envoy.api.v2.core.GrpcService_GoogleGrpc_ChannelCredentials"
	ssl_credentials?: #GrpcService_GoogleGrpc_SslCredentials
	// https://grpc.io/grpc/cpp/namespacegrpc.html#a6beb3ac70ff94bd2ebbd89b8f21d1f61
	google_default?:    emptypb.#Empty
	local_credentials?: #GrpcService_GoogleGrpc_GoogleLocalCredentials
}

// [#next-free-field: 8]
#GrpcService_GoogleGrpc_CallCredentials: {
	"@type": "type.googleapis.com/envoy.api.v2.core.GrpcService_GoogleGrpc_CallCredentials"
	// Access token credentials.
	// https://grpc.io/grpc/cpp/namespacegrpc.html#ad3a80da696ffdaea943f0f858d7a360d.
	access_token?: string
	// Google Compute Engine credentials.
	// https://grpc.io/grpc/cpp/namespacegrpc.html#a6beb3ac70ff94bd2ebbd89b8f21d1f61
	google_compute_engine?: emptypb.#Empty
	// Google refresh token credentials.
	// https://grpc.io/grpc/cpp/namespacegrpc.html#a96901c997b91bc6513b08491e0dca37c.
	google_refresh_token?: string
	// Service Account JWT Access credentials.
	// https://grpc.io/grpc/cpp/namespacegrpc.html#a92a9f959d6102461f66ee973d8e9d3aa.
	service_account_jwt_access?: #GrpcService_GoogleGrpc_CallCredentials_ServiceAccountJWTAccessCredentials
	// Google IAM credentials.
	// https://grpc.io/grpc/cpp/namespacegrpc.html#a9fc1fc101b41e680d47028166e76f9d0.
	google_iam?: #GrpcService_GoogleGrpc_CallCredentials_GoogleIAMCredentials
	// Custom authenticator credentials.
	// https://grpc.io/grpc/cpp/namespacegrpc.html#a823c6a4b19ffc71fb33e90154ee2ad07.
	// https://grpc.io/docs/guides/auth.html#extending-grpc-to-support-other-authentication-mechanisms.
	from_plugin?: #GrpcService_GoogleGrpc_CallCredentials_MetadataCredentialsFromPlugin
	// Custom security token service which implements OAuth 2.0 token exchange.
	// https://tools.ietf.org/html/draft-ietf-oauth-token-exchange-16
	// See https://github.com/grpc/grpc/pull/19587.
	sts_service?: #GrpcService_GoogleGrpc_CallCredentials_StsService
}

#GrpcService_GoogleGrpc_CallCredentials_ServiceAccountJWTAccessCredentials: {
	"@type":                 "type.googleapis.com/envoy.api.v2.core.GrpcService_GoogleGrpc_CallCredentials_ServiceAccountJWTAccessCredentials"
	json_key?:               string
	token_lifetime_seconds?: uint64
}

#GrpcService_GoogleGrpc_CallCredentials_GoogleIAMCredentials: {
	"@type":              "type.googleapis.com/envoy.api.v2.core.GrpcService_GoogleGrpc_CallCredentials_GoogleIAMCredentials"
	authorization_token?: string
	authority_selector?:  string
}

#GrpcService_GoogleGrpc_CallCredentials_MetadataCredentialsFromPlugin: {
	"@type": "type.googleapis.com/envoy.api.v2.core.GrpcService_GoogleGrpc_CallCredentials_MetadataCredentialsFromPlugin"
	name?:   string
	// Deprecated: Do not use.
	config?:       _struct.#Struct
	typed_config?: _
}

// Security token service configuration that allows Google gRPC to
// fetch security token from an OAuth 2.0 authorization server.
// See https://tools.ietf.org/html/draft-ietf-oauth-token-exchange-16 and
// https://github.com/grpc/grpc/pull/19587.
// [#next-free-field: 10]
#GrpcService_GoogleGrpc_CallCredentials_StsService: {
	"@type": "type.googleapis.com/envoy.api.v2.core.GrpcService_GoogleGrpc_CallCredentials_StsService"
	// URI of the token exchange service that handles token exchange requests.
	// [#comment:TODO(asraa): Add URI validation when implemented. Tracked by
	// https://github.com/envoyproxy/protoc-gen-validate/issues/303]
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
