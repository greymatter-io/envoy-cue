package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/type/v3"
)

#RateLimitQuotaUsageReports: {
	"@type": "type.googleapis.com/envoy.service.rate_limit_quota.v3.RateLimitQuotaUsageReports"
	// All quota requests must specify the domain. This enables sharing the quota
	// server between different applications without fear of overlap.
	// E.g., "envoy".
	//
	// Should only be provided in the first report, all subsequent messages on the same
	// stream are considered to be in the same domain. In case the domain needs to be
	// changes, close the stream, and reopen a new one with the different domain.
	domain?: string
	// A list of quota usage reports. The list is processed by the RLQS server in the same order
	// it's provided by the client.
	bucket_quota_usages?: [...#RateLimitQuotaUsageReports_BucketQuotaUsage]
}

#RateLimitQuotaResponse: {
	"@type": "type.googleapis.com/envoy.service.rate_limit_quota.v3.RateLimitQuotaResponse"
	// An ordered list of actions to be applied to the buckets. The actions are applied in the
	// given order, from top to bottom.
	bucket_action?: [...#RateLimitQuotaResponse_BucketAction]
}

// The identifier for the bucket. Used to match the bucket between the control plane (RLQS server),
// and the data plane (RLQS client), f.e.:
//
// * the data plane sends a usage report for requests matched into the bucket with ``BucketId``
//   to the control plane
// * the control plane sends an assignment for the bucket with ``BucketId`` to the data plane
//   Bucket ID.
//
// Example:
//
// .. validated-code-block:: yaml
//   :type-name: envoy.service.rate_limit_quota.v3.BucketId
//
//   bucket:
//     name: my_bucket
//     env: staging
//
// .. note::
//   The order of ``BucketId`` keys do not matter. Buckets ``{ a: 'A', b: 'B' }`` and
//   ``{ b: 'B', a: 'A' }`` are identical.
#BucketId: {
	"@type": "type.googleapis.com/envoy.service.rate_limit_quota.v3.BucketId"
	bucket?: [string]: string
}

// The usage report for a bucket.
//
// .. note::
//   Note that the first report sent for a ``BucketId`` indicates to the RLQS server that
//   the RLQS client is subscribing for the future assignments for this ``BucketId``.
#RateLimitQuotaUsageReports_BucketQuotaUsage: {
	"@type": "type.googleapis.com/envoy.service.rate_limit_quota.v3.RateLimitQuotaUsageReports_BucketQuotaUsage"
	// ``BucketId`` for which request quota usage is reported.
	bucket_id?: #BucketId
	// Time elapsed since the last report.
	time_elapsed?: string
	// Requests the data plane has allowed through.
	num_requests_allowed?: uint64
	// Requests throttled.
	num_requests_denied?: uint64
}

// Commands the data plane to apply one of the actions to the bucket with the
// :ref:`bucket_id <envoy_v3_api_field_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.bucket_id>`.
#RateLimitQuotaResponse_BucketAction: {
	"@type": "type.googleapis.com/envoy.service.rate_limit_quota.v3.RateLimitQuotaResponse_BucketAction"
	// ``BucketId`` for which request the action is applied.
	bucket_id?: #BucketId
	// Apply the quota assignment to the bucket.
	//
	// Commands the data plane to apply a rate limiting strategy to the bucket.
	// The process of applying and expiring the rate limiting strategy is detailed in the
	// :ref:`QuotaAssignmentAction
	// <envoy_v3_api_msg_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.QuotaAssignmentAction>`
	// message.
	quota_assignment_action?: #RateLimitQuotaResponse_BucketAction_QuotaAssignmentAction
	// Abandon the bucket.
	//
	// Commands the data plane to abandon the bucket.
	// The process of abandoning the bucket is described in the :ref:`AbandonAction
	// <envoy_v3_api_msg_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.AbandonAction>`
	// message.
	abandon_action?: #RateLimitQuotaResponse_BucketAction_AbandonAction
}

