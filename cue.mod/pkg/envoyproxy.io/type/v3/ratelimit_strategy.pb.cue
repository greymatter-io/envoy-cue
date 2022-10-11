package v3

// Choose between allow all and deny all.
#RateLimitStrategy_BlanketRule: "ALLOW_ALL" | "DENY_ALL"

RateLimitStrategy_BlanketRule_ALLOW_ALL: "ALLOW_ALL"
RateLimitStrategy_BlanketRule_DENY_ALL:  "DENY_ALL"

#RateLimitStrategy: {
	"@type": "type.googleapis.com/envoy.type.v3.RateLimitStrategy"
	// Allow or Deny the requests.
	// If unset, allow all.
	blanket_rule?: #RateLimitStrategy_BlanketRule
	// Best-effort limit of the number of requests per time unit, f.e. requests per second.
	// Does not prescribe any specific rate limiting algorithm, see :ref:`RequestsPerTimeUnit
	// <envoy_v3_api_msg_type.v3.RateLimitStrategy.RequestsPerTimeUnit>` for details.
	requests_per_time_unit?: #RateLimitStrategy_RequestsPerTimeUnit
	// Limit the requests by consuming tokens from the Token Bucket.
	// Allow the same number of requests as the number of tokens available in
	// the token bucket.
	token_bucket?: #TokenBucket
}

// Best-effort limit of the number of requests per time unit.
//
// Allows to specify the desired requests per second (RPS, QPS), requests per minute (QPM, RPM),
// etc., without specifying a rate limiting algorithm implementation.
//
// ``RequestsPerTimeUnit`` strategy does not demand any specific rate limiting algorithm to be
// used (in contrast to the :ref:`TokenBucket <envoy_v3_api_msg_type.v3.TokenBucket>`,
// for example). It implies that the implementation details of rate limiting algorithm are
// irrelevant as long as the configured number of "requests per time unit" is achieved.
//
// Note that the ``TokenBucket`` is still a valid implementation of the ``RequestsPerTimeUnit``
// strategy, and may be chosen to enforce the rate limit. However, there's no guarantee it will be
// the ``TokenBucket`` in particular, and not the Leaky Bucket, the Sliding Window, or any other
// rate limiting algorithm that fulfills the requirements.
#RateLimitStrategy_RequestsPerTimeUnit: {
	"@type": "type.googleapis.com/envoy.type.v3.RateLimitStrategy_RequestsPerTimeUnit"
	// The desired number of requests per :ref:`time_unit
	// <envoy_v3_api_field_type.v3.RateLimitStrategy.RequestsPerTimeUnit.time_unit>` to allow.
	// If set to ``0``, deny all (equivalent to ``BlanketRule.DENY_ALL``).
	//
	// .. note::
	//   Note that the algorithm implementation determines the course of action for the requests
	//   over the limit. As long as the ``requests_per_time_unit`` converges on the desired value,
	//   it's allowed to treat this field as a soft-limit: allow bursts, redistribute the allowance
	//   over time, etc.
	//
	requests_per_time_unit?: uint64
	// The unit of time. Ignored when :ref:`requests_per_time_unit
	// <envoy_v3_api_field_type.v3.RateLimitStrategy.RequestsPerTimeUnit.requests_per_time_unit>`
	// is ``0`` (deny all).
	time_unit?: #RateLimitUnit
}
