package v3

import (
	v3 "envoyproxy.io/envoy-cue/spec/extensions/filters/network/redis_proxy/v3"
)

#Redis: {
	"@type": "type.googleapis.com/envoy.extensions.health_checkers.redis.v3.Redis"
	// If set, optionally perform “EXISTS <key>“ instead of “PING“. A return value
	// from Redis of 0 (does not exist) is considered a passing healthcheck. A return value other
	// than 0 is considered a failure. This allows the user to mark a Redis instance for maintenance
	// by setting the specified key to any value and waiting for traffic to drain.
	key?: string
	// Use AWS IAM for health checker authentication
	aws_iam?: v3.#AwsIam
}
