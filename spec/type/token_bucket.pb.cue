package type

// Configures a token bucket, typically used for rate limiting.
#TokenBucket: {
	"@type": "type.googleapis.com/envoy.type.TokenBucket"
	// The maximum tokens that the bucket can hold. This is also the number of tokens that the bucket
	// initially contains.
	max_tokens?: uint32
	// The number of tokens added to the bucket during each fill interval. If not specified, defaults
	// to a single token.
	tokens_per_fill?: uint32
	// The fill interval that tokens are added to the bucket. During each fill interval
	// `tokens_per_fill` are added to the bucket. The bucket will never contain more than
	// `max_tokens` tokens.
	fill_interval?: string
}
