package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// Validation of a bearer JWT. A consuming extension verifies the token against the configured JWKS,
// issuer, audiences, and time constraints. On success it publishes the verified claims as dynamic
// metadata under “claims_metadata_namespace“, so the consumer can bind a claimed identifier to a
// verified claim via “%DYNAMIC_METADATA(namespace:claim)%“. What a validation failure does, and
// any per-field defaults, are defined by the consuming extension.
//
// .. attention::
//
//	Verifying the token proves only that the caller *holds* a valid token; it does **not** by itself
//	prove the caller is the identity it claims. To authenticate the claimed identity, bind a verified
//	claim from the consuming extension's own validation configuration. Without such a binding, a token
//	minted for one identity can be presented for another. Tokens without an ``exp`` claim are
//	rejected. All top-level claims are published as dynamic metadata (see
//	``claims_metadata_namespace``), so do not put secrets in the token.
//
// [#next-free-field: 9]
#JwtHandshakeValidator: {
	"@type": "type.googleapis.com/envoy.extensions.filters.common.jwks.v3.JwtHandshakeValidator"
	// Required. Expected token issuer. The JWT ``iss`` claim must equal this value.
	issuer?: string
	// Allowed audiences. If non-empty, the JWT must carry at least one of these in its ``aud`` claim.
	// If empty, the audience is not checked.
	audiences?: [...string]
	// The JWKS provided inline as a data source (``inline_string``, ``inline_bytes``, or
	// ``filename``). The keys are read once when the configuration is loaded.
	local_jwks?: v3.#DataSource
	// The JWKS fetched over HTTP. See :ref:`RemoteJwks
	// <envoy_v3_api_msg_extensions.filters.common.jwks.v3.RemoteJwks>` for the fetch, cache,
	// ``async_fetch``, and ``retry_policy`` options.
	remote_jwks?: #RemoteJwks
	// Name of the header carrying the token. When unset, the consuming extension applies its own
	// default (commonly ``authorization``, with a leading ``Bearer`` prefix stripped).
	token_header?: string
	// Namespace under which verified claims are emitted as dynamic metadata. If unset, the consuming
	// extension's default namespace is used. Each top-level JWT claim is written as a field in this
	// namespace so it can be referenced via ``%DYNAMIC_METADATA(namespace:claim)%`` by the consuming
	// extension's validation configuration.
	claims_metadata_namespace?: string
	// If ``true``, a missing or invalid token does **not** fail validation; the verified claims are
	// simply not published. Useful for a staged rollout or audit mode. Defaults to ``false``. How a
	// validation failure is handled is defined by the consuming extension.
	allow_missing_or_failed?: bool
	// Clock skew, in seconds, allowed when checking the ``exp`` and ``nbf`` time constraints. When
	// unset (``0``), the consuming extension applies its own default.
	clock_skew_seconds?: uint32
}
