package v3alpha

import (
	v3 "envoyproxy.io/envoy-cue/spec/config/core/v3"
)

// A CryptoMbPrivateKeyMethodConfig message specifies how the CryptoMb private
// key provider is configured. The private key provider provides “SIMD“
// processing for ECDSA sign operations and RSA sign and decrypt operations.
// The provider works by gathering the operations into a worker-thread specific
// queue, and processing the queue using “ipp-crypto“ library when the queue
// is full or when a timer expires.
// [#extension-category: envoy.tls.key_providers]
#CryptoMbPrivateKeyMethodConfig: {
	"@type": "type.googleapis.com/envoy.extensions.private_key_providers.cryptomb.v3alpha.CryptoMbPrivateKeyMethodConfig"
	// Private key to use in the private key provider. If set to inline_bytes or
	// inline_string, the value needs to be the private key in PEM format.
	private_key?: v3.#DataSource
	// How long to wait until the per-thread processing queue should be
	// processed. If the processing queue gets full (eight sign or decrypt
	// requests are received) it is processed immediately. However, if the
	// queue is not filled before the delay has expired, the requests
	// already in the queue are processed, even if the queue is not full.
	// In effect, this value controls the balance between latency and
	// throughput. The duration needs to be set to a value greater than or equal to 1 millisecond.
	poll_delay?: string
}
