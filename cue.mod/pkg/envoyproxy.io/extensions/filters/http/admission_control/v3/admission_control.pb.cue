package v3

import (
	v3 "envoyproxy.io/config/core/v3"
	v31 "envoyproxy.io/type/v3"
)

// [#next-free-field: 8]
#AdmissionControl: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.admission_control.v3.AdmissionControl"
	// If set to false, the admission control filter will operate as a pass-through filter. If the
	// message is unspecified, the filter will be enabled.
	enabled?:          v3.#RuntimeFeatureFlag
	success_criteria?: #AdmissionControl_SuccessCriteria
	// The sliding time window over which the success rate is calculated. The window is rounded to the
	// nearest second. Defaults to 30s.
	sampling_window?: string
	// Rejection probability is defined by the formula::
	//
	//     max(0, (rq_count -  rq_success_count / sr_threshold) / (rq_count + 1)) ^ (1 / aggression)
	//
	// The aggression dictates how heavily the admission controller will throttle requests upon SR
	// dropping at or below the threshold. A value of 1 will result in a linear increase in
	// rejection probability as SR drops. Any values less than 1.0, will be set to 1.0. If the
	// message is unspecified, the aggression is 1.0. See `the admission control documentation
	// <https://www.envoyproxy.io/docs/envoy/latest/configuration/http/http_filters/admission_control_filter.html>`_
	// for a diagram illustrating this.
	aggression?: v3.#RuntimeDouble
	// Dictates the success rate at which the rejection probability is non-zero. As success rate drops
	// below this threshold, rejection probability will increase. Any success rate above the threshold
	// results in a rejection probability of 0. Defaults to 95%.
	sr_threshold?: v3.#RuntimePercent
	// If the average RPS of the sampling window is below this threshold, the request
	// will not be rejected, even if the success rate is lower than sr_threshold.
	// Defaults to 0.
	rps_threshold?: v3.#RuntimeUInt32
	// The probability of rejection will never exceed this value, even if the failure rate is rising.
	// Defaults to 80%.
	max_rejection_probability?: v3.#RuntimePercent
}

// Default method of specifying what constitutes a successful request. All status codes that
// indicate a successful request must be explicitly specified if not relying on the default
// values.
#AdmissionControl_SuccessCriteria: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.admission_control.v3.AdmissionControl_SuccessCriteria"
	// If HTTP criteria are unspecified, all HTTP status codes below 500 are treated as successful
	// responses.
	//
	// .. note::
	//
	//    The default HTTP codes considered successful by the admission controller are done so due
	//    to the unlikelihood that sending fewer requests would change their behavior (for example:
	//    redirects, unauthorized access, or bad requests won't be alleviated by sending less
	//    traffic).
	http_criteria?: #AdmissionControl_SuccessCriteria_HttpCriteria
	// GRPC status codes to consider as request successes. If unspecified, defaults to: Ok,
	// Cancelled, Unknown, InvalidArgument, NotFound, AlreadyExists, Unauthenticated,
	// FailedPrecondition, OutOfRange, PermissionDenied, and Unimplemented.
	//
	// .. note::
	//
	//    The default gRPC codes that are considered successful by the admission controller are
	//    chosen because of the unlikelihood that sending fewer requests will change the behavior.
	grpc_criteria?: #AdmissionControl_SuccessCriteria_GrpcCriteria
}

#AdmissionControl_SuccessCriteria_HttpCriteria: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.admission_control.v3.AdmissionControl_SuccessCriteria_HttpCriteria"
	// Status code ranges that constitute a successful request. Configurable codes are in the
	// range [100, 600).
	http_success_status?: [...v31.#Int32Range]
}

#AdmissionControl_SuccessCriteria_GrpcCriteria: {
	"@type": "type.googleapis.com/envoy.extensions.filters.http.admission_control.v3.AdmissionControl_SuccessCriteria_GrpcCriteria"
	// Status codes that constitute a successful request.
	// Mappings can be found at: https://github.com/grpc/grpc/blob/master/doc/statuscodes.md.
	grpc_success_status?: [...uint32]
}
