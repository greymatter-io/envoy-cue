package v3

import (
	status "envoyproxy.io/envoy-cue/spec/deps/genproto/googleapis/rpc/status"
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
	v31 "envoyproxy.io/envoy-cue/spec/deps/cncf/xds/go/xds/type/matcher/v3"
	v32 "envoyproxy.io/envoy-cue/spec/type/v3"
)

// Configures the Rate Limit Quota filter.
//
// Can be overridden in the per-route and per-host configurations.
// The more specific definition completely overrides the less specific definition.
// [#next-free-field: 7]
#RateLimitQuotaFilterConfig: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaFilterConfig"
	// Configures the gRPC Rate Limit Quota Service (RLQS) RateLimitQuotaService.
	rlqs_server?: v3.#GrpcService
	// The application domain to use when calling the service. This enables sharing the quota
	// server between different applications without fear of overlap.
	// E.g., "envoy".
	domain?: string
	// The match tree to use for grouping incoming requests into buckets.
	//
	// Example:
	//
	// .. validated-code-block:: yaml
	//   :type-name: xds.type.matcher.v3.Matcher
	//
	//   matcher_list:
	//     matchers:
	//     # Assign requests with header['env'] set to 'staging' to the bucket { name: 'staging' }
	//     - predicate:
	//         single_predicate:
	//           input:
	//             typed_config:
	//               '@type': type.googleapis.com/envoy.type.matcher.v3.HttpRequestHeaderMatchInput
	//               header_name: env
	//           value_match:
	//             exact: staging
	//       on_match:
	//         action:
	//           typed_config:
	//             '@type': type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings
	//             bucket_id_builder:
	//               bucket_id_builder:
	//                 name:
	//                   string_value: staging
	//
	//     # Assign requests with header['user_group'] set to 'admin' to the bucket { acl: 'admin_users' }
	//     - predicate:
	//         single_predicate:
	//           input:
	//             typed_config:
	//               '@type': type.googleapis.com/xds.type.matcher.v3.HttpAttributesCelMatchInput
	//           custom_match:
	//             typed_config:
	//               '@type': type.googleapis.com/xds.type.matcher.v3.CelMatcher
	//               expr_match:
	//                 # Shortened for illustration purposes. Here should be parsed CEL expression:
	//                 # request.headers['user_group'] == 'admin'
	//                 parsed_expr: {}
	//       on_match:
	//         action:
	//           typed_config:
	//             '@type': type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings
	//             bucket_id_builder:
	//               bucket_id_builder:
	//                 acl:
	//                   string_value: admin_users
	//
	//   # Catch-all clause for the requests not matched by any of the matchers.
	//   # In this example, deny all requests.
	//   on_no_match:
	//     action:
	//       typed_config:
	//         '@type': type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings
	//         no_assignment_behavior:
	//           fallback_rate_limit:
	//             blanket_rule: DENY_ALL
	//
	// .. attention::
	//  The first matched group wins. Once the request is matched into a bucket, matcher
	//  evaluation ends.
	//
	// Use ``on_no_match`` field to assign the catch-all bucket. If a request is not matched
	// into any bucket, and there's no  ``on_no_match`` field configured, the request will be
	// ALLOWED by default. It will NOT be reported to the RLQS server.
	//
	// Refer to :ref:`Unified Matcher API <envoy_v3_api_msg_.xds.type.matcher.v3.Matcher>`
	// documentation for more information on the matcher trees.
	bucket_matchers?: v31.#Matcher
	// If set, this will enable -- but not necessarily enforce -- the rate limit for the given
	// fraction of requests.
	//
	// Defaults to 100% of requests.
	filter_enabled?: v3.#RuntimeFractionalPercent
	// If set, this will enforce the rate limit decisions for the given fraction of requests.
	// For requests that are not enforced the filter will still obtain the quota and include it
	// in the load computation, however the request will always be allowed regardless of the outcome
	// of quota application. This allows validation or testing of the rate limiting service
	// infrastructure without disrupting existing traffic.
	//
	// Note: this only applies to the fraction of enabled requests.
	//
	// Defaults to 100% of requests.
	filter_enforced?: v3.#RuntimeFractionalPercent
	// Specifies a list of HTTP headers that should be added to each request that
	// has been rate limited and is also forwarded upstream. This can only occur when the
	// filter is enabled but not enforced.
	request_headers_to_add_when_not_enforced?: [...v3.#HeaderValueOption]
}

