package go

import (
	timestamppb "envoyproxy.io/deps/protobuf/types/known/timestamppb"
)

#MetricType: "COUNTER" | "GAUGE" | "SUMMARY" | "UNTYPED" | "HISTOGRAM" | "GAUGE_HISTOGRAM"

MetricType_COUNTER:         "COUNTER"
MetricType_GAUGE:           "GAUGE"
MetricType_SUMMARY:         "SUMMARY"
MetricType_UNTYPED:         "UNTYPED"
MetricType_HISTOGRAM:       "HISTOGRAM"
MetricType_GAUGE_HISTOGRAM: "GAUGE_HISTOGRAM"

#LabelPair: {
	"@type": "type.googleapis.com/github.com.prometheus.client_model.go.LabelPair"
	name?:   string
	value?:  string
}

#Gauge: {
	"@type": "type.googleapis.com/github.com.prometheus.client_model.go.Gauge"
	value?:  float64
}

#Counter: {
	"@type":            "type.googleapis.com/github.com.prometheus.client_model.go.Counter"
	value?:             float64
	exemplar?:          #Exemplar
	created_timestamp?: timestamppb.#Timestamp
}

#Quantile: {
	"@type":   "type.googleapis.com/github.com.prometheus.client_model.go.Quantile"
	quantile?: float64
	value?:    float64
}

#Summary: {
	"@type":       "type.googleapis.com/github.com.prometheus.client_model.go.Summary"
	sample_count?: uint64
	sample_sum?:   float64
	quantile?: [...#Quantile]
	created_timestamp?: timestamppb.#Timestamp
}

#Untyped: {
	"@type": "type.googleapis.com/github.com.prometheus.client_model.go.Untyped"
	value?:  float64
}

#Histogram: {
	"@type":             "type.googleapis.com/github.com.prometheus.client_model.go.Histogram"
	sample_count?:       uint64
	sample_count_float?: float64
	sample_sum?:         float64
	// Buckets for the conventional histogram.
	bucket?: [...#Bucket]
	created_timestamp?: timestamppb.#Timestamp
	// schema defines the bucket schema. Currently, valid numbers are -4 <= n <= 8.
	// They are all for base-2 bucket schemas, where 1 is a bucket boundary in each case, and
	// then each power of two is divided into 2^n logarithmic buckets.
	// Or in other words, each bucket boundary is the previous boundary times 2^(2^-n).
	// In the future, more bucket schemas may be added using numbers < -4 or > 8.
	schema?:           int32
	zero_threshold?:   float64
	zero_count?:       uint64
	zero_count_float?: float64
	// Negative buckets for the native histogram.
	negative_span?: [...#BucketSpan]
	// Use either "negative_delta" or "negative_count", the former for
	// regular histograms with integer counts, the latter for float
	// histograms.
	negative_delta?: [...int64]
	negative_count?: [...float64]
	// Positive buckets for the native histogram.
	// Use a no-op span (offset 0, length 0) for a native histogram without any
	// observations yet and with a zero_threshold of 0. Otherwise, it would be
	// indistinguishable from a classic histogram.
	positive_span?: [...#BucketSpan]
	// Use either "positive_delta" or "positive_count", the former for
	// regular histograms with integer counts, the latter for float
	// histograms.
	positive_delta?: [...int64]
	positive_count?: [...float64]
	// Only used for native histograms. These exemplars MUST have a timestamp.
	exemplars?: [...#Exemplar]
}

// A Bucket of a conventional histogram, each of which is treated as
// an individual counter-like time series by Prometheus.
#Bucket: {
	"@type":                 "type.googleapis.com/github.com.prometheus.client_model.go.Bucket"
	cumulative_count?:       uint64
	cumulative_count_float?: float64
	upper_bound?:            float64
	exemplar?:               #Exemplar
}

// A BucketSpan defines a number of consecutive buckets in a native
// histogram with their offset. Logically, it would be more
// straightforward to include the bucket counts in the Span. However,
// the protobuf representation is more compact in the way the data is
// structured here (with all the buckets in a single array separate
// from the Spans).
#BucketSpan: {
	"@type": "type.googleapis.com/github.com.prometheus.client_model.go.BucketSpan"
	offset?: int32
	length?: uint32
}

#Exemplar: {
	"@type": "type.googleapis.com/github.com.prometheus.client_model.go.Exemplar"
	label?: [...#LabelPair]
	value?:     float64
	timestamp?: timestamppb.#Timestamp
}

#Metric: {
	"@type": "type.googleapis.com/github.com.prometheus.client_model.go.Metric"
	label?: [...#LabelPair]
	gauge?:        #Gauge
	counter?:      #Counter
	summary?:      #Summary
	untyped?:      #Untyped
	histogram?:    #Histogram
	timestamp_ms?: int64
}

#MetricFamily: {
	"@type": "type.googleapis.com/github.com.prometheus.client_model.go.MetricFamily"
	name?:   string
	help?:   string
	type?:   #MetricType
	metric?: [...#Metric]
	unit?: string
}
