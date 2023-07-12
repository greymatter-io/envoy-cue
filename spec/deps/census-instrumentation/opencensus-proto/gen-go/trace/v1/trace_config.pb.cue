package v1

// How spans should be sampled:
// - Always off
// - Always on
// - Always follow the parent Span's decision (off if no parent).
#ConstantSampler_ConstantDecision: "ALWAYS_OFF" | "ALWAYS_ON" | "ALWAYS_PARENT"

ConstantSampler_ConstantDecision_ALWAYS_OFF:    "ALWAYS_OFF"
ConstantSampler_ConstantDecision_ALWAYS_ON:     "ALWAYS_ON"
ConstantSampler_ConstantDecision_ALWAYS_PARENT: "ALWAYS_PARENT"

// Global configuration of the trace service. All fields must be specified, or
// the default (zero) values will be used for each type.
#TraceConfig: {
	"@type":                "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.TraceConfig"
	probability_sampler?:   #ProbabilitySampler
	constant_sampler?:      #ConstantSampler
	rate_limiting_sampler?: #RateLimitingSampler
	// The global default max number of attributes per span.
	max_number_of_attributes?: int64
	// The global default max number of annotation events per span.
	max_number_of_annotations?: int64
	// The global default max number of message events per span.
	max_number_of_message_events?: int64
	// The global default max number of link entries per span.
	max_number_of_links?: int64
}

// Sampler that tries to uniformly sample traces with a given probability.
// The probability of sampling a trace is equal to that of the specified probability.
#ProbabilitySampler: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.ProbabilitySampler"
	// The desired probability of sampling. Must be within [0.0, 1.0].
	samplingProbability?: float64
}

// Sampler that always makes a constant decision on span sampling.
#ConstantSampler: {
	"@type":   "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.ConstantSampler"
	decision?: #ConstantSampler_ConstantDecision
}

// Sampler that tries to sample with a rate per time window.
#RateLimitingSampler: {
	"@type": "type.googleapis.com/github.com.census-instrumentation.opencensus-proto.gen-go.trace.v1.RateLimitingSampler"
	// Rate per second.
	qps?: int64
}