// Per-route and per-host configuration overrides. The more specific definition completely
// overrides the less specific definition.
#RateLimitQuotaOverride: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaOverride"
	// The application domain to use when calling the service. This enables sharing the quota
	// server between different applications without fear of overlap.
	// E.g., "envoy".
	//
	// If empty, inherits the value from the less specific definition.
	domain?: string
	// The match tree to use for grouping incoming requests into buckets.
	//
	// If set, fully overrides the bucket matchers provided on the less specific definition.
	// If not set, inherits the value from the less specific definition.
	//
	// See usage example: :ref:`RateLimitQuotaFilterConfig.bucket_matchers
	// <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaFilterConfig.bucket_matchers>`.
	bucket_matchers?: v31.#Matcher
}

// Rate Limit Quota Bucket Settings to apply on the successful ``bucket_matchers`` match.
//
// Specify this message in the :ref:`Matcher.OnMatch.action
// <envoy_v3_api_field_.xds.type.matcher.v3.Matcher.OnMatch.action>` field of the
// ``bucket_matchers`` matcher tree to assign the matched requests to the Quota Bucket.
// Usage example: :ref:`RateLimitQuotaFilterConfig.bucket_matchers
// <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaFilterConfig.bucket_matchers>`.
// [#next-free-field: 6]
#RateLimitQuotaBucketSettings: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings"
	// ``BucketId`` builder.
	//
	// :ref:`BucketId <envoy_v3_api_msg_service.rate_limit_quota.v3.BucketId>` is a map from
	// the string key to the string value which serves as bucket identifier common for on
	// the control plane and the data plane.
	//
	// While ``BucketId`` is always static, ``BucketIdBuilder`` allows to populate map values
	// with the dynamic properties associated with the each individual request.
	//
	// Example 1: static fields only
	//
	// ``BucketIdBuilder``:
	//
	// .. validated-code-block:: yaml
	//   :type-name: envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.BucketIdBuilder
	//
	//   bucket_id_builder:
	//     name:
	//       string_value: my_bucket
	//     hello:
	//       string_value: world
	//
	// Produces the following ``BucketId`` for all requests:
	//
	// .. validated-code-block:: yaml
	//   :type-name: envoy.service.rate_limit_quota.v3.BucketId
	//
	//   bucket:
	//     name: my_bucket
	//     hello: world
	//
	// Example 2: static and dynamic fields
	//
	// .. validated-code-block:: yaml
	//   :type-name: envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.BucketIdBuilder
	//
	//   bucket_id_builder:
	//     name:
	//       string_value: my_bucket
	//     env:
	//       custom_value:
	//         typed_config:
	//           '@type': type.googleapis.com/envoy.type.matcher.v3.HttpRequestHeaderMatchInput
	//           header_name: environment
	//
	// In this example, the value of ``BucketId`` key ``env`` is substituted from the ``environment``
	// request header.
	//
	// This is equivalent to the following ``pseudo-code``:
	//
	// .. code-block:: yaml
	//
	//    name: 'my_bucket'
	//    env: $header['environment']
	//
	// For example, the request with the HTTP header ``env`` set to ``staging`` will produce
	// the following ``BucketId``:
	//
	// .. validated-code-block:: yaml
	//   :type-name: envoy.service.rate_limit_quota.v3.BucketId
	//
	//   bucket:
	//     name: my_bucket
	//     env: staging
	//
	// For the request with the HTTP header ``environment`` set to ``prod``, will produce:
	//
	// .. validated-code-block:: yaml
	//   :type-name: envoy.service.rate_limit_quota.v3.BucketId
	//
	//   bucket:
	//     name: my_bucket
	//     env: prod
	//
	// .. note::
	//   The order of ``BucketId`` keys do not matter. Buckets ``{ a: 'A', b: 'B' }`` and
	//   ``{ b: 'B', a: 'A' }`` are identical.
	//
	// If not set, requests will NOT be reported to the server, and will always limited
	// according to :ref:`no_assignment_behavior
	// <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.no_assignment_behavior>`
	// configuration.
	bucket_id_builder?: #RateLimitQuotaBucketSettings_BucketIdBuilder
	// The interval at which the data plane (RLQS client) is to report quota usage for this bucket.
	//
	// When the first request is matched to a bucket with no assignment, the data plane is to report
	// the request immediately in the :ref:`RateLimitQuotaUsageReports
	// <envoy_v3_api_msg_service.rate_limit_quota.v3.RateLimitQuotaUsageReports>` message.
	// For the RLQS server, this signals that the data plane is now subscribed to
	// the quota assignments in this bucket, and will start sending the assignment as described in
	// the :ref:`RLQS documentation <envoy_v3_api_file_envoy/service/rate_limit_quota/v3/rlqs.proto>`.
	//
	// After sending the initial report, the data plane is to continue reporting the bucket usage with
	// the internal specified in this field.
	// [#comment: 100000000 nanoseconds = 0.1 seconds]
	reporting_interval?: string
	// Customize the deny response to the requests over the rate limit.
	// If not set, the filter will be configured as if an empty message is set,
	// and will behave according to the defaults specified in :ref:`DenyResponseSettings
	// <envoy_v3_api_msg_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.DenyResponseSettings>`.
	deny_response_settings?: #RateLimitQuotaBucketSettings_DenyResponseSettings
	// Configures the behavior in the "no assignment" state: after the first request has been
	// matched to the bucket, and before the the RLQS server returns the first quota assignment.
	//
	// If not set, the default behavior is to allow all requests.
	no_assignment_behavior?: #RateLimitQuotaBucketSettings_NoAssignmentBehavior
	// Configures the behavior in the "expired assignment" state: the bucket's assignment has expired,
	// and cannot be refreshed.
	//
	// If not set, the bucket is abandoned when its ``active`` assignment expires.
	// The process of abandoning the bucket, and restarting the subscription is described in the
	// :ref:`AbandonAction <envoy_v3_api_msg_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.AbandonAction>`
	// message.
	expired_assignment_behavior?: #RateLimitQuotaBucketSettings_ExpiredAssignmentBehavior
}

