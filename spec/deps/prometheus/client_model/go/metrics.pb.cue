package go

#MetricType: int32

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
	"@type":   "type.googleapis.com/github.com.prometheus.client_model.go.Counter"
	value?:    float64
	exemplar?: #Exemplar
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
}

#Untyped: {
	"@type": "type.googleapis.com/github.com.prometheus.client_model.go.Untyped"
	value?:  float64
}

#Histogram: {
	"@type":       "type.googleapis.com/github.com.prometheus.client_model.go.Histogram"
	sample_count?: uint64
	sample_sum?:   float64
	bucket?: [...#Bucket]
}

#Bucket: {
	"@type":           "type.googleapis.com/github.com.prometheus.client_model.go.Bucket"
	cumulative_count?: uint64
	upper_bound?:      float64
	exemplar?:         #Exemplar
}

#Exemplar: {
	"@type": "type.googleapis.com/github.com.prometheus.client_model.go.Exemplar"
	label?: [...#LabelPair]
	value?:     float64
	timestamp?: string
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
}