// Quota assignment for the bucket. Configures the rate limiting strategy and the duration
// for the given :ref:`bucket_id
// <envoy_v3_api_field_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.bucket_id>`.
//
// **Applying the first assignment to the bucket**
//
// Once the data plane receives the ``QuotaAssignmentAction``, it must send the current usage
// report for the bucket, and start rate limiting requests matched into the bucket
// using the strategy configured in the :ref:`rate_limit_strategy
// <envoy_v3_api_field_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.QuotaAssignmentAction.rate_limit_strategy>`
// field. The assignment becomes bucket's ``active`` assignment.
//
// **Expiring the assignment**
//
// The duration of the assignment defined in the :ref:`assignment_time_to_live
// <envoy_v3_api_field_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.QuotaAssignmentAction.assignment_time_to_live>`
// field. When the duration runs off, the assignment is ``expired``, and no longer ``active``.
// The data plane should stop applying the rate limiting strategy to the bucket, and transition
// the bucket to the "expired assignment" state. This activates the behavior configured in the
// :ref:`expired_assignment_behavior <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.expired_assignment_behavior>`
// field.
//
// **Replacing the assignment**
//
// * If the rate limiting strategy is different from bucket's ``active`` assignment, or
//   the current bucket assignment is ``expired``, the data plane must immediately
//   end the current assignment, report the bucket usage, and apply the new assignment.
//   The new assignment becomes bucket's ``active`` assignment.
// `` If the rate limiting strategy is the same as the bucket's ``active`` (not ``expired``)
//   assignment, the data plane should extend the duration of the ``active`` assignment
//   for the duration of the new assignment provided in the :ref:`assignment_time_to_live
//   <envoy_v3_api_field_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.QuotaAssignmentAction.assignment_time_to_live>`
//   field. The ``active`` assignment is considered unchanged.
#RateLimitQuotaResponse_BucketAction_QuotaAssignmentAction: {
	"@type": "type.googleapis.com/envoy.service.rate_limit_quota.v3.RateLimitQuotaResponse_BucketAction_QuotaAssignmentAction"
	// A duration after which the assignment is be considered ``expired``. The process of the
	// expiration is described :ref:`above
	// <envoy_v3_api_msg_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.QuotaAssignmentAction>`.
	//
	// * If unset, the assignment has no expiration date.
	// * If set to ``0``, the assignment expires immediately, forcing the client into the
	//   :ref:`"expired assignment"
	//   <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.ExpiredAssignmentBehavior.expired_assignment_behavior_timeout>`
	//   state. This may be used by the RLQS server in cases when it needs clients to proactively
	//   fall back to the pre-configured :ref:`ExpiredAssignmentBehavior
	//   <envoy_v3_api_msg_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.ExpiredAssignmentBehavior>`,
	//   f.e. before the server going into restart.
	//
	// .. attention::
	//   Note that :ref:`expiring
	//   <envoy_v3_api_msg_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.QuotaAssignmentAction>`
	//   the assignment is not the same as :ref:`abandoning
	//   <envoy_v3_api_msg_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.AbandonAction>`
	//   the assignment. While expiring the assignment just transitions the bucket to
	//   the "expired assignment" state; abandoning the assignment completely erases
	//   the bucket from the data plane memory, and stops the usage reports.
	assignment_time_to_live?: string
	// Configures the local rate limiter for the request matched to the bucket.
	//
	// If not set, allow all requests.
	rate_limit_strategy?: v3.#RateLimitStrategy
}

// Abandon action for the bucket. Indicates that the RLQS server will no longer be
// sending updates for the given :ref:`bucket_id
// <envoy_v3_api_field_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.bucket_id>`.
//
// If no requests are reported for a bucket, after some time the server considers the bucket
// inactive. The server stops tracking the bucket, and instructs the the data plane to abandon
// the bucket via this message.
//
// **Abandoning the assignment**
//
// The data plane is to erase the bucket (including its usage data) from the memory.
// It should stop tracking the bucket, and stop reporting its usage. This effectively resets
// the data plane to the state prior to matching the first request into the bucket.
//
// **Restarting the subscription**
//
// If a new request is matched into a bucket previously abandoned, the data plane must behave
// as if it has never tracked the bucket, and it's the first request matched into it:
//
// 1. The process of :ref:`subscription and reporting
//    <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.reporting_interval>`
//    starts from the beginning.
// 2. The bucket transitions to the :ref:`"no assignment"
//    <envoy_v3_api_field_extensions.filters.http.rate_limit_quota.v3.RateLimitQuotaBucketSettings.no_assignment_behavior>`
//    state.
// 3. Once the new assignment is received, it's applied per
//    "Applying the first assignment to the bucket" section of the :ref:`QuotaAssignmentAction
//    <envoy_v3_api_msg_service.rate_limit_quota.v3.RateLimitQuotaResponse.BucketAction.QuotaAssignmentAction>`.
#RateLimitQuotaResponse_BucketAction_AbandonAction: {
	"@type": "type.googleapis.com/envoy.service.rate_limit_quota.v3.RateLimitQuotaResponse_BucketAction_AbandonAction"
}

// RateLimitQuotaServiceClient is the client API for RateLimitQuotaService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://godoc.org/google.golang.org/grpc#ClientConn.NewStream.
#RateLimitQuotaServiceClient: _

#RateLimitQuotaService_StreamRateLimitQuotasClient: _

// RateLimitQuotaServiceServer is the server API for RateLimitQuotaService service.
#RateLimitQuotaServiceServer: _

// UnimplementedRateLimitQuotaServiceServer can be embedded to have forward compatible implementations.
#UnimplementedRateLimitQuotaServiceServer: {
	"@type": "type.googleapis.com/envoy.service.rate_limit_quota.v3.UnimplementedRateLimitQuotaServiceServer"
}

#RateLimitQuotaService_StreamRateLimitQuotasServer: _