// Configures the behavior after the first request has been matched to the bucket, and before the
// the RLQS server returns the first quota assignment.
#RateLimitQuotaBucketSettings_NoAssignmentBehavior: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings_NoAssignmentBehavior"
	// Apply pre-configured rate limiting strategy until the server sends the first assignment.
	fallback_rate_limit?: v32.#RateLimitStrategy
}

// Specifies the behavior when the bucket's assignment has expired, and cannot be refreshed for
// any reason.
#RateLimitQuotaBucketSettings_ExpiredAssignmentBehavior: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings_ExpiredAssignmentBehavior"
	// Limit the time :ref:`ExpiredAssignmentBehavior
	// <envoy_v3_api_msg_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.ExpiredAssignmentBehavior>`
	// is applied. If the server doesn't respond within this duration:
	//
	// 1. Selected ``ExpiredAssignmentBehavior`` is no longer applied.
	// 2. The bucket is abandoned. The process of abandoning the bucket is described in the
	//    :ref:`AbandonAction <envoy_v3_api_msg_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.AbandonAction>`
	//    message.
	// 3. If a new request is matched into the bucket that has become abandoned,
	//    the data plane restarts the subscription to the bucket. The process of restarting the
	//    subscription is described in the :ref:`AbandonAction
	//    <envoy_v3_api_msg_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.AbandonAction>`
	//    message.
	//
	// If the field is not set, the ``ExpiredAssignmentBehavior`` time is **not limited**:
	// it applies to the bucket until replaced by an ``active`` assignment.
	expired_assignment_behavior_timeout?: string
	// Apply the rate limiting strategy to all requests matched into the bucket until the RLQS
	// server sends a new assignment, or the :ref:`expired_assignment_behavior_timeout
	// <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.ExpiredAssignmentBehavior.expired_assignment_behavior_timeout>`
	// runs out.
	fallback_rate_limit?: v32.#RateLimitStrategy
	// Reuse the last ``active`` assignment until the RLQS server sends a new assignment, or the
	// :ref:`expired_assignment_behavior_timeout
	// <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.ExpiredAssignmentBehavior.expired_assignment_behavior_timeout>`
	// runs out.
	reuse_last_assignment?: #RateLimitQuotaBucketSettings_ExpiredAssignmentBehavior_ReuseLastAssignment
}

// Customize the deny response to the requests over the rate limit.
#RateLimitQuotaBucketSettings_DenyResponseSettings: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings_DenyResponseSettings"
	// HTTP response code to deny for HTTP requests (gRPC excluded).
	// Defaults to 429 (:ref:`StatusCode.TooManyRequests<envoy_v3_api_enum_value_type.v3.StatusCode.TooManyRequests>`).
	http_status?: v32.#HttpStatus
	// HTTP response body used to deny for HTTP requests (gRPC excluded).
	// If not set, an empty body is returned.
	http_body?: [...byte]
	// Configure the deny response for gRPC requests over the rate limit.
	// Allows to specify the `RPC status code
	// <https://cloud.google.com/natural-language/docs/reference/rpc/google.rpc#google.rpc.Code>`_,
	// and the error message.
	// Defaults to the Status with the RPC Code ``UNAVAILABLE`` and empty message.
	//
	// To identify gRPC requests, Envoy checks that the ``Content-Type`` header is
	// ``application/grpc``, or one of the various ``application/grpc+`` values.
	//
	// .. note::
	//   The HTTP code for a gRPC response is always 200.
	grpc_status?: status.#Status
	// Specifies a list of HTTP headers that should be added to each response for requests that
	// have been rate limited. Applies both to plain HTTP, and gRPC requests.
	// The headers are added even when the rate limit quota was not enforced.
	response_headers_to_add?: [...v3.#HeaderValueOption]
}

// ``BucketIdBuilder`` makes it possible to build :ref:`BucketId
// <envoy_v3_api_msg_service.rate_limit_quota.v3.BucketId>` with values substituted
// from the dynamic properties associated with each individual request. See usage examples in
// the docs to :ref:`bucket_id_builder
// <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.bucket_id_builder>`
// field.
#RateLimitQuotaBucketSettings_BucketIdBuilder: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings_BucketIdBuilder"
	// The map translated into the ``BucketId`` map.
	//
	// The ``string key`` of this map and becomes the key of ``BucketId`` map as is.
	//
	// The ``ValueBuilder value`` for the key can be:
	//
	// * static ``StringValue string_value`` — becomes the value in the ``BucketId`` map as is.
	// * dynamic ``TypedExtensionConfig custom_value`` — evaluated for each request. Must produce
	//   a string output, which becomes the value in the the ``BucketId`` map.
	//
	// See usage examples in the docs to :ref:`bucket_id_builder
	// <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.bucket_id_builder>`
	// field.
	bucket_id_builder?: [string]: #RateLimitQuotaBucketSettings_BucketIdBuilder_ValueBuilder
}

// Reuse the last known quota assignment, effectively extending it for the duration
// specified in the :ref:`expired_assignment_behavior_timeout
// <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.ExpiredAssignmentBehavior.expired_assignment_behavior_timeout>`
// field.
#RateLimitQuotaBucketSettings_ExpiredAssignmentBehavior_ReuseLastAssignment: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings_ExpiredAssignmentBehavior_ReuseLastAssignment"
}

// Produces the value of the :ref:`BucketId
// <envoy_v3_api_msg_service.rate_limit_quota.v3.BucketId>` map.
#RateLimitQuotaBucketSettings_BucketIdBuilder_ValueBuilder: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings_BucketIdBuilder_ValueBuilder"
	// Static string value — becomes the value in the :ref:`BucketId
	// <envoy_v3_api_msg_service.rate_limit_quota.v3.BucketId>` map as is.
	string_value?: string
	// Dynamic value — evaluated for each request. Must produce a string output, which becomes
	// the value in the :ref:`BucketId <envoy_v3_api_msg_service.rate_limit_quota.v3.BucketId>`
	// map. For example, extensions with the ``envoy.matching.http.input`` category can be used.
	custom_value?: v3.#TypedExtensionConfig
}
